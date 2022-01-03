package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import java.util.Objects;

/**
 * Specifies what data should be returned. Metadata, payload and relation are the possible values.
 */
@ApiModel(description = "Specifies what data should be returned. Metadata, payload and relation are the possible values.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchQuerySchemaReturn   {
  @JsonProperty("objectData")
  private Boolean objectData = null;

  @JsonProperty("payloadData")
  private Boolean payloadData = null;

  @JsonProperty("relations")
  private Boolean relations = null;

  public OaContentServiceSearchQuerySchemaReturn objectData(Boolean objectData) {
    this.objectData = objectData;
    return this;
  }

  /**
   * Get objectData
   * @return objectData
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  public Boolean isObjectData() {
    return objectData;
  }

  public void setObjectData(Boolean objectData) {
    this.objectData = objectData;
  }

  public OaContentServiceSearchQuerySchemaReturn payloadData(Boolean payloadData) {
    this.payloadData = payloadData;
    return this;
  }

  /**
   * Get payloadData
   * @return payloadData
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  public Boolean isPayloadData() {
    return payloadData;
  }

  public void setPayloadData(Boolean payloadData) {
    this.payloadData = payloadData;
  }

  public OaContentServiceSearchQuerySchemaReturn relations(Boolean relations) {
    this.relations = relations;
    return this;
  }

  /**
   * Get relations
   * @return relations
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  public Boolean isRelations() {
    return relations;
  }

  public void setRelations(Boolean relations) {
    this.relations = relations;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchQuerySchemaReturn oaContentServiceSearchQuerySchemaReturn = (OaContentServiceSearchQuerySchemaReturn) o;
    return Objects.equals(this.objectData, oaContentServiceSearchQuerySchemaReturn.objectData) &&
        Objects.equals(this.payloadData, oaContentServiceSearchQuerySchemaReturn.payloadData) &&
        Objects.equals(this.relations, oaContentServiceSearchQuerySchemaReturn.relations);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectData, payloadData, relations);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchQuerySchemaReturn {\n");
    
    sb.append("    objectData: ").append(toIndentedString(objectData)).append("\n");
    sb.append("    payloadData: ").append(toIndentedString(payloadData)).append("\n");
    sb.append("    relations: ").append(toIndentedString(relations)).append("\n");
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
