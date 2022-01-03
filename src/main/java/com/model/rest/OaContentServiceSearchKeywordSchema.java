package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import java.util.Objects;

/**
 * An object to store keywords.
 */
@ApiModel(description = "An object to store keywords.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchKeywordSchema   {
  @JsonProperty("keywordValue")
  private String keywordValue = null;

  @JsonProperty("phonemes")
  private OaContentServiceSearchPhonemeSchema phonemes = null;

  public OaContentServiceSearchKeywordSchema keywordValue(String keywordValue) {
    this.keywordValue = keywordValue;
    return this;
  }

  /**
   * The keyword itself.
   * @return keywordValue
  **/
  @ApiModelProperty(value = "The keyword itself.")

  public String getKeywordValue() {
    return keywordValue;
  }

  public void setKeywordValue(String keywordValue) {
    this.keywordValue = keywordValue;
  }

  public OaContentServiceSearchKeywordSchema phonemes(OaContentServiceSearchPhonemeSchema phonemes) {
    this.phonemes = phonemes;
    return this;
  }

  /**
   * Get phonemes
   * @return phonemes
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchPhonemeSchema getPhonemes() {
    return phonemes;
  }

  public void setPhonemes(OaContentServiceSearchPhonemeSchema phonemes) {
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
    OaContentServiceSearchKeywordSchema oaContentServiceSearchKeywordSchema = (OaContentServiceSearchKeywordSchema) o;
    return Objects.equals(this.keywordValue, oaContentServiceSearchKeywordSchema.keywordValue) &&
        Objects.equals(this.phonemes, oaContentServiceSearchKeywordSchema.phonemes);
  }

  @Override
  public int hashCode() {
    return Objects.hash(keywordValue, phonemes);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchKeywordSchema {\n");
    
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
