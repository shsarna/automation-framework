package com.model;

public class AssertCountModel {

    private String selectStatement;

    private int expectedCount;

    public String getSelectStatement() {
        return selectStatement;
    }

    public AssertCountModel setSelectStatement(String selectStatement) {
        this.selectStatement = selectStatement;
        return this;
    }

    public int getExpectedCount() {
        return expectedCount;
    }

    public AssertCountModel setExpectedCount(int expectedCount) {
        this.expectedCount = expectedCount;
        return this;
    }
}
