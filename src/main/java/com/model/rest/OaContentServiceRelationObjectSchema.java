package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Object specifying a relation between two objects.
 */
@ApiModel(description = "Object specifying a relation between two objects.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceRelationObjectSchema   {
  @JsonProperty("relationId")
  private BigDecimal relationId = null;

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

  public OaContentServiceRelationObjectSchema relationId(BigDecimal relationId) {
    this.relationId = relationId;
    return this;
  }

  /**
   * Internal Id of the object relation.
   * @return relationId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the object relation.")
  @NotNull

  @Valid
  public BigDecimal getRelationId() {
    return relationId;
  }

  public void setRelationId(BigDecimal relationId) {
    this.relationId = relationId;
  }

  public OaContentServiceRelationObjectSchema objectUri1(String objectUri1) {
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

  public OaContentServiceRelationObjectSchema relationType(String relationType) {
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

  public OaContentServiceRelationObjectSchema objectUri2(String objectUri2) {
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

  public OaContentServiceRelationObjectSchema contextUri(String contextUri) {
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

  public OaContentServiceRelationObjectSchema validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when this relation is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(value = "Point of time, from when this relation is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServiceRelationObjectSchema validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until this relation is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(value = "Point of time, until this relation is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

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
    OaContentServiceRelationObjectSchema oaContentServiceRelationObjectSchema = (OaContentServiceRelationObjectSchema) o;
    return Objects.equals(this.relationId, oaContentServiceRelationObjectSchema.relationId) &&
        Objects.equals(this.objectUri1, oaContentServiceRelationObjectSchema.objectUri1) &&
        Objects.equals(this.relationType, oaContentServiceRelationObjectSchema.relationType) &&
        Objects.equals(this.objectUri2, oaContentServiceRelationObjectSchema.objectUri2) &&
        Objects.equals(this.contextUri, oaContentServiceRelationObjectSchema.contextUri) &&
        Objects.equals(this.validFrom, oaContentServiceRelationObjectSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceRelationObjectSchema.validTo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(relationId, objectUri1, relationType, objectUri2, contextUri, validFrom, validTo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceRelationObjectSchema {\n");
    
    sb.append("    relationId: ").append(toIndentedString(relationId)).append("\n");
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
