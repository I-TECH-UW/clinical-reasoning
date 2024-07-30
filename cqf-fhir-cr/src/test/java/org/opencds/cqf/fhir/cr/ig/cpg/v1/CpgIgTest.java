package org.opencds.cqf.fhir.cr.ig.cpg.v1;

import static org.junit.Assert.assertNotNull;
import static org.opencds.cqf.fhir.utility.r4.Parameters.*;

import ca.uhn.fhir.context.FhirContext;

import java.beans.BeanProperty;
import java.nio.file.Path;
import java.rmi.server.Operation;

import org.checkerframework.checker.units.qual.C;
import org.checkerframework.framework.qual.ConditionalPostconditionAnnotation;
import org.junit.Test;
import org.opencds.cqf.fhir.utility.operation.OperationRegistry;
import org.opencds.cqf.fhir.utility.repository.ig.EncodingBehavior;
import org.opencds.cqf.fhir.utility.repository.ig.IgConventions;
import org.opencds.cqf.fhir.utility.repository.ig.IgRepository;

public class CpgIgTest {

    @Bean
    CpgSetting cpgSettings() {
        // get from .yaml file
        return new CpgSettings();
    }

    @Bean
    OperationRegistry opRegistry() {
        return new OperationRegistry();
    }

    @Conditional(cpgEnabled = true) 
    @Bean
    OperationRegistry cpgProvider(OperationRegistry operationRegistry, CpgSettings settings) {
        operationRegistry.register(CqgService.class, r -> new CpgService(r, settings));

        return operationRegistry;
    }

    @Bean
    Repository hapiRepository(OperationRegistry registry, DaoConfig config) {
        return new HapiRepository(OperationRegistry registry, DaoConfig config);
    }

    @Test
    public void testEvaluate() {
        var ops = new OperationRegistry();
        var settings = new CpgSettings();
        ops.register(CpgService.class, r -> new CpgService(r, settings));

        var repo = new IgRepository(
                FhirContext.forR4Cached(),
                Path.of(""),
                IgConventions.autoDetect(Path.of("")),
                EncodingBehavior.DEFAULT,
                ops);

        var result = repo.invoke(
                "$cql", 
                parameters(
                    stringPart("subject", "Patient/123"), 
                    stringPart("expression", "Some Definition")));

        assertNotNull(result);
    }
}
