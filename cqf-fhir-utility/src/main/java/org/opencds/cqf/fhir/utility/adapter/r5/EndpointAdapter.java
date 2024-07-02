package org.opencds.cqf.fhir.utility.adapter.r5;

import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r5.model.Endpoint;

public class EndpointAdapter extends ResourceAdapter implements org.opencds.cqf.fhir.utility.adapter.EndpointAdapter {
    private final Endpoint endpoint;

    public EndpointAdapter(IBaseResource endpoint) {
        super(endpoint);
        if (!(endpoint instanceof Endpoint)) {
            throw new IllegalArgumentException("resource passed as endpoint argument is not an Endpoint resource");
        }
        this.endpoint = (Endpoint) endpoint;
    }

    public EndpointAdapter(Endpoint endpoint) {
        super(endpoint);
        this.endpoint = endpoint;
    }

    public Endpoint getEndpoint() {
        return endpoint;
    }

    @Override
    public String getAddress() {
        return endpoint.getAddress();
    }

    @Override
    public EndpointAdapter setAddress(String address) {
        endpoint.setAddress(address);
        return this;
    }
}