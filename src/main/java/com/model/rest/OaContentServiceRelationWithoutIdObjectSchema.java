package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * Object specifying a relation between two objects.
 */
@ApiModel(description = "Object specifying a relation between two objects.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceRelationWithoutIdObjectSchema   {
  @JsonProperty("objectUri1")
  private String objectUri1 = null;

  @JsonProperty("relationType")
  private String relationType = null;

  @JsonProperty("objectUri2")
  private String objectUri2 = null;

  @JsonProperty("contextUri")
  private String contextUri = null;

  @JsonProperty("validFrom")
  private String validFrom = null;

  @JsonProperty("validTo")
  private String validTo = null;

  public OaContentServiceRelationWithoutIdObjectSchema objectUri1(String objectUri1) {
    this.objectUri1 = objectUri1;
    return this;
  }

  /**
   * URI of the first object.
   * @return objectUri1
  **/
  @ApiModelProperty(required = true, value = "URI of the first object.")
  @NotNull

  public String getObjectUri1() {
    return objectUri1;
  }

  public void setObjectUri1(String objectUri1) {
    this.objectUri1 = objectUri1;
  }

  public OaContentServiceRelationWithoutIdObjectSchema relationType(String relationType) {
    this.relationType = relationType;
    return this;
  }

  /**
   * Relation type of the two objects.
   * @return relationType
  **/
  @ApiModelProperty(required = true, value = "Relation type of the two objects.")
  @NotNull

@Size(max=50)   public String getRelationType() {
    return relationType;
  }

  public void setRelationType(String relationType) {
    this.relationType = relationType;
  }

  public OaContentServiceRelationWithoutIdObjectSchema objectUri2(String objectUri2) {
    this.objectUri2 = objectUri2;
    return this;
  }

  /**
   * URI of the second object.
   * @return objectUri2
  **/
  @ApiModelProperty(required = true, value = "URI of the second object.")
  @NotNull

  public String getObjectUri2() {
    return objectUri2;
  }

  public void setObjectUri2(String objectUri2) {
    this.objectUri2 = objectUri2;
  }

  public OaContentServiceRelationWithoutIdObjectSchema contextUri(String contextUri) {
    this.contextUri = contextUri;
    return this;
  }

  /**
   * Context for the relation of two objects.
   * @return contextUri
  **/
  @ApiModelProperty(value = "Context for the relation of two objects.")

  public String getContextUri() {
    return contextUri;
  }

  public void setContextUri(String contextUri) {
    this.contextUri = contextUri;
  }

  public OaContentServiceRelationWithoutIdObjectSchema validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when this relationship is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(value = "Point of time, from when this relationship is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServiceRelationWithoutIdObjectSchema validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until this relationship is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(value = "Point of time, until this relationship is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidTo() {
    return validTo;
  }

  public void setValidTo(String validTo) {
    this.validTo = validTo;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceRelationWithoutIdObjectSchema oaContentServiceRelationWithoutIdObjectSchema = (OaContentServiceRelationWithoutIdObjectSchema) o;
    return Objects.equals(this.objectUri1, oaContentServiceRelationWithoutIdObjectSchema.objectUri1) &&
        Objects.equals(this.relationType, oaContentServiceRelationWithoutIdObjectSchema.relationType) &&
        Objects.equals(this.objectUri2, oaContentServiceRelationWithoutIdObjectSchema.objectUri2) &&
        Objects.equals(this.contextUri, oaContentServiceRelationWithoutIdObjectSchema.contextUri) &&
        Objects.equals(this.validFrom, oaContentServiceRelationWithoutIdObjectSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceRelationWithoutIdObjectSchema.validTo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectUri1, relationType, objectUri2, contextUri, validFrom, validTo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceRelationWithoutIdObjectSchema {\n");
    
    sb.append("    objectUri1: ").append(toIndentedString(objectUri1)).append("\n");
    sb.append("    relationType: ").append(toIndentedString(relationType)).append("\n");
    sb.append("    objectUri2: ").append(toIndentedString(objectUri2)).append("\n");
    sb.append("    contextUri: ").append(toIndentedString(contextUri)).append("\n");
    sb.append("    validFrom: ").append(toIndentedString(validFrom)).append("\n");
    sb.append("    validTo: ").append(toIndentedString(validTo)).append("\n");
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
