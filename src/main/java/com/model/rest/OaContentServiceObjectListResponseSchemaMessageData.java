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
public class OaContentServiceObjectListResponseSchemaMessageData   {
  @JsonProperty("objects")
  @Valid
  private List<OaContentServiceMetadataObjectSchema> objects = new ArrayList<>();

  public OaContentServiceObjectListResponseSchemaMessageData objects(List<OaContentServiceMetadataObjectSchema> objects) {
    this.objects = objects;
    return this;
  }

  public OaContentServiceObjectListResponseSchemaMessageData addObjectsItem(OaContentServiceMetadataObjectSchema objectsItem) {
    this.objects.add(objectsItem);
    return this;
  }

  /**
   * A list of objects that holds the requested information about OA objects.
   * @return objects
  **/
  @ApiModelProperty(required = true, value = "A list of objects that holds the requested information about OA objects.")
  @NotNull
  @Valid
  public List<OaContentServiceMetadataObjectSchema> getObjects() {
    return objects;
  }

  public void setObjects(List<OaContentServiceMetadataObjectSchema> objects) {
    this.objects = objects;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceObjectListResponseSchemaMessageData oaContentServiceObjectListResponseSchemaMessageData = (OaContentServiceObjectListResponseSchemaMessageData) o;
    return Objects.equals(this.objects, oaContentServiceObjectListResponseSchemaMessageData.objects);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objects);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceObjectListResponseSchemaMessageData {\n");
    
    sb.append("    objects: ").append(toIndentedString(objects)).append("\n");
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
