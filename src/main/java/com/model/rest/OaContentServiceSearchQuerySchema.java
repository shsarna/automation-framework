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
 * A named root object to keep the json structure as compatible as possible with other data structures (e.g. XML).
 */
@ApiModel(description = "A named root object to keep the json structure as compatible as possible with other data structures (e.g. XML).")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchQuerySchema   {
  @JsonProperty("data")
  @Valid
  private List<OaContentServiceSearchQuerySchemaData> data = new ArrayList<>();

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public OaContentServiceSearchQuerySchema data(List<OaContentServiceSearchQuerySchemaData> data) {
    this.data = data;
    return this;
  }

  public OaContentServiceSearchQuerySchema addDataItem(OaContentServiceSearchQuerySchemaData dataItem) {
    this.data.add(dataItem);
    return this;
  }

  /**
   * Details of the data to be queried.
   * @return data
  **/
  @ApiModelProperty(required = true, value = "Details of the data to be queried.")
  @NotNull
  @Valid
  public List<OaContentServiceSearchQuerySchemaData> getData() {
    return data;
  }

  public void setData(List<OaContentServiceSearchQuerySchemaData> data) {
    this.data = data;
  }

  public OaContentServiceSearchQuerySchema references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public OaContentServiceSearchQuerySchema addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
    if (this.references == null) {
      this.references = new ArrayList<>();
    }
    this.references.add(referencesItem);
    return this;
  }

  /**
   * List of processed resources used for tracing purposes. Each triggered consumer creates a new resource and adds the details as a new object.
   * @return references
  **/
  @ApiModelProperty(value = "List of processed resources used for tracing purposes. Each triggered consumer creates a new resource and adds the details as a new object.")
  @Valid
  public List<OaServiceAndMessageReferenceSchema> getReferences() {
    return references;
  }

  public void setReferences(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchQuerySchema oaContentServiceSearchQuerySchema = (OaContentServiceSearchQuerySchema) o;
    return Objects.equals(this.data, oaContentServiceSearchQuerySchema.data) &&
        Objects.equals(this.references, oaContentServiceSearchQuerySchema.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(data, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchQuerySchema {\n");
    
    sb.append("    data: ").append(toIndentedString(data)).append("\n");
    sb.append("    references: ").append(toIndentedString(references)).append("\n");
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
