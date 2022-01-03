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
public class OaContentServiceContentSchema   {
  @JsonProperty("data")
  @Valid
  private List<OaContentServiceContentSchemaData> data = new ArrayList<>();

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public OaContentServiceContentSchema data(List<OaContentServiceContentSchemaData> data) {
    this.data = data;
    return this;
  }

  public OaContentServiceContentSchema addDataItem(OaContentServiceContentSchemaData dataItem) {
    this.data.add(dataItem);
    return this;
  }

  /**
   * The object which holds different types of objects, which belong to the OA Content Data domain.
   * @return data
  **/
  @ApiModelProperty(required = true, value = "The object which holds different types of objects, which belong to the OA Content Data domain.")
  @NotNull
  @Valid
  public List<OaContentServiceContentSchemaData> getData() {
    return data;
  }

  public void setData(List<OaContentServiceContentSchemaData> data) {
    this.data = data;
  }

  public OaContentServiceContentSchema references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public OaContentServiceContentSchema addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
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
    OaContentServiceContentSchema oaContentServiceContentSchema = (OaContentServiceContentSchema) o;
    return Objects.equals(this.data, oaContentServiceContentSchema.data) &&
        Objects.equals(this.references, oaContentServiceContentSchema.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(data, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceContentSchema {\n");
    
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
