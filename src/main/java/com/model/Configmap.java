package com.model;

import java.util.Map;

public class Configmap {

    private String kind;
    private String apiVersion;
    private ConfigmapMetadata metadata;
    private Map<String, String> data;

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

    public ConfigmapMetadata getMetadata() {
        return metadata;
    }

    public void setMetadata(ConfigmapMetadata metadata) {
        this.metadata = metadata;
    }

    public Map<String, String> getData() {
        return data;
    }

    public void setData(Map<String, String> data) {
        this.data = data;
    }
}
