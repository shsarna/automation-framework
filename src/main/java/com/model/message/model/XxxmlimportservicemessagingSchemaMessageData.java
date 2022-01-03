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
public class XxxmlimportservicemessagingSchemaMessageData   {
  @JsonProperty("id")
  private Integer id = null;

  @JsonProperty("type")
  private String type = null;

  @JsonProperty("location")
  private String location = null;

  @JsonProperty("status")
  private Integer status = null;

  @JsonProperty("data")
  private XxxmlimportservicemessagingSchemaMessageDataData data = null;

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public XxxmlimportservicemessagingSchemaMessageData id(Integer id) {
    this.id = id;
    return this;
  }

  /**
   * Internal ID of the resource.
   * @return id
  **/
  @ApiModelProperty(example = "1", required = true, value = "Internal ID of the resource.")
      @NotNull

    public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public XxxmlimportservicemessagingSchemaMessageData type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Resource type in urn format, e.g. urn:com:mercedes-benz:oa:xxxml-import-service:import
   * @return type
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:xxxml-import-service:import", required = true, value = "Resource type in urn format, e.g. urn:com:mercedes-benz:oa:xxxml-import-service:import")
      @NotNull

    public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public XxxmlimportservicemessagingSchemaMessageData location(String location) {
    this.location = location;
    return this;
  }

  /**
   * Location of the resource.
   * @return location
  **/
  @ApiModelProperty(example = "http://oa.daimler.com/xxxml-import-service/v0/import/20", required = true, value = "Location of the resource.")
      @NotNull

    public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public XxxmlimportservicemessagingSchemaMessageData status(Integer status) {
    this.status = status;
    return this;
  }

  /**
   * Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.
   * @return status
  **/
  @ApiModelProperty(required = true, value = "Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.")
      @NotNull

    public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public XxxmlimportservicemessagingSchemaMessageData data(XxxmlimportservicemessagingSchemaMessageDataData data) {
    this.data = data;
    return this;
  }

  /**
   * Get data
   * @return data
  **/
  @ApiModelProperty(value = "")
  
    @Valid
    public XxxmlimportservicemessagingSchemaMessageDataData getData() {
    return data;
  }

  public void setData(XxxmlimportservicemessagingSchemaMessageDataData data) {
    this.data = data;
  }

  public XxxmlimportservicemessagingSchemaMessageData references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public XxxmlimportservicemessagingSchemaMessageData addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
    if (this.references == null) {
      this.references = new ArrayList<>();
    }
    this.references.add(referencesItem);
    return this;
  }

  /**
   * Referenced resources.
   * @return references
  **/
  @ApiModelProperty(value = "Referenced resources.")
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
    XxxmlimportservicemessagingSchemaMessageData xxxmlimportservicemessagingSchemaMessageData = (XxxmlimportservicemessagingSchemaMessageData) o;
    return Objects.equals(this.id, xxxmlimportservicemessagingSchemaMessageData.id) &&
        Objects.equals(this.type, xxxmlimportservicemessagingSchemaMessageData.type) &&
        Objects.equals(this.location, xxxmlimportservicemessagingSchemaMessageData.location) &&
        Objects.equals(this.status, xxxmlimportservicemessagingSchemaMessageData.status) &&
        Objects.equals(this.data, xxxmlimportservicemessagingSchemaMessageData.data) &&
        Objects.equals(this.references, xxxmlimportservicemessagingSchemaMessageData.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, type, location, status, data, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class XxxmlimportservicemessagingSchemaMessageData {\n");

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
