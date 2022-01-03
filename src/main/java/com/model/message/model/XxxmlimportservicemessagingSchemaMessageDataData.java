package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * Additional information regarding the provided resource.
 */
@ApiModel(description = "Additional information regarding the provided resource.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class XxxmlimportservicemessagingSchemaMessageDataData   {
  @JsonProperty("validities")
  private DomServicesCommonNTupleObjectSchema validities = null;

  @JsonProperty("language")
  private String language = null;

  @JsonProperty("locale")
  private String locale = null;

  public XxxmlimportservicemessagingSchemaMessageDataData validities(DomServicesCommonNTupleObjectSchema validities) {
    this.validities = validities;
    return this;
  }

  /**
   * Get validities
   * @return validities
  **/
  @ApiModelProperty(required = true, value = "")
      @NotNull

    @Valid
    public DomServicesCommonNTupleObjectSchema getValidities() {
    return validities;
  }

  public void setValidities(DomServicesCommonNTupleObjectSchema validities) {
    this.validities = validities;
  }

  public XxxmlimportservicemessagingSchemaMessageDataData language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language in ISO-639-1.
   * @return language
  **/
  @ApiModelProperty(example = "de", required = true, value = "Language in ISO-639-1.")
      @NotNull

  @Size(min=2,max=2)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public XxxmlimportservicemessagingSchemaMessageDataData locale(String locale) {
    this.locale = locale;
    return this;
  }

  /**
   * Locale.
   * @return locale
  **/
  @ApiModelProperty(example = "DE", required = true, value = "Locale.")
      @NotNull

  @Size(min=2,max=2)   public String getLocale() {
    return locale;
  }

  public void setLocale(String locale) {
    this.locale = locale;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    XxxmlimportservicemessagingSchemaMessageDataData xxxmlimportservicemessagingSchemaMessageDataData = (XxxmlimportservicemessagingSchemaMessageDataData) o;
    return Objects.equals(this.validities, xxxmlimportservicemessagingSchemaMessageDataData.validities) &&
        Objects.equals(this.language, xxxmlimportservicemessagingSchemaMessageDataData.language) &&
        Objects.equals(this.locale, xxxmlimportservicemessagingSchemaMessageDataData.locale);
  }

  @Override
  public int hashCode() {
    return Objects.hash(validities, language, locale);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class XxxmlimportservicemessagingSchemaMessageDataData {\n");

    sb.append("    validities: ").append(toIndentedString(validities)).append("\n");
    sb.append("    language: ").append(toIndentedString(language)).append("\n");
    sb.append("    locale: ").append(toIndentedString(locale)).append("\n");
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
