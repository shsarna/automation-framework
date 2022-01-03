package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * OaContentServiceSearchQuerySchemaRelationSet
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchQuerySchemaRelationSet   {
  @JsonProperty("relationType")
  private String relationType = null;

  @JsonProperty("object")
  private OaContentServiceSearchObjectObjectSchema object = null;

  @JsonProperty("contextUri")
  private String contextUri = null;

  @JsonProperty("validFrom")
  private String validFrom = null;

  @JsonProperty("validTo")
  private String validTo = null;

  public OaContentServiceSearchQuerySchemaRelationSet relationType(String relationType) {
    this.relationType = relationType;
    return this;
  }

  /**
   * Object relation type
   * @return relationType
  **/
  @ApiModelProperty(required = true, value = "Object relation type")
  @NotNull

@Size(max=50)   public String getRelationType() {
    return relationType;
  }

  public void setRelationType(String relationType) {
    this.relationType = relationType;
  }

  public OaContentServiceSearchQuerySchemaRelationSet object(OaContentServiceSearchObjectObjectSchema object) {
    this.object = object;
    return this;
  }

  /**
   * Get object
   * @return object
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  @Valid
  public OaContentServiceSearchObjectObjectSchema getObject() {
    return object;
  }

  public void setObject(OaContentServiceSearchObjectObjectSchema object) {
    this.object = object;
  }

  public OaContentServiceSearchQuerySchemaRelationSet contextUri(String contextUri) {
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

  public OaContentServiceSearchQuerySchemaRelationSet validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when this relationship is valid. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(value = "Point of time, from when this relationship is valid. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServiceSearchQuerySchemaRelationSet validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until this relationship is valid. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(value = "Point of time, until this relationship is valid. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

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
    OaContentServiceSearchQuerySchemaRelationSet oaContentServiceSearchQuerySchemaRelationSet = (OaContentServiceSearchQuerySchemaRelationSet) o;
    return Objects.equals(this.relationType, oaContentServiceSearchQuerySchemaRelationSet.relationType) &&
        Objects.equals(this.object, oaContentServiceSearchQuerySchemaRelationSet.object) &&
        Objects.equals(this.contextUri, oaContentServiceSearchQuerySchemaRelationSet.contextUri) &&
        Objects.equals(this.validFrom, oaContentServiceSearchQuerySchemaRelationSet.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceSearchQuerySchemaRelationSet.validTo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(relationType, object, contextUri, validFrom, validTo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchQuerySchemaRelationSet {\n");
    
    sb.append("    relationType: ").append(toIndentedString(relationType)).append("\n");
    sb.append("    object: ").append(toIndentedString(object)).append("\n");
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
