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
public class OaContentServiceQueryResponseSchemaMessage   {
  @JsonProperty("info")
  @Valid
  private List<OaServiceInformationObjectSchema> info = null;

  @JsonProperty("data")
  private OaContentServiceQueryObjectSchema data = null;

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public OaContentServiceQueryResponseSchemaMessage info(List<OaServiceInformationObjectSchema> info) {
    this.info = info;
    return this;
  }

  public OaContentServiceQueryResponseSchemaMessage addInfoItem(OaServiceInformationObjectSchema infoItem) {
    if (this.info == null) {
      this.info = new ArrayList<>();
    }
    this.info.add(infoItem);
    return this;
  }

  /**
   * A list of information objects that provides details regarding the request processing.
   * @return info
  **/
  @ApiModelProperty(value = "A list of information objects that provides details regarding the request processing.")
  @Valid
  public List<OaServiceInformationObjectSchema> getInfo() {
    return info;
  }

  public void setInfo(List<OaServiceInformationObjectSchema> info) {
    this.info = info;
  }

  public OaContentServiceQueryResponseSchemaMessage data(OaContentServiceQueryObjectSchema data) {
    this.data = data;
    return this;
  }

  /**
   * Get data
   * @return data
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  @Valid
  public OaContentServiceQueryObjectSchema getData() {
    return data;
  }

  public void setData(OaContentServiceQueryObjectSchema data) {
    this.data = data;
  }

  public OaContentServiceQueryResponseSchemaMessage references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public OaContentServiceQueryResponseSchemaMessage addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
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
    OaContentServiceQueryResponseSchemaMessage oaContentServiceQueryResponseSchemaMessage = (OaContentServiceQueryResponseSchemaMessage) o;
    return Objects.equals(this.info, oaContentServiceQueryResponseSchemaMessage.info) &&
        Objects.equals(this.data, oaContentServiceQueryResponseSchemaMessage.data) &&
        Objects.equals(this.references, oaContentServiceQueryResponseSchemaMessage.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(info, data, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceQueryResponseSchemaMessage {\n");
    
    sb.append("    info: ").append(toIndentedString(info)).append("\n");
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
