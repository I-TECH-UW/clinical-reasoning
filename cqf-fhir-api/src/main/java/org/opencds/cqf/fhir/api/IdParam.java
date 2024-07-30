package org.opencds.cqf.fhir.api;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface IdParam {

    /**
     * For {@link Operation extended operations}, any parameter with this value set to <code>true</code>
     * (default is false) will also be invoked if the operation is invoked against the resource type.
     */
    boolean optional() default false;
}
