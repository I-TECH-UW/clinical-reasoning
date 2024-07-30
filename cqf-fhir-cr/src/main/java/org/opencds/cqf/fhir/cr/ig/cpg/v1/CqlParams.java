package org.opencds.cqf.fhir.cr.ig.cpg.v1;

import java.util.List;
import org.hl7.fhir.r4.model.BooleanType;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Endpoint;
import org.hl7.fhir.r4.model.Parameters;
import org.opencds.cqf.fhir.api.OperationParam;

public class CqlParams {
    @OperationParam
    String subject;

    @OperationParam(max = 1)
    String expression;

    @OperationParam(max = 1)
    Parameters parameters;

    @OperationParam
    List<Parameters> library;

    @OperationParam(max = 1)
    BooleanType useServerData;

    @OperationParam(max = 1)
    Bundle data;

    @OperationParam
    List<Parameters> prefetchData;

    @OperationParam(max = 1)
    Endpoint dataEndpoint;

    @OperationParam(max = 1)
    Endpoint contentEndpoint;

    @OperationParam(max = 1)
    Endpoint terminologyEndpoint;

    @OperationParam(max = 1)
    String content;
}
