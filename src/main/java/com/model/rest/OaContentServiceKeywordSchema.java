package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * An object to store keywords.
 */
@ApiModel(description = "An object to store keywords.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceKeywordSchema   {
  @JsonProperty("keywordId")
  private BigDecimal keywordId = null;

  @JsonProperty("keywordValue")
  private String keywordValue = null;

  @JsonProperty("phonemes")
  private OaContentServicePhonemeSchema phonemes = null;

  public OaContentServiceKeywordSchema keywordId(BigDecimal keywordId) {
    this.keywordId = keywordId;
    return this;
  }

  /**
   * Internal id of the keyword.
   * @return keywordId
  **/
  @ApiModelProperty(required = true, value = "Internal id of the keyword.")
  @NotNull

  @Valid
  public BigDecimal getKeywordId() {
    return keywordId;
  }

  public void setKeywordId(BigDecimal keywordId) {
    this.keywordId = keywordId;
  }

  public OaContentServiceKeywordSchema keywordValue(String keywordValue) {
    this.keywordValue = keywordValue;
    return this;
  }

  /**
   * The keyword itself.
   * @return keywordValue
  **/
  @ApiModelProperty(required = true, value = "The keyword itself.")
  @NotNull

  public String getKeywordValue() {
    return keywordValue;
  }

  public void setKeywordValue(String keywordValue) {
    this.keywordValue = keywordValue;
  }

  public OaContentServiceKeywordSchema phonemes(OaContentServicePhonemeSchema phonemes) {
    this.phonemes = phonemes;
    return this;
  }

  /**
   * Get phonemes
   * @return phonemes
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServicePhonemeSchema getPhonemes() {
    return phonemes;
  }

  public void setPhonemes(OaContentServicePhonemeSchema phonemes) {
    this.phonemes = phonemes;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceKeywordSchema oaContentServiceKeywordSchema = (OaContentServiceKeywordSchema) o;
    return Objects.equals(this.keywordId, oaContentServiceKeywordSchema.keywordId) &&
        Objects.equals(this.keywordValue, oaContentServiceKeywordSchema.keywordValue) &&
        Objects.equals(this.phonemes, oaContentServiceKeywordSchema.phonemes);
  }

  @Override
  public int hashCode() {
    return Objects.hash(keywordId, keywordValue, phonemes);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceKeywordSchema {\n");
    
    sb.append("    keywordId: ").append(toIndentedString(keywordId)).append("\n");
    sb.append("    keywordValue: ").append(toIndentedString(keywordValue)).append("\n");
    sb.append("    phonemes: ").append(toIndentedString(phonemes)).append("\n");
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
