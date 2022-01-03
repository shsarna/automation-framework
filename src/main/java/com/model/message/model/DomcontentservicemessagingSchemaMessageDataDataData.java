package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Additional information regarding the provided resource.
 */
@ApiModel(description = "Additional information regarding the provided resource.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomcontentservicemessagingSchemaMessageDataDataData   {
  @JsonProperty("objectUri")
  private String objectUri = null;

  @JsonProperty("objectIdFromSrc")
  private String objectIdFromSrc = null;

  @JsonProperty("elementType")
  private Integer elementType = null;

  @JsonProperty("elementTypeFromSrc")
  private String elementTypeFromSrc = null;

  @JsonProperty("dataIdFromSrc")
  private String dataIdFromSrc = null;

  @JsonProperty("mediaData")
  @Valid
  private List<DomContentServiceMediaSchema> mediaData = null;

  public DomcontentservicemessagingSchemaMessageDataDataData objectUri(String objectUri) {
    this.objectUri = objectUri;
    return this;
  }

  /**
   * URI of an object.
   * @return objectUri
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:topic:51kjhkjhfg9v879d8g3", required = true, value = "URI of an object.")
      @NotNull

    public String getObjectUri() {
    return objectUri;
  }

  public void setObjectUri(String objectUri) {
    this.objectUri = objectUri;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData objectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
    return this;
  }

  /**
   * Unique Identifier of this object in the source system.
   * @return objectIdFromSrc
  **/
  @ApiModelProperty(example = "51kjhkjhfg9v879d8g3", value = "Unique Identifier of this object in the source system.")
  
  @Size(max=1024)   public String getObjectIdFromSrc() {
    return objectIdFromSrc;
  }

  public void setObjectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData elementType(Integer elementType) {
    this.elementType = elementType;
    return this;
  }

  /**
   * Internal element type name which is defined in the OA system.
   * minimum: 1
   * maximum: 1
   * @return elementType
  **/
  @ApiModelProperty(value = "Internal element type name which is defined in the OA system.")
  
  @Min(1) @Max(1)   public Integer getElementType() {
    return elementType;
  }

  public void setElementType(Integer elementType) {
    this.elementType = elementType;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData elementTypeFromSrc(String elementTypeFromSrc) {
    this.elementTypeFromSrc = elementTypeFromSrc;
    return this;
  }

  /**
   * Element type that is associated with this object in the source system.
   * @return elementTypeFromSrc
  **/
  @ApiModelProperty(example = "arki-topic-disclaimer", value = "Element type that is associated with this object in the source system.")
  
  @Size(max=300)   public String getElementTypeFromSrc() {
    return elementTypeFromSrc;
  }

  public void setElementTypeFromSrc(String elementTypeFromSrc) {
    this.elementTypeFromSrc = elementTypeFromSrc;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData dataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the object data inside the source system.
   * @return dataIdFromSrc
  **/
  @ApiModelProperty(example = "DE_gjdlfjgsodufg78-51kjhkjhfg9v879d8g3-de-DE", value = "Id which identifies the object data inside the source system.")
  
  @Size(max=1024)   public String getDataIdFromSrc() {
    return dataIdFromSrc;
  }

  public void setDataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData mediaData(List<DomContentServiceMediaSchema> mediaData) {
    this.mediaData = mediaData;
    return this;
  }

  public DomcontentservicemessagingSchemaMessageDataDataData addMediaDataItem(DomContentServiceMediaSchema mediaDataItem) {
    if (this.mediaData == null) {
      this.mediaData = new ArrayList<>();
    }
    this.mediaData.add(mediaDataItem);
    return this;
  }

  /**
   * A list that provides information regarding media objects.
   * @return mediaData
  **/
  @ApiModelProperty(value = "A list that provides information regarding media objects.")
      @Valid
    public List<DomContentServiceMediaSchema> getMediaData() {
    return mediaData;
  }

  public void setMediaData(List<DomContentServiceMediaSchema> mediaData) {
    this.mediaData = mediaData;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomcontentservicemessagingSchemaMessageDataDataData domcontentservicemessagingSchemaMessageDataDataData = (DomcontentservicemessagingSchemaMessageDataDataData) o;
    return Objects.equals(this.objectUri, domcontentservicemessagingSchemaMessageDataDataData.objectUri) &&
        Objects.equals(this.objectIdFromSrc, domcontentservicemessagingSchemaMessageDataDataData.objectIdFromSrc) &&
        Objects.equals(this.elementType, domcontentservicemessagingSchemaMessageDataDataData.elementType) &&
        Objects.equals(this.elementTypeFromSrc, domcontentservicemessagingSchemaMessageDataDataData.elementTypeFromSrc) &&
        Objects.equals(this.dataIdFromSrc, domcontentservicemessagingSchemaMessageDataDataData.dataIdFromSrc) &&
        Objects.equals(this.mediaData, domcontentservicemessagingSchemaMessageDataDataData.mediaData);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectUri, objectIdFromSrc, elementType, elementTypeFromSrc, dataIdFromSrc, mediaData);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicemessagingSchemaMessageDataDataData {\n");

    sb.append("    objectUri: ").append(toIndentedString(objectUri)).append("\n");
    sb.append("    objectIdFromSrc: ").append(toIndentedString(objectIdFromSrc)).append("\n");
    sb.append("    elementType: ").append(toIndentedString(elementType)).append("\n");
    sb.append("    elementTypeFromSrc: ").append(toIndentedString(elementTypeFromSrc)).append("\n");
    sb.append("    dataIdFromSrc: ").append(toIndentedString(dataIdFromSrc)).append("\n");
    sb.append("    mediaData: ").append(toIndentedString(mediaData)).append("\n");
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
