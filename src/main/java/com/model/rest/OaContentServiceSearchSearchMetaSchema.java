package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object to store search metadata.
 */
@ApiModel(description = "An object to store search metadata.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchSearchMetaSchema   {
  @JsonProperty("searchMetaIdFromSrc")
  private String searchMetaIdFromSrc = null;

  @JsonProperty("versionFromSrc")
  private String versionFromSrc = null;

  @JsonProperty("language")
  private String language = null;

  @JsonProperty("locale")
  private String locale = null;

  @JsonProperty("keywords")
  @Valid
  private List<OaContentServiceSearchKeywordSchema> keywords = null;

  @JsonProperty("validFrom")
  private String validFrom = null;

  @JsonProperty("validTo")
  private String validTo = null;

  public OaContentServiceSearchSearchMetaSchema searchMetaIdFromSrc(String searchMetaIdFromSrc) {
    this.searchMetaIdFromSrc = searchMetaIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the search metadata in the source system.
   * @return searchMetaIdFromSrc
  **/
  @ApiModelProperty(value = "Id which identifies the search metadata in the source system.")

@Size(max=1024)   public String getSearchMetaIdFromSrc() {
    return searchMetaIdFromSrc;
  }

  public void setSearchMetaIdFromSrc(String searchMetaIdFromSrc) {
    this.searchMetaIdFromSrc = searchMetaIdFromSrc;
  }

  public OaContentServiceSearchSearchMetaSchema versionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
    return this;
  }

  /**
   * Version of the search metadata from the source system.
   * @return versionFromSrc
  **/
  @ApiModelProperty(value = "Version of the search metadata from the source system.")

@Size(max=50)   public String getVersionFromSrc() {
    return versionFromSrc;
  }

  public void setVersionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
  }

  public OaContentServiceSearchSearchMetaSchema language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language of the search metadata.
   * @return language
  **/
  @ApiModelProperty(value = "Language of the search metadata.")

@Size(max=5)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public OaContentServiceSearchSearchMetaSchema locale(String locale) {
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

  public OaContentServiceSearchSearchMetaSchema keywords(List<OaContentServiceSearchKeywordSchema> keywords) {
    this.keywords = keywords;
    return this;
  }

  public OaContentServiceSearchSearchMetaSchema addKeywordsItem(OaContentServiceSearchKeywordSchema keywordsItem) {
    if (this.keywords == null) {
      this.keywords = new ArrayList<>();
    }
    this.keywords.add(keywordsItem);
    return this;
  }

  /**
   * Keywords which can be assigned to topics.
   * @return keywords
  **/
  @ApiModelProperty(value = "Keywords which can be assigned to topics.")
  @Valid
  public List<OaContentServiceSearchKeywordSchema> getKeywords() {
    return keywords;
  }

  public void setKeywords(List<OaContentServiceSearchKeywordSchema> keywords) {
    this.keywords = keywords;
  }

  public OaContentServiceSearchSearchMetaSchema validFrom(String validFrom) {
    this.validFrom = validFrom;
    return this;
  }

  /**
   * Point of time, from when this search metadata is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validFrom
  **/
  @ApiModelProperty(value = "Point of time, from when this search metadata is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidFrom() {
    return validFrom;
  }

  public void setValidFrom(String validFrom) {
    this.validFrom = validFrom;
  }

  public OaContentServiceSearchSearchMetaSchema validTo(String validTo) {
    this.validTo = validTo;
    return this;
  }

  /**
   * Point of time, until this search metadata is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return validTo
  **/
  @ApiModelProperty(value = "Point of time, until this search metadata is valid. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getValidTo() {
    return validTo;
  }

  public void setValidTo(String validTo) {
    this.validTo = validTo;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchSearchMetaSchema oaContentServiceSearchSearchMetaSchema = (OaContentServiceSearchSearchMetaSchema) o;
    return Objects.equals(this.searchMetaIdFromSrc, oaContentServiceSearchSearchMetaSchema.searchMetaIdFromSrc) &&
        Objects.equals(this.versionFromSrc, oaContentServiceSearchSearchMetaSchema.versionFromSrc) &&
        Objects.equals(this.language, oaContentServiceSearchSearchMetaSchema.language) &&
        Objects.equals(this.locale, oaContentServiceSearchSearchMetaSchema.locale) &&
        Objects.equals(this.keywords, oaContentServiceSearchSearchMetaSchema.keywords) &&
        Objects.equals(this.validFrom, oaContentServiceSearchSearchMetaSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceSearchSearchMetaSchema.validTo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(searchMetaIdFromSrc, versionFromSrc, language, locale, keywords, validFrom, validTo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchSearchMetaSchema {\n");
    
    sb.append("    searchMetaIdFromSrc: ").append(toIndentedString(searchMetaIdFromSrc)).append("\n");
    sb.append("    versionFromSrc: ").append(toIndentedString(versionFromSrc)).append("\n");
    sb.append("    language: ").append(toIndentedString(language)).append("\n");
    sb.append("    locale: ").append(toIndentedString(locale)).append("\n");
    sb.append("    keywords: ").append(toIndentedString(keywords)).append("\n");
    sb.append("    validFrom: ").append(toIndentedString(validFrom)).append("\n");
    sb.append("    validTo: ").append(toIndentedString(validTo)).append("\n");
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
