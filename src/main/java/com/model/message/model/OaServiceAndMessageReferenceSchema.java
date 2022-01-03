package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import java.util.Objects;

/**
 * An object with details to a referenced OA object.
 */
@ApiModel(description = "An object with details to a referenced OA object.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class OaServiceAndMessageReferenceSchema   {
  @JsonProperty("type")
  private String type = null;

  @JsonProperty("id")
  private Integer id = null;

  @JsonProperty("location")
  private String location = null;

  public OaServiceAndMessageReferenceSchema type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Unique resource name to identify the resource type. General composition: urn:<domain>:oa:<service>:<name of service>:<name of resource>.
   * @return type
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:[service]:[resource]", required = true, value = "Unique resource name to identify the resource type. General composition: urn:<domain>:oa:<service>:<name of service>:<name of resource>.")
      @NotNull

    public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public OaServiceAndMessageReferenceSchema id(Integer id) {
    this.id = id;
    return this;
  }

  /**
   * Id of the referenced resource.
   * @return id
  **/
  @ApiModelProperty(example = "20", required = true, value = "Id of the referenced resource.")
      @NotNull

    public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public OaServiceAndMessageReferenceSchema location(String location) {
    this.location = location;
    return this;
  }

  /**
   * Location of the referenced resource.
   * @return location
  **/
  @ApiModelProperty(example = "http://oa.daimler.com/[service]/v1/[resource]/20", required = true, value = "Location of the referenced resource.")
      @NotNull

    public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaServiceAndMessageReferenceSchema oaServiceAndMessageReferenceSchema = (OaServiceAndMessageReferenceSchema) o;
    return Objects.equals(this.type, oaServiceAndMessageReferenceSchema.type) &&
        Objects.equals(this.id, oaServiceAndMessageReferenceSchema.id) &&
        Objects.equals(this.location, oaServiceAndMessageReferenceSchema.location);
  }

  @Override
  public int hashCode() {
    return Objects.hash(type, id, location);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaServiceAndMessageReferenceSchema {\n");

    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    location: ").append(toIndentedString(location)).append("\n");
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
