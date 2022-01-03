package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * An object to define requested payload data based.
 */
@ApiModel(description = "An object to define requested payload data based.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchPayloadObjectSchema   {
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

  @JsonProperty("valid")
  private OaContentServiceSearchValidityObjectSchema valid = null;

  @JsonProperty("imageData")
  private OaContentServiceSearchImageObjectSchema imageData = null;

  @JsonProperty("mediaRefData")
  private OaContentServiceSearchMediaObjectSchema mediaRefData = null;

  @JsonProperty("xmlData")
  private OaContentServiceSearchXmlObjectSchema xmlData = null;

  public OaContentServiceSearchPayloadObjectSchema dataIdFromSrc(String dataIdFromSrc) {
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

  public OaContentServiceSearchPayloadObjectSchema versionFromSrc(String versionFromSrc) {
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

  public OaContentServiceSearchPayloadObjectSchema mimeType(String mimeType) {
    this.mimeType = mimeType;
    return this;
  }

  /**
   * The MIME type specifies the data format of the object's payload.  
   * @return mimeType
  **/
  @ApiModelProperty(value = "The MIME type specifies the data format of the object's payload.  ")

@Size(max=255)   public String getMimeType() {
    return mimeType;
  }

  public void setMimeType(String mimeType) {
    this.mimeType = mimeType;
  }

  public OaContentServiceSearchPayloadObjectSchema language(String language) {
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

  public OaContentServiceSearchPayloadObjectSchema locale(String locale) {
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

  public OaContentServiceSearchPayloadObjectSchema valid(OaContentServiceSearchValidityObjectSchema valid) {
    this.valid = valid;
    return this;
  }

  /**
   * Get valid
   * @return valid
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchValidityObjectSchema getValid() {
    return valid;
  }

  public void setValid(OaContentServiceSearchValidityObjectSchema valid) {
    this.valid = valid;
  }

  public OaContentServiceSearchPayloadObjectSchema imageData(OaContentServiceSearchImageObjectSchema imageData) {
    this.imageData = imageData;
    return this;
  }

  /**
   * Get imageData
   * @return imageData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchImageObjectSchema getImageData() {
    return imageData;
  }

  public void setImageData(OaContentServiceSearchImageObjectSchema imageData) {
    this.imageData = imageData;
  }

  public OaContentServiceSearchPayloadObjectSchema mediaRefData(OaContentServiceSearchMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
    return this;
  }

  /**
   * Get mediaRefData
   * @return mediaRefData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchMediaObjectSchema getMediaRefData() {
    return mediaRefData;
  }

  public void setMediaRefData(OaContentServiceSearchMediaObjectSchema mediaRefData) {
    this.mediaRefData = mediaRefData;
  }

  public OaContentServiceSearchPayloadObjectSchema xmlData(OaContentServiceSearchXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
    return this;
  }

  /**
   * Get xmlData
   * @return xmlData
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchXmlObjectSchema getXmlData() {
    return xmlData;
  }

  public void setXmlData(OaContentServiceSearchXmlObjectSchema xmlData) {
    this.xmlData = xmlData;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchPayloadObjectSchema oaContentServiceSearchPayloadObjectSchema = (OaContentServiceSearchPayloadObjectSchema) o;
    return Objects.equals(this.dataIdFromSrc, oaContentServiceSearchPayloadObjectSchema.dataIdFromSrc) &&
        Objects.equals(this.versionFromSrc, oaContentServiceSearchPayloadObjectSchema.versionFromSrc) &&
        Objects.equals(this.mimeType, oaContentServiceSearchPayloadObjectSchema.mimeType) &&
        Objects.equals(this.language, oaContentServiceSearchPayloadObjectSchema.language) &&
        Objects.equals(this.locale, oaContentServiceSearchPayloadObjectSchema.locale) &&
        Objects.equals(this.valid, oaContentServiceSearchPayloadObjectSchema.valid) &&
        Objects.equals(this.imageData, oaContentServiceSearchPayloadObjectSchema.imageData) &&
        Objects.equals(this.mediaRefData, oaContentServiceSearchPayloadObjectSchema.mediaRefData) &&
        Objects.equals(this.xmlData, oaContentServiceSearchPayloadObjectSchema.xmlData);
  }

  @Override
  public int hashCode() {
    return Objects.hash(dataIdFromSrc, versionFromSrc, mimeType, language, locale, valid, imageData, mediaRefData, xmlData);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchPayloadObjectSchema {\n");
    
    sb.append("    dataIdFromSrc: ").append(toIndentedString(dataIdFromSrc)).append("\n");
    sb.append("    versionFromSrc: ").append(toIndentedString(versionFromSrc)).append("\n");
    sb.append("    mimeType: ").append(toIndentedString(mimeType)).append("\n");
    sb.append("    language: ").append(toIndentedString(language)).append("\n");
    sb.append("    locale: ").append(toIndentedString(locale)).append("\n");
    sb.append("    valid: ").append(toIndentedString(valid)).append("\n");
    sb.append("    imageData: ").append(toIndentedString(imageData)).append("\n");
    sb.append("    mediaRefData: ").append(toIndentedString(mediaRefData)).append("\n");
    sb.append("    xmlData: ").append(toIndentedString(xmlData)).append("\n");
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
