package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object that holds the requested data.
 */
@ApiModel(description = "An object that holds the requested data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceQueryListResponseSchemaMessageData   {
  @JsonProperty("queries")
  @Valid
  private List<OaContentServiceQueryObjectSchema> queries = new ArrayList<>();

  public OaContentServiceQueryListResponseSchemaMessageData queries(List<OaContentServiceQueryObjectSchema> queries) {
    this.queries = queries;
    return this;
  }

  public OaContentServiceQueryListResponseSchemaMessageData addQueriesItem(OaContentServiceQueryObjectSchema queriesItem) {
    this.queries.add(queriesItem);
    return this;
  }

  /**
   * A list of objects that holds the requested information about OA queries.
   * @return queries
  **/
  @ApiModelProperty(required = true, value = "A list of objects that holds the requested information about OA queries.")
  @NotNull
  @Valid
  public List<OaContentServiceQueryObjectSchema> getQueries() {
    return queries;
  }

  public void setQueries(List<OaContentServiceQueryObjectSchema> queries) {
    this.queries = queries;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceQueryListResponseSchemaMessageData oaContentServiceQueryListResponseSchemaMessageData = (OaContentServiceQueryListResponseSchemaMessageData) o;
    return Objects.equals(this.queries, oaContentServiceQueryListResponseSchemaMessageData.queries);
  }

  @Override
  public int hashCode() {
    return Objects.hash(queries);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceQueryListResponseSchemaMessageData {\n");
    
    sb.append("    queries: ").append(toIndentedString(queries)).append("\n");
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
