package com.model.rest;

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
 * An object that holds the requested data.
 */
@ApiModel(description = "An object that holds the requested data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceRelationListResponseSchemaMessageData   {
  @JsonProperty("relations")
  @Valid
  private List<OaContentServiceRelationObjectSchema> relations = new ArrayList<>();

  public OaContentServiceRelationListResponseSchemaMessageData relations(List<OaContentServiceRelationObjectSchema> relations) {
    this.relations = relations;
    return this;
  }

  public OaContentServiceRelationListResponseSchemaMessageData addRelationsItem(OaContentServiceRelationObjectSchema relationsItem) {
    this.relations.add(relationsItem);
    return this;
  }

  /**
   * A list of objects that holds the requested information about OA relations.
   * @return relations
  **/
  @ApiModelProperty(required = true, value = "A list of objects that holds the requested information about OA relations.")
  @NotNull
  @Valid
  public List<OaContentServiceRelationObjectSchema> getRelations() {
    return relations;
  }

  public void setRelations(List<OaContentServiceRelationObjectSchema> relations) {
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
    OaContentServiceRelationListResponseSchemaMessageData oaContentServiceRelationListResponseSchemaMessageData = (OaContentServiceRelationListResponseSchemaMessageData) o;
    return Objects.equals(this.relations, oaContentServiceRelationListResponseSchemaMessageData.relations);
  }

  @Override
  public int hashCode() {
    return Objects.hash(relations);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceRelationListResponseSchemaMessageData {\n");
    
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
