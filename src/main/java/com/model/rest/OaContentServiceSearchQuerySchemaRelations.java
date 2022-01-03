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
 * OaContentServiceSearchQuerySchemaRelations
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchQuerySchemaRelations   {
  @JsonProperty("relationSet")
  @Valid
  private List<OaContentServiceSearchQuerySchemaRelationSet> relationSet = new ArrayList<>();

  public OaContentServiceSearchQuerySchemaRelations relationSet(List<OaContentServiceSearchQuerySchemaRelationSet> relationSet) {
    this.relationSet = relationSet;
    return this;
  }

  public OaContentServiceSearchQuerySchemaRelations addRelationSetItem(OaContentServiceSearchQuerySchemaRelationSet relationSetItem) {
    this.relationSet.add(relationSetItem);
    return this;
  }

  /**
   * Get relationSet
   * @return relationSet
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull
  @Valid
  public List<OaContentServiceSearchQuerySchemaRelationSet> getRelationSet() {
    return relationSet;
  }

  public void setRelationSet(List<OaContentServiceSearchQuerySchemaRelationSet> relationSet) {
    this.relationSet = relationSet;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchQuerySchemaRelations oaContentServiceSearchQuerySchemaRelations = (OaContentServiceSearchQuerySchemaRelations) o;
    return Objects.equals(this.relationSet, oaContentServiceSearchQuerySchemaRelations.relationSet);
  }

  @Override
  public int hashCode() {
    return Objects.hash(relationSet);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchQuerySchemaRelations {\n");
    
    sb.append("    relationSet: ").append(toIndentedString(relationSet)).append("\n");
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
