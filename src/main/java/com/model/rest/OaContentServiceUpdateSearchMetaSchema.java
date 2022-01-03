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
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object to store search metadata.
 */
@ApiModel(description = "An object to store search metadata.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceUpdateSearchMetaSchema   {
  @JsonProperty("searchMetaId")
  private BigDecimal searchMetaId = null;

  @JsonProperty("searchMetaIdFromSrc")
  private String searchMetaIdFromSrc = null;

  @JsonProperty("language")
  private String language = null;

  @JsonProperty("locale")
  private String locale = null;

  @JsonProperty("versionFromSrc")
  private String versionFromSrc = null;

  @JsonProperty("keywords")
  @Valid
  private List<OaContentServiceUpdateKeywordSchema> keywords = null;

  @JsonProperty("validFrom")
  private String validFrom = null;

  @JsonProperty("validTo")
  private String validTo = null;

  public OaContentServiceUpdateSearchMetaSchema searchMetaId(BigDecimal searchMetaId) {
    this.searchMetaId = searchMetaId;
    return this;
  }

  /**
   * Internal id of the search metadata.
   * @return searchMetaId
  **/
  @ApiModelProperty(required = true, value = "Internal id of the search metadata.")
  @NotNull

  @Valid
  public BigDecimal getSearchMetaId() {
    return searchMetaId;
  }

  public void setSearchMetaId(BigDecimal searchMetaId) {
    this.searchMetaId = searchMetaId;
  }

  public OaContentServiceUpdateSearchMetaSchema searchMetaIdFromSrc(String searchMetaIdFromSrc) {
    this.searchMetaIdFromSrc = searchMetaIdFromSrc;
    return this;
  }

  /**
   * Id which identifies the search metadata in the source system.
   * @return searchMetaIdFromSrc
  **/
  @ApiModelProperty(required = true, value = "Id which identifies the search metadata in the source system.")
  @NotNull

@Size(max=1024)   public String getSearchMetaIdFromSrc() {
    return searchMetaIdFromSrc;
  }

  public void setSearchMetaIdFromSrc(String searchMetaIdFromSrc) {
    this.searchMetaIdFromSrc = searchMetaIdFromSrc;
  }

  public OaContentServiceUpdateSearchMetaSchema language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language of the search metadata.
   * @return language
  **/
  @ApiModelProperty(required = true, value = "Language of the search metadata.")
  @NotNull

@Size(max=5)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public OaContentServiceUpdateSearchMetaSchema locale(String locale) {
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

  public OaContentServiceUpdateSearchMetaSchema versionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
    return this;
  }

  /**
   * Version of the search metadata from the source system.  
   * @return versionFromSrc
  **/
  @ApiModelProperty(required = true, value = "Version of the search metadata from the source system.  ")
  @NotNull

@Size(max=50)   public String getVersionFromSrc() {
    return versionFromSrc;
  }

  public void setVersionFromSrc(String versionFromSrc) {
    this.versionFromSrc = versionFromSrc;
  }

  public OaContentServiceUpdateSearchMetaSchema keywords(List<OaContentServiceUpdateKeywordSchema> keywords) {
    this.keywords = keywords;
    return this;
  }

  public OaContentServiceUpdateSearchMetaSchema addKeywordsItem(OaContentServiceUpdateKeywordSchema keywordsItem) {
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
  public List<OaContentServiceUpdateKeywordSchema> getKeywords() {
    return keywords;
  }

  public void setKeywords(List<OaContentServiceUpdateKeywordSchema> keywords) {
    this.keywords = keywords;
  }

  public OaContentServiceUpdateSearchMetaSchema validFrom(String validFrom) {
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

  public OaContentServiceUpdateSearchMetaSchema validTo(String validTo) {
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
    OaContentServiceUpdateSearchMetaSchema oaContentServiceUpdateSearchMetaSchema = (OaContentServiceUpdateSearchMetaSchema) o;
    return Objects.equals(this.searchMetaId, oaContentServiceUpdateSearchMetaSchema.searchMetaId) &&
        Objects.equals(this.searchMetaIdFromSrc, oaContentServiceUpdateSearchMetaSchema.searchMetaIdFromSrc) &&
        Objects.equals(this.language, oaContentServiceUpdateSearchMetaSchema.language) &&
        Objects.equals(this.locale, oaContentServiceUpdateSearchMetaSchema.locale) &&
        Objects.equals(this.versionFromSrc, oaContentServiceUpdateSearchMetaSchema.versionFromSrc) &&
        Objects.equals(this.keywords, oaContentServiceUpdateSearchMetaSchema.keywords) &&
        Objects.equals(this.validFrom, oaContentServiceUpdateSearchMetaSchema.validFrom) &&
        Objects.equals(this.validTo, oaContentServiceUpdateSearchMetaSchema.validTo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(searchMetaId, searchMetaIdFromSrc, language, locale, versionFromSrc, keywords, validFrom, validTo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceUpdateSearchMetaSchema {\n");
    
    sb.append("    searchMetaId: ").append(toIndentedString(searchMetaId)).append("\n");
    sb.append("    searchMetaIdFromSrc: ").append(toIndentedString(searchMetaIdFromSrc)).append("\n");
    sb.append("    language: ").append(toIndentedString(language)).append("\n");
    sb.append("    locale: ").append(toIndentedString(locale)).append("\n");
    sb.append("    versionFromSrc: ").append(toIndentedString(versionFromSrc)).append("\n");
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
