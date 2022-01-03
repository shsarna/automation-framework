package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object to store phonemes.
 */
@ApiModel(description = "An object to store phonemes.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceUpdatePhonemeSchema   {
  @JsonProperty("phonemeId")
  private BigDecimal phonemeId = null;

  @JsonProperty("mainPhonemeValue")
  private String mainPhonemeValue = null;

  @JsonProperty("altPhonemeValues")
  @Valid
  private List<String> altPhonemeValues = null;

  public OaContentServiceUpdatePhonemeSchema phonemeId(BigDecimal phonemeId) {
    this.phonemeId = phonemeId;
    return this;
  }

  /**
   * Internal id of the phoneme.
   * @return phonemeId
  **/
  @ApiModelProperty(value = "Internal id of the phoneme.")

  @Valid
  public BigDecimal getPhonemeId() {
    return phonemeId;
  }

  public void setPhonemeId(BigDecimal phonemeId) {
    this.phonemeId = phonemeId;
  }

  public OaContentServiceUpdatePhonemeSchema mainPhonemeValue(String mainPhonemeValue) {
    this.mainPhonemeValue = mainPhonemeValue;
    return this;
  }

  /**
   * A phoneme string which is associated to a keyword is a written description of how the keyword sounds. It is used to search for certain keywords by speech.  
   * @return mainPhonemeValue
  **/
  @ApiModelProperty(required = true, value = "A phoneme string which is associated to a keyword is a written description of how the keyword sounds. It is used to search for certain keywords by speech.  ")
  @NotNull

@Size(max=400)   public String getMainPhonemeValue() {
    return mainPhonemeValue;
  }

  public void setMainPhonemeValue(String mainPhonemeValue) {
    this.mainPhonemeValue = mainPhonemeValue;
  }

  public OaContentServiceUpdatePhonemeSchema altPhonemeValues(List<String> altPhonemeValues) {
    this.altPhonemeValues = altPhonemeValues;
    return this;
  }

  public OaContentServiceUpdatePhonemeSchema addAltPhonemeValuesItem(String altPhonemeValuesItem) {
    if (this.altPhonemeValues == null) {
      this.altPhonemeValues = new ArrayList<>();
    }
    this.altPhonemeValues.add(altPhonemeValuesItem);
    return this;
  }

  /**
   * Alternative phoneme of a keyword.  
   * @return altPhonemeValues
  **/
  @ApiModelProperty(value = "Alternative phoneme of a keyword.  ")

  public List<String> getAltPhonemeValues() {
    return altPhonemeValues;
  }

  public void setAltPhonemeValues(List<String> altPhonemeValues) {
    this.altPhonemeValues = altPhonemeValues;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceUpdatePhonemeSchema oaContentServiceUpdatePhonemeSchema = (OaContentServiceUpdatePhonemeSchema) o;
    return Objects.equals(this.phonemeId, oaContentServiceUpdatePhonemeSchema.phonemeId) &&
        Objects.equals(this.mainPhonemeValue, oaContentServiceUpdatePhonemeSchema.mainPhonemeValue) &&
        Objects.equals(this.altPhonemeValues, oaContentServiceUpdatePhonemeSchema.altPhonemeValues);
  }

  @Override
  public int hashCode() {
    return Objects.hash(phonemeId, mainPhonemeValue, altPhonemeValues);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceUpdatePhonemeSchema {\n");
    
    sb.append("    phonemeId: ").append(toIndentedString(phonemeId)).append("\n");
    sb.append("    mainPhonemeValue: ").append(toIndentedString(mainPhonemeValue)).append("\n");
    sb.append("    altPhonemeValues: ").append(toIndentedString(altPhonemeValues)).append("\n");
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
