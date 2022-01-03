package com.model;

public class HpaSpec {
    private int minReplicas;
    private int maxReplicas;
    private int targetCPUUtilizationPercentage;
    private HpaScaleTargetRef scaleTargetRef;

    public int getMinReplicas() {
        return minReplicas;
    }

    public HpaSpec setMinReplicas(int minReplicas) {
        this.minReplicas = minReplicas;
        return this;
    }

    public int getMaxReplicas() {
        return maxReplicas;
    }

    public HpaSpec setMaxReplicas(int maxReplicas) {
        this.maxReplicas = maxReplicas;
        return this;
    }

    public int getTargetCPUUtilizationPercentage() {
        return targetCPUUtilizationPercentage;
    }

    public HpaSpec setTargetCPUUtilizationPercentage(int targetCPUUtilizationPercentage) {
        this.targetCPUUtilizationPercentage = targetCPUUtilizationPercentage;
        return this;
    }

    public HpaScaleTargetRef getScaleTargetRef() {
        return scaleTargetRef;
    }

    public void setScaleTargetRef(HpaScaleTargetRef scaleTargetRef) {
        this.scaleTargetRef = scaleTargetRef;
    }
}
