package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Object that holds the information regarding a queried content.
 */
@ApiModel(description = "Object that holds the information regarding a queried content.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceQueryObjectSchema   {
  @JsonProperty("queryId")
  private BigDecimal queryId = null;

  @JsonProperty("queryResult")
  @Valid
  private List<OaContentServiceQueryDataObjectSchema> queryResult = null;

  public OaContentServiceQueryObjectSchema queryId(BigDecimal queryId) {
    this.queryId = queryId;
    return this;
  }

  /**
   * Unique Id of the query.
   * @return queryId
  **/
  @ApiModelProperty(required = true, value = "Unique Id of the query.")
  @NotNull

  @Valid
  public BigDecimal getQueryId() {
    return queryId;
  }

  public void setQueryId(BigDecimal queryId) {
    this.queryId = queryId;
  }

  public OaContentServiceQueryObjectSchema queryResult(List<OaContentServiceQueryDataObjectSchema> queryResult) {
    this.queryResult = queryResult;
    return this;
  }

  public OaContentServiceQueryObjectSchema addQueryResultItem(OaContentServiceQueryDataObjectSchema queryResultItem) {
    if (this.queryResult == null) {
      this.queryResult = new ArrayList<>();
    }
    this.queryResult.add(queryResultItem);
    return this;
  }

  /**
   * Get queryResult
   * @return queryResult
  **/
  @ApiModelProperty(value = "")
  @Valid
  public List<OaContentServiceQueryDataObjectSchema> getQueryResult() {
    return queryResult;
  }

  public void setQueryResult(List<OaContentServiceQueryDataObjectSchema> queryResult) {
    this.queryResult = queryResult;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceQueryObjectSchema oaContentServiceQueryObjectSchema = (OaContentServiceQueryObjectSchema) o;
    return Objects.equals(this.queryId, oaContentServiceQueryObjectSchema.queryId) &&
        Objects.equals(this.queryResult, oaContentServiceQueryObjectSchema.queryResult);
  }

  @Override
  public int hashCode() {
    return Objects.hash(queryId, queryResult);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceQueryObjectSchema {\n");
    
    sb.append("    queryId: ").append(toIndentedString(queryId)).append("\n");
    sb.append("    queryResult: ").append(toIndentedString(queryResult)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}
