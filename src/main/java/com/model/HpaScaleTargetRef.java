package com.model;

public class HpaScaleTargetRef {
   private String apiVersion;
   private String kind;
   private String name;

    public String getApiVersion() {
        return apiVersion;
    }

    public HpaScaleTargetRef withApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
        return this;
    }

    public String getKind() {
        return kind;
    }

    public HpaScaleTargetRef withKind(String kind) {
        this.kind = kind;
        return this;
    }

    public String getName() {
        return name;
    }

    public HpaScaleTargetRef withName(String name) {
        this.name = name;
        return this;
    }
}
