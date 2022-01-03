package com.model;

import java.util.Map;

public class HpaMetadata {
    private String name;
    private String namespace;
    private String selfLink;
    private String uid;
    private Map<String, String> labels;
    private Map<String, String> annotations;

    public String getName() {
        return name;
    }

    public HpaMetadata setName(String name) {
        this.name = name;
        return this;
    }

    public String getNamespace() {
        return namespace;
    }

    public HpaMetadata setNamespace(String namespace) {
        this.namespace = namespace;
        return this;
    }

    public String getSelfLink() {
        return selfLink;
    }

    public HpaMetadata setSelfLink(String selfLink) {
        this.selfLink = selfLink;
        return this;
    }

    public String getUid() {
        return uid;
    }

    public HpaMetadata setUid(String uid) {
        this.uid = uid;
        return this;
    }

    public Map<String, String> getLabels() {
        return labels;
    }

    public HpaMetadata setLabels(Map<String, String> labels) {
        this.labels = labels;
        return this;
    }

    public Map<String, String> getAnnotations() {
        return annotations;
    }

    public HpaMetadata setAnnotations(Map<String, String> annotations) {
        this.annotations = annotations;
        return this;
    }
}
