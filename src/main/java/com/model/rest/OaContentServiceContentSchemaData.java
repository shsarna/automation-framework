package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * OaContentServiceContentSchemaData
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceContentSchemaData   {
  @JsonProperty("object")
  private OaContentServiceSearchMetadataObjectSchema2 object = null;

  @JsonProperty("payloads")
  @Valid
  private List<OaContentServiceImportPayloadObjectSchema> payloads = null;

  @JsonProperty("relations")
  @Valid
  private List<OaContentServiceContentSchemaRelations> relations = null;

  public OaContentServiceContentSchemaData object(OaContentServiceSearchMetadataObjectSchema2 object) {
    this.object = object;
    return this;
  }

  /**
   * Get object
   * @return object
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchMetadataObjectSchema2 getObject() {
    return object;
  }

  public void setObject(OaContentServiceSearchMetadataObjectSchema2 object) {
    this.object = object;
  }

  public OaContentServiceContentSchemaData payloads(List<OaContentServiceImportPayloadObjectSchema> payloads) {
    this.payloads = payloads;
    return this;
  }

  public OaContentServiceContentSchemaData addPayloadsItem(OaContentServiceImportPayloadObjectSchema payloadsItem) {
    if (this.payloads == null) {
      this.payloads = new ArrayList<>();
    }
    this.payloads.add(payloadsItem);
    return this;
  }

  /**
   * An object to provide  the payload data to be imported.
   * @return payloads
  **/
  @ApiModelProperty(value = "An object to provide  the payload data to be imported.")
  @Valid
  public List<OaContentServiceImportPayloadObjectSchema> getPayloads() {
    return payloads;
  }

  public void setPayloads(List<OaContentServiceImportPayloadObjectSchema> payloads) {
    this.payloads = payloads;
  }

  public OaContentServiceContentSchemaData relations(List<OaContentServiceContentSchemaRelations> relations) {
    this.relations = relations;
    return this;
  }

  public OaContentServiceContentSchemaData addRelationsItem(OaContentServiceContentSchemaRelations relationsItem) {
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
  public List<OaContentServiceContentSchemaRelations> getRelations() {
    return relations;
  }

  public void setRelations(List<OaContentServiceContentSchemaRelations> relations) {
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
    OaContentServiceContentSchemaData oaContentServiceContentSchemaData = (OaContentServiceContentSchemaData) o;
    return Objects.equals(this.object, oaContentServiceContentSchemaData.object) &&
        Objects.equals(this.payloads, oaContentServiceContentSchemaData.payloads) &&
        Objects.equals(this.relations, oaContentServiceContentSchemaData.relations);
  }

  @Override
  public int hashCode() {
    return Objects.hash(object, payloads, relations);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceContentSchemaData {\n");
    
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
