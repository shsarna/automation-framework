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
 * An object to define an imported payload data.
 */
@ApiModel(description = "An object to define an imported payload data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceImportSinglePayloadObjectSchema   {
  @JsonProperty("objectId")
  private BigDecimal objectId = null;

  @JsonProperty("dataIdFromSrc")
  private String dataIdFromSrc = null;

  @JsonProperty("versionFromSrc")
  private String versionFromSrc = null;

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
  private OaContentServiceImportImageObjectSchema imageData = null;

  @JsonProperty("mediaRefData")
  private OaContentServiceImportMediaObjectSchema mediaRefData = null;

  @JsonProperty("xmlData")
  private OaContentServiceImportXmlObjectSchema xmlData = null;

  @JsonProperty("textData")
  private OaContentServiceImportTextObjectSchema textData = null;

  public OaContentServiceImportSinglePayloadObjectSchema objectId(BigDecimal objectId) {
    this.objectId = objectId;
    return this;
  }

  /**
   * The unique Id of the object the payloads are assigned to.
   * @return objectId
  **/
  @ApiModelProperty(required = true, value = "The unique Id of the object the payloads are assigned to.")
  @NotNull

  @Valid
  public BigDecimal getObjectId() {
    return objectId;
  }

  public void setObjectId(BigDecimal objectId) {
    this.objectId = objectId;
  }

  public OaContentServiceImportSinglePayloadObjectSchema dataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the object data inside the source system.  E.g. for objects obtained from ARKI CMS the y.id is used here.
   * @return dataIdFromSrc
  **/
  @ApiModelProperty(value = "Id which identifies the object data inside the source system.  E.g. for objects obtained from ARKI CMS the y.id is used here.")

@Size(max=1024)   public String getDataIdFromSrc() {
    return dataIdFromSrc;
  }

  public void setDataIdFromSrc(String dataIdFromSrc) {
    this.dataIdFromSrc = dataIdFromSrc;
  }

  public OaContentServiceImportSinglePayloadObjectSchema versionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
    return this;
  }

  /**
   * Version of the object data from the source system.
   * @return versionFromSrc
  **/
  @ApiModelProperty(value = "Version of the object data from the source system.")

@Size(max=50)   public String getVersionFromSrc() {
    return versionFromSrc;
  }

  public void setVersionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
  }

  public OaContentServiceImportSinglePayloadObjectSchema mimeType(String mimeType) {
    this.mimeType = mimeType;
    return this;
  }

  /**
   * The MIME type specifies the data format of the object's payload.
   * @return mimeType
  **/
  @ApiModelProperty(value = "The MIME type specifies the data format of the object's payload.")

@Size(max=255)   public String getMimeType() {
    return mimeType;
  }

  public void setMimeType(String mimeType) {
    this.mimeType = mimeType;
  }

  public OaContentServiceImportSinglePayloadObjectSchema language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language of the referenced payload. 
   * @return language
  **/
  @ApiModelProperty(value = "Language of the referenced payload. ")

@Size(max=5)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public OaContentServiceImportSinglePayloadObjectSchema locale(String locale) {
    this.locale = locale;
    return this;
  }

  /**
   * Localization of the language used in different countries.
   * @return locale
  **/
  @ApiModelProperty(value = "Localization of the language used in different countries.")

@Size(max=5)   public String getLocale() {
    return locale;
  }

  public void setLocale(String locale) {
    this.locale = locale;
  }

  public OaContentServiceImportSinglePayloadObjectSchema validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when the payload data is valid from. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(value = "Point of time, from when the payload data is valid from. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServiceImportSinglePayloadObjectSchema validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until the payload data is valid to. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(value = "Point of time, until the payload data is valid to. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidTo() {
    return validTo;
  }

  public void setValidTo(String validTo) {
    this.validTo = validTo;
  }

  public OaContentServiceImportSinglePayloadObjectSchema imageData(OaContentServiceImportImageObjectSchema imageData) {
    this.imageData = imageData;
    return this;
  }

  /**
   * Get imageData
   * @return imageData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceImportImageObjectSchema getImageData() {
    return imageData;
  }

  public void setImageData(OaContentServiceImportImageObjectSchema imageData) {
    this.imageData = imageData;
  }

  public OaContentServiceImportSinglePayloadObjectSchema mediaRefData(OaContentServiceImportMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
    return this;
  }

  /**
   * Get mediaRefData
   * @return mediaRefData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceImportMediaObjectSchema getMediaRefData() {
    return mediaRefData;
  }

  public void setMediaRefData(OaContentServiceImportMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
  }

  public OaContentServiceImportSinglePayloadObjectSchema xmlData(OaContentServiceImportXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
    return this;
  }

  /**
   * Get xmlData
   * @return xmlData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceImportXmlObjectSchema getXmlData() {
    return xmlData;
  }

  public void setXmlData(OaContentServiceImportXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
  }

  public OaContentServiceImportSinglePayloadObjectSchema textData(OaContentServiceImportTextObjectSchema textData) {
    this.textData = textData;
    return this;
  }

  /**
   * Get textData
   * @return textData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceImportTextObjectSchema getTextData() {
    return textData;
  }

  public void setTextData(OaContentServiceImportTextObjectSchema textData) {
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
    OaContentServiceImportSinglePayloadObjectSchema oaContentServiceImportSinglePayloadObjectSchema = (OaContentServiceImportSinglePayloadObjectSchema) o;
    return Objects.equals(this.objectId, oaContentServiceImportSinglePayloadObjectSchema.objectId) &&
        Objects.equals(this.dataIdFromSrc, oaContentServiceImportSinglePayloadObjectSchema.dataIdFromSrc) &&
        Objects.equals(this.versionFromSrc, oaContentServiceImportSinglePayloadObjectSchema.versionFromSrc) &&
        Objects.equals(this.mimeType, oaContentServiceImportSinglePayloadObjectSchema.mimeType) &&
        Objects.equals(this.language, oaContentServiceImportSinglePayloadObjectSchema.language) &&
        Objects.equals(this.locale, oaContentServiceImportSinglePayloadObjectSchema.locale) &&
        Objects.equals(this.validFrom, oaContentServiceImportSinglePayloadObjectSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceImportSinglePayloadObjectSchema.validTo) &&
        Objects.equals(this.imageData, oaContentServiceImportSinglePayloadObjectSchema.imageData) &&
        Objects.equals(this.mediaRefData, oaContentServiceImportSinglePayloadObjectSchema.mediaRefData) &&
        Objects.equals(this.xmlData, oaContentServiceImportSinglePayloadObjectSchema.xmlData) &&
        Objects.equals(this.textData, oaContentServiceImportSinglePayloadObjectSchema.textData);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectId, dataIdFromSrc, versionFromSrc, mimeType, language, locale, validFrom, validTo, imageData, mediaRefData, xmlData, textData);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceImportSinglePayloadObjectSchema {\n");
    
    sb.append("    objectId: ").append(toIndentedString(objectId)).append("\n");
    sb.append("    dataIdFromSrc: ").append(toIndentedString(dataIdFromSrc)).append("\n");
    sb.append("    versionFromSrc: ").append(toIndentedString(versionFromSrc)).append("\n");
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
