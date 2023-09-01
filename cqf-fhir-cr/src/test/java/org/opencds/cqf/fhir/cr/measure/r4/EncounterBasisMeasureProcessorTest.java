package org.opencds.cqf.fhir.cr.measure.r4;

import org.opencds.cqf.fhir.cr.measure.r4.Measure.Given;
import org.junit.jupiter.api.Test;

public class EncounterBasisMeasureProcessorTest {
  protected static Given given =
      Measure.given().repositoryFor("DischargedonAntithromboticTherapyFHIR");

  @Test
  public void exm104_singlePatient() {
    given.when()
        .measureId("DischargedonAntithromboticTherapyFHIR")
        .periodStart("2019-01-01")
        .periodEnd("2020-01-01")
        .subject("Patient/numer-EXM104")
        .reportType("subject")
        .evaluate()
        .then()
        .firstGroup()
        .population("initial-population").hasCount(1);
  }
}