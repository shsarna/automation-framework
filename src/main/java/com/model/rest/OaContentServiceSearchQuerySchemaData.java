package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * OaContentServiceSearchQuerySchemaData
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchQuerySchemaData   {
  @JsonProperty("relationIds")
  @Valid
  private List<Integer> relationIds = null;

  @JsonProperty("objectUri")
  private String objectUri = null;

  @JsonProperty("metadata")
  @Valid
  private List<OaContentServiceSearchMetadataObjectSchema2> metadata = null;

  @JsonProperty("payloads")
  @Valid
  private List<OaContentServiceSearchPayloadObjectSchema> payloads = null;

  @JsonProperty("relations")
  @Valid
  private List<OaContentServiceSearchQuerySchemaRelations> relations = null;

  @JsonProperty("return")
  private OaContentServiceSearchQuerySchemaReturn _return = null;

  public OaContentServiceSearchQuerySchemaData relationIds(List<Integer> relationIds) {
    this.relationIds = relationIds;
    return this;
  }

  public OaContentServiceSearchQuerySchemaData addRelationIdsItem(Integer relationIdsItem) {
    if (this.relationIds == null) {
      this.relationIds = new ArrayList<>();
    }
    this.relationIds.add(relationIdsItem);
    return this;
  }

  /**
   * Get relationIds
   * @return relationIds
  **/
  @ApiModelProperty(value = "")

  public List<Integer> getRelationIds() {
    return relationIds;
  }

  public void setRelationIds(List<Integer> relationIds) {
    this.relationIds = relationIds;
  }

  public OaContentServiceSearchQuerySchemaData objectUri(String objectUri) {
    this.objectUri = objectUri;
    return this;
  }

  /**
   * URI of an object.
   * @return objectUri
  **/
  @ApiModelProperty(value = "URI of an object.")

  public String getObjectUri() {
    return objectUri;
  }

  public void setObjectUri(String objectUri) {
    this.objectUri = objectUri;
  }

  public OaContentServiceSearchQuerySchemaData metadata(List<OaContentServiceSearchMetadataObjectSchema2> metadata) {
    this.metadata = metadata;
    return this;
  }

  public OaContentServiceSearchQuerySchemaData addMetadataItem(OaContentServiceSearchMetadataObjectSchema2 metadataItem) {
    if (this.metadata == null) {
      this.metadata = new ArrayList<>();
    }
    this.metadata.add(metadataItem);
    return this;
  }

  /**
   * Metadata of an object.
   * @return metadata
  **/
  @ApiModelProperty(value = "Metadata of an object.")
  @Valid
  public List<OaContentServiceSearchMetadataObjectSchema2> getMetadata() {
    return metadata;
  }

  public void setMetadata(List<OaContentServiceSearchMetadataObjectSchema2> metadata) {
    this.metadata = metadata;
  }

  public OaContentServiceSearchQuerySchemaData payloads(List<OaContentServiceSearchPayloadObjectSchema> payloads) {
    this.payloads = payloads;
    return this;
  }

  public OaContentServiceSearchQuerySchemaData addPayloadsItem(OaContentServiceSearchPayloadObjectSchema payloadsItem) {
    if (this.payloads == null) {
      this.payloads = new ArrayList<>();
    }
    this.payloads.add(payloadsItem);
    return this;
  }

  /**
   * Payload information of an object.
   * @return payloads
  **/
  @ApiModelProperty(value = "Payload information of an object.")
  @Valid
  public List<OaContentServiceSearchPayloadObjectSchema> getPayloads() {
    return payloads;
  }

  public void setPayloads(List<OaContentServiceSearchPayloadObjectSchema> payloads) {
    this.payloads = payloads;
  }

  public OaContentServiceSearchQuerySchemaData relations(List<OaContentServiceSearchQuerySchemaRelations> relations) {
    this.relations = relations;
    return this;
  }

  public OaContentServiceSearchQuerySchemaData addRelationsItem(OaContentServiceSearchQuerySchemaRelations relationsItem) {
    if (this.relations == null) {
      this.relations = new ArrayList<>();
    }
    this.relations.add(relationsItem);
    return this;
  }

  /**
   * Relations of an object.
   * @return relations
  **/
  @ApiModelProperty(value = "Relations of an object.")
  @Valid
  public List<OaContentServiceSearchQuerySchemaRelations> getRelations() {
    return relations;
  }

  public void setRelations(List<OaContentServiceSearchQuerySchemaRelations> relations) {
    this.relations = relations;
  }

  public OaContentServiceSearchQuerySchemaData _return(OaContentServiceSearchQuerySchemaReturn _return) {
    this._return = _return;
    return this;
  }

  /**
   * Get _return
   * @return _return
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  @Valid
  public OaContentServiceSearchQuerySchemaReturn getReturn() {
    return _return;
  }

  public void setReturn(OaContentServiceSearchQuerySchemaReturn _return) {
    this._return = _return;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchQuerySchemaData oaContentServiceSearchQuerySchemaData = (OaContentServiceSearchQuerySchemaData) o;
    return Objects.equals(this.relationIds, oaContentServiceSearchQuerySchemaData.relationIds) &&
        Objects.equals(this.objectUri, oaContentServiceSearchQuerySchemaData.objectUri) &&
        Objects.equals(this.metadata, oaContentServiceSearchQuerySchemaData.metadata) &&
        Objects.equals(this.payloads, oaContentServiceSearchQuerySchemaData.payloads) &&
        Objects.equals(this.relations, oaContentServiceSearchQuerySchemaData.relations) &&
        Objects.equals(this._return, oaContentServiceSearchQuerySchemaData._return);
  }

  @Override
  public int hashCode() {
    return Objects.hash(relationIds, objectUri, metadata, payloads, relations, _return);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchQuerySchemaData {\n");
    
    sb.append("    relationIds: ").append(toIndentedString(relationIds)).append("\n");
    sb.append("    objectUri: ").append(toIndentedString(objectUri)).append("\n");
    sb.append("    metadata: ").append(toIndentedString(metadata)).append("\n");
    sb.append("    payloads: ").append(toIndentedString(payloads)).append("\n");
    sb.append("    relations: ").append(toIndentedString(relations)).append("\n");
    sb.append("    _return: ").append(toIndentedString(_return)).append("\n");
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
