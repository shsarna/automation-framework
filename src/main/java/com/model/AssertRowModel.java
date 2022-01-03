package com.model;

import java.util.List;

public class AssertRowModel {
    public AssertRowModel() {
    }

    private List<AssertColumnModel> assertColumnModels;
    private List<SelectColumnModel> selectColumnModels;

    public List<AssertColumnModel> getAssertColumnModels() {
        return assertColumnModels;
    }

    public void setAssertColumnModels(List<AssertColumnModel> assertColumnModels) {
        this.assertColumnModels = assertColumnModels;
    }

    public List<SelectColumnModel> getSelectColumnModels() {
        return selectColumnModels;
    }

    public void setSelectColumnModels(List<SelectColumnModel> selectColumnModels) {
        this.selectColumnModels = selectColumnModels;
    }

    private AssertRowModel(Builder builder) {
        assertColumnModels = builder.columnAssertModels;
        selectColumnModels = builder.selectColumnModels;
    }

    public static Builder newBuilder() {
        return new Builder();
    }

    public static final class Builder {
        private List<AssertColumnModel> columnAssertModels;
        private List<SelectColumnModel> selectColumnModels;

        private Builder() {
        }

        public Builder withColumnAssertModels(List<AssertColumnModel> val) {
            columnAssertModels = val;
            return this;
        }

        public Builder withColumnSelectModels(List<SelectColumnModel> val) {
            selectColumnModels = val;
            return this;
        }

        public AssertRowModel build() {
            return new AssertRowModel(this);
        }
    }
}
