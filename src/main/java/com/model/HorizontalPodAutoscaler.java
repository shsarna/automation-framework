package com.model;

import java.util.Map;

public class HorizontalPodAutoscaler {
    private String kind;
    private String apiVersion;
    private HpaMetadata metadata;
    private HpaSpec spec;

    public String getKind() {
        return kind;
    }

    public HorizontalPodAutoscaler setKind(String kind) {
        this.kind = kind;
        return this;
    }

    public String getApiVersion() {
        return apiVersion;
    }

    public HorizontalPodAutoscaler setApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
        return this;
    }

    public HpaMetadata getMetadata() {
        return metadata;
    }

    public HorizontalPodAutoscaler setMetadata(HpaMetadata metadata) {
        this.metadata = metadata;
        return this;
    }

    public HpaSpec getSpec() {
        return spec;
    }

    public HorizontalPodAutoscaler setSpec(HpaSpec spec) {
        this.spec = spec;
        return this;
    }
}
