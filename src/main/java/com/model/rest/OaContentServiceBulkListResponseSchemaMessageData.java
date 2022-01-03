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
public class OaContentServiceBulkListResponseSchemaMessageData   {
  @JsonProperty("bulk")
  @Valid
  private List<OaContentServiceBulkObjectSchema> bulk = new ArrayList<>();

  public OaContentServiceBulkListResponseSchemaMessageData bulk(List<OaContentServiceBulkObjectSchema> bulk) {
    this.bulk = bulk;
    return this;
  }

  public OaContentServiceBulkListResponseSchemaMessageData addBulkItem(OaContentServiceBulkObjectSchema bulkItem) {
    this.bulk.add(bulkItem);
    return this;
  }

  /**
   * A list of objects that holds the requested information about imported OA content.
   * @return bulk
  **/
  @ApiModelProperty(required = true, value = "A list of objects that holds the requested information about imported OA content.")
  @NotNull
  @Valid
  public List<OaContentServiceBulkObjectSchema> getBulk() {
    return bulk;
  }

  public void setBulk(List<OaContentServiceBulkObjectSchema> bulk) {
    this.bulk = bulk;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceBulkListResponseSchemaMessageData oaContentServiceBulkListResponseSchemaMessageData = (OaContentServiceBulkListResponseSchemaMessageData) o;
    return Objects.equals(this.bulk, oaContentServiceBulkListResponseSchemaMessageData.bulk);
  }

  @Override
  public int hashCode() {
    return Objects.hash(bulk);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceBulkListResponseSchemaMessageData {\n");
    
    sb.append("    bulk: ").append(toIndentedString(bulk)).append("\n");
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
