package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * An object to define a requested payload based on metadata.
 */
@ApiModel(description = "An object to define a requested payload based on metadata.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServicePayloadObjectSchema   {
  @JsonProperty("objectPayloadId")
  private BigDecimal objectPayloadId = null;

  @JsonProperty("dataIdFromSrc")
  private String dataIdFromSrc = null;

  @JsonProperty("versionFromSrc")
  private String versionFromSrc = null;

  @JsonProperty("revision")
  private BigDecimal revision = null;

  @JsonProperty("mimeType")
  private String mimeType = null;

  @JsonProperty("language")
  private String language = null;

  @JsonProperty("locale")
  private String locale = null;

  @JsonProperty("validFrom")
  private String validFrom = null;

  @JsonProperty("validTo")
  private String validTo = null;

  @JsonProperty("imageData")
  private OaContentServiceImageObjectSchema imageData = null;

  @JsonProperty("mediaRefData")
  private OaContentServiceMediaObjectSchema mediaRefData = null;

  @JsonProperty("xmlData")
  private OaContentServiceXmlObjectSchema xmlData = null;

  @JsonProperty("textData")
  private OaContentServiceTextObjectSchema textData = null;

  public OaContentServicePayloadObjectSchema objectPayloadId(BigDecimal objectPayloadId) {
    this.objectPayloadId = objectPayloadId;
    return this;
  }

  /**
   * Internal Id of the payload.
   * @return objectPayloadId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the payload.")
  @NotNull

  @Valid
  public BigDecimal getObjectPayloadId() {
    return objectPayloadId;
  }

  public void setObjectPayloadId(BigDecimal objectPayloadId) {
    this.objectPayloadId = objectPayloadId;
  }

  public OaContentServicePayloadObjectSchema dataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the object data inside the source system. E.g. for objects obtained from ARKI CMS the y.id is used here.
   * @return dataIdFromSrc
  **/
  @ApiModelProperty(required = true, value = "Id which identifies the object data inside the source system. E.g. for objects obtained from ARKI CMS the y.id is used here.")
  @NotNull

@Size(max=1024)   public String getDataIdFromSrc() {
    return dataIdFromSrc;
  }

  public void setDataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
  }

  public OaContentServicePayloadObjectSchema versionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
    return this;
  }

  /**
   * Version of the object data from the source system.
   * @return versionFromSrc
  **/
  @ApiModelProperty(required = true, value = "Version of the object data from the source system.")
  @NotNull

@Size(max=50)   public String getVersionFromSrc() {
    return versionFromSrc;
  }

  public void setVersionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
  }

  public OaContentServicePayloadObjectSchema revision(BigDecimal revision) {
    this.revision = revision;
    return this;
  }

  /**
   * OA internal revision or version of the data.
   * @return revision
  **/
  @ApiModelProperty(required = true, value = "OA internal revision or version of the data.")
  @NotNull

  @Valid
  public BigDecimal getRevision() {
    return revision;
  }

  public void setRevision(BigDecimal revision) {
    this.revision = revision;
  }

  public OaContentServicePayloadObjectSchema mimeType(String mimeType) {
    this.mimeType = mimeType;
    return this;
  }

  /**
   * The MIME type specifies the data format of the object's payload.
   * @return mimeType
  **/
  @ApiModelProperty(required = true, value = "The MIME type specifies the data format of the object's payload.")
  @NotNull

@Size(max=255)   public String getMimeType() {
    return mimeType;
  }

  public void setMimeType(String mimeType) {
    this.mimeType = mimeType;
  }

  public OaContentServicePayloadObjectSchema language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language of the referenced payload. 
   * @return language
  **/
  @ApiModelProperty(required = true, value = "Language of the referenced payload. ")
  @NotNull

@Size(max=5)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public OaContentServicePayloadObjectSchema locale(String locale) {
    this.locale = locale;
    return this;
  }

  /**
   * Localization of the language used in different countries.
   * @return locale
  **/
  @ApiModelProperty(required = true, value = "Localization of the language used in different countries.")
  @NotNull

@Size(max=5)   public String getLocale() {
    return locale;
  }

  public void setLocale(String locale) {
    this.locale = locale;
  }

  public OaContentServicePayloadObjectSchema validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when the object is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(required = true, value = "Point of time, from when the object is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")
  @NotNull

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServicePayloadObjectSchema validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until the object is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(required = true, value = "Point of time, until the object is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")
  @NotNull

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidTo() {
    return validTo;
  }

  public void setValidTo(String validTo) {
    this.validTo = validTo;
  }

  public OaContentServicePayloadObjectSchema imageData(OaContentServiceImageObjectSchema imageData) {
    this.imageData = imageData;
    return this;
  }

  /**
   * Get imageData
   * @return imageData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceImageObjectSchema getImageData() {
    return imageData;
  }

  public void setImageData(OaContentServiceImageObjectSchema imageData) {
    this.imageData = imageData;
  }

  public OaContentServicePayloadObjectSchema mediaRefData(OaContentServiceMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
    return this;
  }

  /**
   * Get mediaRefData
   * @return mediaRefData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceMediaObjectSchema getMediaRefData() {
    return mediaRefData;
  }

  public void setMediaRefData(OaContentServiceMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
  }

  public OaContentServicePayloadObjectSchema xmlData(OaContentServiceXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
    return this;
  }

  /**
   * Get xmlData
   * @return xmlData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceXmlObjectSchema getXmlData() {
    return xmlData;
  }

  public void setXmlData(OaContentServiceXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
  }

  public OaContentServicePayloadObjectSchema textData(OaContentServiceTextObjectSchema textData) {
    this.textData = textData;
    return this;
  }

  /**
   * Get textData
   * @return textData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceTextObjectSchema getTextData() {
    return textData;
  }

  public void setTextData(OaContentServiceTextObjectSchema textData) {
    this.textData = textData;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServicePayloadObjectSchema oaContentServicePayloadObjectSchema = (OaContentServicePayloadObjectSchema) o;
    return Objects.equals(this.objectPayloadId, oaContentServicePayloadObjectSchema.objectPayloadId) &&
        Objects.equals(this.dataIdFromSrc, oaContentServicePayloadObjectSchema.dataIdFromSrc) &&
        Objects.equals(this.versionFromSrc, oaContentServicePayloadObjectSchema.versionFromSrc) &&
        Objects.equals(this.revision, oaContentServicePayloadObjectSchema.revision) &&
        Objects.equals(this.mimeType, oaContentServicePayloadObjectSchema.mimeType) &&
        Objects.equals(this.language, oaContentServicePayloadObjectSchema.language) &&
        Objects.equals(this.locale, oaContentServicePayloadObjectSchema.locale) &&
        Objects.equals(this.validFrom, oaContentServicePayloadObjectSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServicePayloadObjectSchema.validTo) &&
        Objects.equals(this.imageData, oaContentServicePayloadObjectSchema.imageData) &&
        Objects.equals(this.mediaRefData, oaContentServicePayloadObjectSchema.mediaRefData) &&
        Objects.equals(this.xmlData, oaContentServicePayloadObjectSchema.xmlData) &&
        Objects.equals(this.textData, oaContentServicePayloadObjectSchema.textData);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectPayloadId, dataIdFromSrc, versionFromSrc, revision, mimeType, language, locale, validFrom, validTo, imageData, mediaRefData, xmlData, textData);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServicePayloadObjectSchema {\n");
    
    sb.append("    objectPayloadId: ").append(toIndentedString(objectPayloadId)).append("\n");
    sb.append("    dataIdFromSrc: ").append(toIndentedString(dataIdFromSrc)).append("\n");
    sb.append("    versionFromSrc: ").append(toIndentedString(versionFromSrc)).append("\n");
    sb.append("    revision: ").append(toIndentedString(revision)).append("\n");
    sb.append("    mimeType: ").append(toIndentedString(mimeType)).append("\n");
    sb.append("    language: ").append(toIndentedString(language)).append("\n");
    sb.append("    locale: ").append(toIndentedString(locale)).append("\n");
    sb.append("    validFrom: ").append(toIndentedString(validFrom)).append("\n");
    sb.append("    validTo: ").append(toIndentedString(validTo)).append("\n");
    sb.append("    imageData: ").append(toIndentedString(imageData)).append("\n");
    sb.append("    mediaRefData: ").append(toIndentedString(mediaRefData)).append("\n");
    sb.append("    xmlData: ").append(toIndentedString(xmlData)).append("\n");
    sb.append("    textData: ").append(toIndentedString(textData)).append("\n");
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
