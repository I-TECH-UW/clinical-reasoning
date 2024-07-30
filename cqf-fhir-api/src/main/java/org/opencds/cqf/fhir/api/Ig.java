package org.opencds.cqf.fhir.api;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Ig {
    String name();

    String url() default "";

    String version() default "";

    String fhirVersion() default "";

    String description() default "";
}
