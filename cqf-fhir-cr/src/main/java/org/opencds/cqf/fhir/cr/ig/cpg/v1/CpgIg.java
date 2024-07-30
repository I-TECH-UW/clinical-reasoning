package org.opencds.cqf.fhir.cr.ig.cpg.v1;

import ca.uhn.fhir.model.api.annotation.Description;
import ca.uhn.fhir.rest.annotation.Operation;
import org.hl7.fhir.r4.model.Library;
import org.hl7.fhir.r4.model.Parameters;
import org.opencds.cqf.fhir.api.Ig;

@Ig(
        name = "cpg",
        url = "https://hl7.org/fhir/uv/cpg/STU1",
        version = "1.0.0",
        fhirVersion = "4.0.1",
        description = "FHIR Clinical Guidelines Implementation Guide")
public interface CpgIg {

    @Operation(name = "$evaluate", idempotent = true, type = Library.class)
    public Parameters evaluate(LibraryEvaluateParams params);

    @Operation(name = "$cql", idempotent = true)
    @Description(
            shortDefinition = "$cql",
            value =
                    "Evaluates a CQL expression and returns the results as a Parameters resource. Defined: http://build.fhir.org/ig/HL7/cqf-recommendations/OperationDefinition-cpg-cql.html",
            example = "$cql?expression=5*5")
    public Parameters evaluate(CqlParams params);
}
