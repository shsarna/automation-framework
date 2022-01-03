package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Additional information regarding the provided resource.
 */
@ApiModel(description = "Additional information regarding the provided resource.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class OacontentservicemessagingSchemaMessageDataDataData   {
  @JsonProperty("objectType")
  private String objectType = null;

  @JsonProperty("objectTypeFromSrc")
  private String objectTypeFromSrc = null;

  @JsonProperty("objectIdFromSrc")
  private String objectIdFromSrc = null;

  @JsonProperty("objectUri")
  private String objectUri = null;

  @JsonProperty("dataIdFromSrc")
  private String dataIdFromSrc = null;

  @JsonProperty("mediaRefDataId")
  private BigDecimal mediaRefDataId = null;

  @JsonProperty("xmlDataId")
  private BigDecimal xmlDataId = null;

  public OacontentservicemessagingSchemaMessageDataDataData objectType(String objectType) {
    this.objectType = objectType;
    return this;
  }

  /**
   * Internal object type name which is defined in the OA system.
   * @return objectType
  **/
  @ApiModelProperty(example = "topic", required = true, value = "Internal object type name which is defined in the OA system.")
      @NotNull

  @Size(max=50)   public String getObjectType() {
    return objectType;
  }

  public void setObjectType(String objectType) {
    this.objectType = objectType;
  }

  public OacontentservicemessagingSchemaMessageDataDataData objectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
    return this;
  }

  /**
   * Object type that is associated with this object in the source system.
   * @return objectTypeFromSrc
  **/
  @ApiModelProperty(example = "arki-frag-warn-controls", required = true, value = "Object type that is associated with this object in the source system.")
      @NotNull

  @Size(max=300)   public String getObjectTypeFromSrc() {
    return objectTypeFromSrc;
  }

  public void setObjectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
  }

  public OacontentservicemessagingSchemaMessageDataDataData objectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
    return this;
  }

  /**
   * Unique Identifier of this object in the source system.
   * @return objectIdFromSrc
  **/
  @ApiModelProperty(example = "51kjhkjhfg9v879d8g3", required = true, value = "Unique Identifier of this object in the source system.")
      @NotNull

  @Size(max=1024)   public String getObjectIdFromSrc() {
    return objectIdFromSrc;
  }

  public void setObjectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
  }

  public OacontentservicemessagingSchemaMessageDataDataData objectUri(String objectUri) {
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

  public OacontentservicemessagingSchemaMessageDataDataData dataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the object data inside the source system. E.g. for objects obtained from ARKI CMS the y.id is used here.
   * @return dataIdFromSrc
  **/
  @ApiModelProperty(example = "DE_gjdlfjgsodufg78-51kjhkjhfg9v879d8g3-de-DE", value = "Id which identifies the object data inside the source system. E.g. for objects obtained from ARKI CMS the y.id is used here.")
  
  @Size(max=1024)   public String getDataIdFromSrc() {
    return dataIdFromSrc;
  }

  public void setDataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
  }

  public OacontentservicemessagingSchemaMessageDataDataData mediaRefDataId(BigDecimal mediaRefDataId) {
    this.mediaRefDataId = mediaRefDataId;
    return this;
  }

  /**
   * Internal id of the media data.
   * @return mediaRefDataId
  **/
  @ApiModelProperty(value = "Internal id of the media data.")
  
    @Valid
    public BigDecimal getMediaRefDataId() {
    return mediaRefDataId;
  }

  public void setMediaRefDataId(BigDecimal mediaRefDataId) {
    this.mediaRefDataId = mediaRefDataId;
  }

  public OacontentservicemessagingSchemaMessageDataDataData xmlDataId(BigDecimal xmlDataId) {
    this.xmlDataId = xmlDataId;
    return this;
  }

  /**
   * Internal id of the xml payload data.
   * @return xmlDataId
  **/
  @ApiModelProperty(value = "Internal id of the xml payload data.")
  
    @Valid
    public BigDecimal getXmlDataId() {
    return xmlDataId;
  }

  public void setXmlDataId(BigDecimal xmlDataId) {
    this.xmlDataId = xmlDataId;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OacontentservicemessagingSchemaMessageDataDataData oacontentservicemessagingSchemaMessageDataDataData = (OacontentservicemessagingSchemaMessageDataDataData) o;
    return Objects.equals(this.objectType, oacontentservicemessagingSchemaMessageDataDataData.objectType) &&
        Objects.equals(this.objectTypeFromSrc, oacontentservicemessagingSchemaMessageDataDataData.objectTypeFromSrc) &&
        Objects.equals(this.objectIdFromSrc, oacontentservicemessagingSchemaMessageDataDataData.objectIdFromSrc) &&
        Objects.equals(this.objectUri, oacontentservicemessagingSchemaMessageDataDataData.objectUri) &&
        Objects.equals(this.dataIdFromSrc, oacontentservicemessagingSchemaMessageDataDataData.dataIdFromSrc) &&
        Objects.equals(this.mediaRefDataId, oacontentservicemessagingSchemaMessageDataDataData.mediaRefDataId) &&
        Objects.equals(this.xmlDataId, oacontentservicemessagingSchemaMessageDataDataData.xmlDataId);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectType, objectTypeFromSrc, objectIdFromSrc, objectUri, dataIdFromSrc, mediaRefDataId, xmlDataId);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OacontentservicemessagingSchemaMessageDataDataData {\n");

    sb.append("    objectType: ").append(toIndentedString(objectType)).append("\n");
    sb.append("    objectTypeFromSrc: ").append(toIndentedString(objectTypeFromSrc)).append("\n");
    sb.append("    objectIdFromSrc: ").append(toIndentedString(objectIdFromSrc)).append("\n");
    sb.append("    objectUri: ").append(toIndentedString(objectUri)).append("\n");
    sb.append("    dataIdFromSrc: ").append(toIndentedString(dataIdFromSrc)).append("\n");
    sb.append("    mediaRefDataId: ").append(toIndentedString(mediaRefDataId)).append("\n");
    sb.append("    xmlDataId: ").append(toIndentedString(xmlDataId)).append("\n");
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
