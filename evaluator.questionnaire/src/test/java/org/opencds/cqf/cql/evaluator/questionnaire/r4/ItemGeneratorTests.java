package org.opencds.cqf.cql.evaluator.questionnaire.r4;

import static org.opencds.cqf.cql.evaluator.fhir.util.r4.Parameters.parameters;
import static org.opencds.cqf.cql.evaluator.fhir.util.r4.Parameters.stringPart;

import org.opencds.cqf.cql.evaluator.fhir.test.TestRepositoryFactory;
import org.testng.annotations.Test;

import ca.uhn.fhir.context.FhirContext;

public class ItemGeneratorTests {
  @Test
  void testGenerateItem() {
    var repository =
        TestRepositoryFactory.createRepository(FhirContext.forR4Cached(), this.getClass());
    TestItemGenerator.Assert.that("Patient",
        "http://fhir.org/guides/cdc/opioid-cds/StructureDefinition/RouteOnePatient", "OPA-Patient1")
        .withRepository(repository)
        .generateItem().isEqualsTo("Questionnaire-RouteOnePatient.json");
  }

  @Test
  void testSleepStudyOrder() {
    var repository =
        TestRepositoryFactory.createRepository(FhirContext.forR4Cached(),
            this.getClass(), "pa-aslp");
    TestItemGenerator.Assert.that("ServiceRequest",
        "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-sleep-study-order", "positive")
        .withRepository(repository)
        .withParameters(parameters(stringPart("Service Request Id", "SleepStudy"),
            stringPart("Service Request Id", "SleepStudy2"),
            stringPart("Coverage Id", "Coverage-positive")))
        .generateItem().isEqualsTo("Questionnaire-aslp-sleep-study-order.json");
  }
}
