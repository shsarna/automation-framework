package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import java.util.Objects;

/**
 * DomuidataservicemessagingSchemaMessageDataDataResourceChanges
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomuidataservicemessagingSchemaMessageDataDataResourceChanges   {
  @JsonProperty("id")
  private Integer id = null;

  @JsonProperty("type")
  private String type = null;

  @JsonProperty("location")
  private String location = null;

  @JsonProperty("status")
  private Integer status = null;

  public DomuidataservicemessagingSchemaMessageDataDataResourceChanges id(Integer id) {
    this.id = id;
    return this;
  }

  /**
   * Id of the resource.
   * @return id
  **/
  @ApiModelProperty(example = "2004", required = true, value = "Id of the resource.")
      @NotNull

    public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public DomuidataservicemessagingSchemaMessageDataDataResourceChanges type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Resource type in urn format, e.g. urn:com:mercedes-benz:oa:resource-type:text for texts.
   * @return type
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:resource-type:text", required = true, value = "Resource type in urn format, e.g. urn:com:mercedes-benz:oa:resource-type:text for texts.")
      @NotNull

    public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public DomuidataservicemessagingSchemaMessageDataDataResourceChanges location(String location) {
    this.location = location;
    return this;
  }

  /**
   * Location of the resource.
   * @return location
  **/
  @ApiModelProperty(example = "http://oa.daimler.com/dom-ui-data-service/v1/text/2004", required = true, value = "Location of the resource.")
      @NotNull

    public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public DomuidataservicemessagingSchemaMessageDataDataResourceChanges status(Integer status) {
    this.status = status;
    return this;
  }

  /**
   * Status code indicating the type of change in the OABackend DB. Possible values: -1: Error, 0: Resource exists, 1: Resource created, 2: Resource updated, 3: Resource deleted
   * @return status
  **/
  @ApiModelProperty(example = "1", required = true, value = "Status code indicating the type of change in the OABackend DB. Possible values: -1: Error, 0: Resource exists, 1: Resource created, 2: Resource updated, 3: Resource deleted")
      @NotNull

    public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomuidataservicemessagingSchemaMessageDataDataResourceChanges domuidataservicemessagingSchemaMessageDataDataResourceChanges = (DomuidataservicemessagingSchemaMessageDataDataResourceChanges) o;
    return Objects.equals(this.id, domuidataservicemessagingSchemaMessageDataDataResourceChanges.id) &&
        Objects.equals(this.type, domuidataservicemessagingSchemaMessageDataDataResourceChanges.type) &&
        Objects.equals(this.location, domuidataservicemessagingSchemaMessageDataDataResourceChanges.location) &&
        Objects.equals(this.status, domuidataservicemessagingSchemaMessageDataDataResourceChanges.status);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, type, location, status);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomuidataservicemessagingSchemaMessageDataDataResourceChanges {\n");

    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    location: ").append(toIndentedString(location)).append("\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
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
