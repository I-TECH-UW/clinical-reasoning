package org.opencds.cqf.fhir.cr.ig.cpg.v1;

import java.util.List;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Endpoint;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.Parameters;
import org.opencds.cqf.fhir.api.IdParam;
import org.opencds.cqf.fhir.api.OperationParam;

public class LibraryEvaluateParams {
    @IdParam
    IdType id;

    @OperationParam
    String subject;

    @OperationParam
    List<String> expression;

    @OperationParam
    Parameters parameters;

    @OperationParam
    Bundle data;

    @OperationParam
    List<Parameters> prefetchData;

    @OperationParam
    Endpoint dataEndpoint;

    @OperationParam
    Endpoint contentEndpoint;

    @OperationParam
    Endpoint terminologyEndpoint;
}
