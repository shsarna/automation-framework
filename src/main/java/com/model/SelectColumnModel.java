package com.model;

public class SelectColumnModel {
    public SelectColumnModel() {
    }

    private String columnName;

    private String columnValue;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnValue() {
        return columnValue;
    }

    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }

    private SelectColumnModel(Builder builder) {
        columnName = builder.columnName;
        columnValue = builder.columnValue;
    }

    public static Builder newBuilder() {
        return new Builder();
    }

    public static final class Builder {
        private String columnName;
        private String columnValue;

        private Builder() {
        }

        public Builder withColumnName(String val) {
            columnName = val;
            return this;
        }

        public Builder withColumnValue(String val) {
            columnValue = val;
            return this;
        }

        public SelectColumnModel build() {
            return new SelectColumnModel(this);
        }
    }
}
