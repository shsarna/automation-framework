package com.model;

import java.util.Map;

public class Scale {
    private String kind;
    private String apiVersion;
    private Map<String, String> metadata;
    private ScaleSpec spec;

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getApiVersion() {
        return apiVersion;
    }

    public void setApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
    }

    public Map<String, String> getMetadata() {
        return metadata;
    }

    public void setMetadata(Map<String, String> metadata) {
        this.metadata = metadata;
    }

    public ScaleSpec getSpec() {
        return spec;
    }

    public void setSpec(ScaleSpec spec) {
        this.spec = spec;
    }

}
