package org.opencds.cqf.cql.evaluator.questionnaire.r5.helpers;

import static org.junit.jupiter.api.Assertions.fail;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r5.model.Bundle;
import org.hl7.fhir.r5.model.IdType;
import org.hl7.fhir.r5.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r5.model.Bundle.BundleType;
import org.hl7.fhir.r5.model.Enumerations.FHIRTypes;
import org.hl7.fhir.r5.model.Parameters;
import org.hl7.fhir.r5.model.Questionnaire;
import org.hl7.fhir.r5.model.QuestionnaireResponse;
import org.hl7.fhir.r5.model.Resource;
import org.json.JSONException;
import org.opencds.cqf.cql.evaluator.questionnaire.r5.QuestionnaireProcessor;
import org.opencds.cqf.fhir.api.Repository;
import org.opencds.cqf.fhir.cql.EvaluationSettings;
import org.opencds.cqf.fhir.cql.LibraryEngine;
import org.opencds.cqf.fhir.utility.repository.IGFileStructureRepository;
import org.opencds.cqf.fhir.utility.repository.IGLayoutMode;
import org.skyscreamer.jsonassert.JSONAssert;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.context.FhirVersionEnum;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.EncodingEnum;

public class TestQuestionnaire {
  private static final FhirContext fhirContext = FhirContext.forCached(FhirVersionEnum.R5);
  private static final IParser jsonParser = fhirContext.newJsonParser().setPrettyPrint(true);
  private static final EvaluationSettings evaluationSettings = EvaluationSettings.getDefault();

  private static InputStream open(String asset) {
    return TestQuestionnaire.class.getResourceAsStream(asset);
  }

  public static String load(InputStream asset) throws IOException {
    return new String(asset.readAllBytes(), StandardCharsets.UTF_8);
  }

  public static String load(String asset) throws IOException {
    return load(open(asset));
  }

  public static IBaseResource parse(String asset) {
    return jsonParser.parseResource(open(asset));
  }

  public static QuestionnaireProcessor buildProcessor(Repository repository) {
    return new QuestionnaireProcessor(repository, evaluationSettings);
  }

  /** Fluent interface starts here **/

  public static class Assert {
    public static QuestionnaireResult that(String questionnaireName, String patientId) {
      return new QuestionnaireResult(questionnaireName, patientId);
    }

    public static QuestionnaireResult that(IdType theId, String thePatientId) {
      return new QuestionnaireResult(theId, thePatientId);
    }
  }

  public static class QuestionnaireResult {
    private IdType questionnaireId;
    private Questionnaire questionnaire;
    private String patientId;
    private Repository repository;
    private Bundle bundle;
    private Parameters parameters;

    private final FhirContext fhirContext = FhirContext.forR5Cached();

    public QuestionnaireResult(String questionnaireName, String patientId) {
      questionnaire = questionnaireName.isEmpty() ? null : (Questionnaire) parse(questionnaireName);
      questionnaireId = null;
      this.patientId = patientId;
    }

    public QuestionnaireResult(IdType theId, String thePatientId) {
      questionnaire = null;
      questionnaireId = theId;
      patientId = thePatientId;
    }

    public QuestionnaireResult withAdditionalData(String dataAssetName) {
      var data = parse(dataAssetName);
      bundle =
          data.getIdElement().getResourceType().equals(FHIRTypes.BUNDLE.toCode()) ? (Bundle) data
              : new Bundle().setType(BundleType.COLLECTION)
                  .addEntry(new BundleEntryComponent().setResource((Resource) data));

      return this;
    }

    public QuestionnaireResult withParameters(Parameters params) {
      parameters = params;

      return this;
    }

    public QuestionnaireResult withRepository(Repository repository) {
      this.repository = repository;

      return this;
    }

    private void buildRepository() {
      if (repository == null) {
        repository = new IGFileStructureRepository(this.fhirContext,
            this.getClass().getProtectionDomain().getCodeSource().getLocation().getPath()
                + "org/opencds/cqf/cql/evaluator/questionnaire/r5",
            IGLayoutMode.TYPE_PREFIX, EncodingEnum.JSON);
      }

      if (questionnaire == null) {
        try {
          questionnaire = repository.read(Questionnaire.class, questionnaireId);
        } catch (Exception e) {
        }
      }
    }

    public GeneratedQuestionnaire prePopulate() {
      buildRepository();
      var libraryEngine = new LibraryEngine(repository, evaluationSettings);
      return new GeneratedQuestionnaire(buildProcessor(this.repository).prePopulate(questionnaire,
          patientId, parameters, bundle, libraryEngine));
    }

    public GeneratedQuestionnaireResponse populate() {
      buildRepository();
      var libraryEngine = new LibraryEngine(repository, evaluationSettings);
      return new GeneratedQuestionnaireResponse(
          (QuestionnaireResponse) buildProcessor(this.repository).populate(questionnaire,
              patientId,
              parameters, bundle, libraryEngine));
    }

    public Bundle questionnairePackage() {
      buildRepository();
      return buildProcessor(repository).packageQuestionnaire(questionnaire, true);
    }
  }

  public static class GeneratedQuestionnaire {
    Questionnaire questionnaire;

    public GeneratedQuestionnaire(Questionnaire questionnaire) {
      this.questionnaire = questionnaire;
    }

    public void isEqualsTo(String expectedQuestionnaireAssetName) {
      try {
        JSONAssert.assertEquals(load(expectedQuestionnaireAssetName),
            jsonParser.encodeResourceToString(questionnaire), true);
      } catch (JSONException | IOException e) {
        e.printStackTrace();
        fail("Unable to compare Jsons: " + e.getMessage());
      }
    }
  }

  public static class GeneratedQuestionnaireResponse {
    QuestionnaireResponse questionnaireResponse;

    public GeneratedQuestionnaireResponse(QuestionnaireResponse questionnaireResponse) {
      this.questionnaireResponse = questionnaireResponse;
    }

    public void isEqualsTo(String expectedQuestionnaireResponseAssetName) {
      try {
        JSONAssert.assertEquals(load(expectedQuestionnaireResponseAssetName),
            jsonParser.encodeResourceToString(questionnaireResponse), true);
      } catch (JSONException | IOException e) {
        e.printStackTrace();
        fail("Unable to compare Jsons: " + e.getMessage());
      }
    }
  }
}