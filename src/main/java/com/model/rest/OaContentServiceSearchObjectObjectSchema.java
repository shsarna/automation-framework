package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.Objects;

/**
 * Details of an OA object to search for.
 */
@ApiModel(description = "Details of an OA object to search for.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchObjectObjectSchema   {
  @JsonProperty("objectUri")
  private String objectUri = null;

  @JsonProperty("metadata")
  private OaContentServiceSearchMetadataObjectSchema2 metadata = null;

  @JsonProperty("payload")
  private OaContentServiceSearchPayloadObjectSchema payload = null;

  public OaContentServiceSearchObjectObjectSchema objectUri(String objectUri) {
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

  public OaContentServiceSearchObjectObjectSchema metadata(OaContentServiceSearchMetadataObjectSchema2 metadata) {
    this.metadata = metadata;
    return this;
  }

  /**
   * Get metadata
   * @return metadata
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchMetadataObjectSchema2 getMetadata() {
    return metadata;
  }

  public void setMetadata(OaContentServiceSearchMetadataObjectSchema2 metadata) {
    this.metadata = metadata;
  }

  public OaContentServiceSearchObjectObjectSchema payload(OaContentServiceSearchPayloadObjectSchema payload) {
    this.payload = payload;
    return this;
  }

  /**
   * Get payload
   * @return payload
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchPayloadObjectSchema getPayload() {
    return payload;
  }

  public void setPayload(OaContentServiceSearchPayloadObjectSchema payload) {
    this.payload = payload;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchObjectObjectSchema oaContentServiceSearchObjectObjectSchema = (OaContentServiceSearchObjectObjectSchema) o;
    return Objects.equals(this.objectUri, oaContentServiceSearchObjectObjectSchema.objectUri) &&
        Objects.equals(this.metadata, oaContentServiceSearchObjectObjectSchema.metadata) &&
        Objects.equals(this.payload, oaContentServiceSearchObjectObjectSchema.payload);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectUri, metadata, payload);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchObjectObjectSchema {\n");
    
    sb.append("    objectUri: ").append(toIndentedString(objectUri)).append("\n");
    sb.append("    metadata: ").append(toIndentedString(metadata)).append("\n");
    sb.append("    payload: ").append(toIndentedString(payload)).append("\n");
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
