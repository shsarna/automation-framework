package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * The object which holds different types of objects, which belong to the OA Content Data domain.
 */
@ApiModel(description = "The object which holds different types of objects, which belong to the OA Content Data domain.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceQueryDataObjectSchema   {
  @JsonProperty("object")
  private OaContentServiceMetadataObjectSchema object = null;

  @JsonProperty("payloads")
  @Valid
  private List<OaContentServicePayloadObjectSchema> payloads = null;

  @JsonProperty("relations")
  @Valid
  private List<OaContentServiceQueryDataObjectSchemaRelations> relations = null;

  public OaContentServiceQueryDataObjectSchema object(OaContentServiceMetadataObjectSchema object) {
    this.object = object;
    return this;
  }

  /**
   * Get object
   * @return object
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceMetadataObjectSchema getObject() {
    return object;
  }

  public void setObject(OaContentServiceMetadataObjectSchema object) {
    this.object = object;
  }

  public OaContentServiceQueryDataObjectSchema payloads(List<OaContentServicePayloadObjectSchema> payloads) {
    this.payloads = payloads;
    return this;
  }

  public OaContentServiceQueryDataObjectSchema addPayloadsItem(OaContentServicePayloadObjectSchema payloadsItem) {
    if (this.payloads == null) {
      this.payloads = new ArrayList<>();
    }
    this.payloads.add(payloadsItem);
    return this;
  }

  /**
   * An OA object can have multiple payloads.
   * @return payloads
  **/
  @ApiModelProperty(value = "An OA object can have multiple payloads.")
  @Valid
  public List<OaContentServicePayloadObjectSchema> getPayloads() {
    return payloads;
  }

  public void setPayloads(List<OaContentServicePayloadObjectSchema> payloads) {
    this.payloads = payloads;
  }

  public OaContentServiceQueryDataObjectSchema relations(List<OaContentServiceQueryDataObjectSchemaRelations> relations) {
    this.relations = relations;
    return this;
  }

  public OaContentServiceQueryDataObjectSchema addRelationsItem(OaContentServiceQueryDataObjectSchemaRelations relationsItem) {
    if (this.relations == null) {
      this.relations = new ArrayList<>();
    }
    this.relations.add(relationsItem);
    return this;
  }

  /**
   * An object to provide the relation to another object.
   * @return relations
  **/
  @ApiModelProperty(value = "An object to provide the relation to another object.")
  @Valid
  public List<OaContentServiceQueryDataObjectSchemaRelations> getRelations() {
    return relations;
  }

  public void setRelations(List<OaContentServiceQueryDataObjectSchemaRelations> relations) {
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
    OaContentServiceQueryDataObjectSchema oaContentServiceQueryDataObjectSchema = (OaContentServiceQueryDataObjectSchema) o;
    return Objects.equals(this.object, oaContentServiceQueryDataObjectSchema.object) &&
        Objects.equals(this.payloads, oaContentServiceQueryDataObjectSchema.payloads) &&
        Objects.equals(this.relations, oaContentServiceQueryDataObjectSchema.relations);
  }

  @Override
  public int hashCode() {
    return Objects.hash(object, payloads, relations);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceQueryDataObjectSchema {\n");
    
    sb.append("    object: ").append(toIndentedString(object)).append("\n");
    sb.append("    payloads: ").append(toIndentedString(payloads)).append("\n");
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
