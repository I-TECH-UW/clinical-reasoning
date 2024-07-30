package org.opencds.cqf.fhir.cr.ig.cpg.v1;

import org.hl7.fhir.r4.model.Parameters;
import org.opencds.cqf.fhir.api.Repository;
import org.opencds.cqf.fhir.cr.cql.r4.R4CqlExecutionService;
import org.opencds.cqf.fhir.cr.cql.r4.R4LibraryEvaluationService;

public class CpgService implements CpgIg {

    private Repository repository;
    private CpgSettings settings;

    public CpgService(Repository repository, CpgSettings settings) {
        this.repository = repository;
        this.settings = settings;
    }

    @Override
    public Parameters evaluate(LibraryEvaluateParams params) {
        var lib = new R4LibraryEvaluationService(repository, settings.evaluationSettings);
        return lib.evaluate(
                params.id,
                params.subject,
                params.expression,
                params.parameters,
                params.data,
                params.prefetchData,
                params.dataEndpoint,
                params.contentEndpoint,
                params.terminologyEndpoint);
    }

    @Override
    public Parameters evaluate(CqlParams params) {
        var cql = new R4CqlExecutionService(repository, settings.evaluationSettings);
        return cql.evaluate(
                params.subject,
                params.expression,
                params.parameters,
                params.library,
                params.useServerData,
                params.data,
                params.prefetchData,
                params.dataEndpoint,
                params.contentEndpoint,
                params.terminologyEndpoint,
                params.content);
    }
}
