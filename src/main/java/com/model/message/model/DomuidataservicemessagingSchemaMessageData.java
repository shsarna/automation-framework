package com.model.message.model;

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
 * An object to provide the requested data.
 */
@ApiModel(description = "An object to provide the requested data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomuidataservicemessagingSchemaMessageData   {
  @JsonProperty("id")
  private Integer id = null;

  @JsonProperty("type")
  private String type = null;

  @JsonProperty("location")
  private String location = null;

  @JsonProperty("status")
  private Integer status = null;

  @JsonProperty("data")
  private DomuidataservicemessagingSchemaMessageDataData data = null;

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public DomuidataservicemessagingSchemaMessageData id(Integer id) {
    this.id = id;
    return this;
  }

  /**
   * Internal ID of the resource.
   * @return id
  **/
  @ApiModelProperty(example = "20", required = true, value = "Internal ID of the resource.")
      @NotNull

    public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public DomuidataservicemessagingSchemaMessageData type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Resource type in urn format, e.g. urn:com:mercedes-benz:oa:dom-ui-data-service:basync
   * @return type
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:dom-ui-data-service:basync", required = true, value = "Resource type in urn format, e.g. urn:com:mercedes-benz:oa:dom-ui-data-service:basync")
      @NotNull

    public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public DomuidataservicemessagingSchemaMessageData location(String location) {
    this.location = location;
    return this;
  }

  /**
   * Location of the resource.
   * @return location
  **/
  @ApiModelProperty(example = "http://oa.daimler.com/dom-ui-data-service/v1/basync/20", required = true, value = "Location of the resource.")
      @NotNull

    public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public DomuidataservicemessagingSchemaMessageData status(Integer status) {
    this.status = status;
    return this;
  }

  /**
   * Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.
   * @return status
  **/
  @ApiModelProperty(example = "1", required = true, value = "Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.")
      @NotNull

    public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public DomuidataservicemessagingSchemaMessageData data(DomuidataservicemessagingSchemaMessageDataData data) {
    this.data = data;
    return this;
  }

  /**
   * Get data
   * @return data
  **/
  @ApiModelProperty(value = "")
  
    @Valid
    public DomuidataservicemessagingSchemaMessageDataData getData() {
    return data;
  }

  public void setData(DomuidataservicemessagingSchemaMessageDataData data) {
    this.data = data;
  }

  public DomuidataservicemessagingSchemaMessageData references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public DomuidataservicemessagingSchemaMessageData addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
    if (this.references == null) {
      this.references = new ArrayList<>();
    }
    this.references.add(referencesItem);
    return this;
  }

  /**
   * In the references list the history for the processing is documented (tracing). Any consumer who is triggered by a message and creates a new resource has to add a new element to the references list of the triggering message describing the resource that has been processed.
   * @return references
  **/
  @ApiModelProperty(value = "In the references list the history for the processing is documented (tracing). Any consumer who is triggered by a message and creates a new resource has to add a new element to the references list of the triggering message describing the resource that has been processed.")
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
    DomuidataservicemessagingSchemaMessageData domuidataservicemessagingSchemaMessageData = (DomuidataservicemessagingSchemaMessageData) o;
    return Objects.equals(this.id, domuidataservicemessagingSchemaMessageData.id) &&
        Objects.equals(this.type, domuidataservicemessagingSchemaMessageData.type) &&
        Objects.equals(this.location, domuidataservicemessagingSchemaMessageData.location) &&
        Objects.equals(this.status, domuidataservicemessagingSchemaMessageData.status) &&
        Objects.equals(this.data, domuidataservicemessagingSchemaMessageData.data) &&
        Objects.equals(this.references, domuidataservicemessagingSchemaMessageData.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, type, location, status, data, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomuidataservicemessagingSchemaMessageData {\n");

    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    location: ").append(toIndentedString(location)).append("\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
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
