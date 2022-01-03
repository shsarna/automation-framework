package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * A language object consists of a language code and a language locale
 */
@ApiModel(description = "A language object consists of a language code and a language locale")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-20T16:17:41.083512900+02:00[Europe/Berlin]")
public class DomcontentservicepackagesSchemaMessageDataLanguages   {
  @JsonProperty("language")
  private String language = null;

  @JsonProperty("locale")
  private String locale = null;

  public DomcontentservicepackagesSchemaMessageDataLanguages language(String language) {
    this.language = language;
    return this;
  }

  /**
   * Language code e.g. 'de', 'en'.
   * @return language
  **/
  @ApiModelProperty(example = "de", required = true, value = "Language code e.g. 'de', 'en'.")
      @NotNull

  @Size(min=1,max=5)   public String getLanguage() {
    return language;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public DomcontentservicepackagesSchemaMessageDataLanguages locale(String locale) {
    this.locale = locale;
    return this;
  }

  /**
   * Locale e.g.: 'gb' (as in 'en_GB').
   * @return locale
  **/
  @ApiModelProperty(example = "DE", required = true, value = "Locale e.g.: 'gb' (as in 'en_GB').")
      @NotNull

  @Size(min=1,max=5)   public String getLocale() {
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
    DomcontentservicepackagesSchemaMessageDataLanguages domcontentservicepackagesSchemaMessageDataLanguages = (DomcontentservicepackagesSchemaMessageDataLanguages) o;
    return Objects.equals(this.language, domcontentservicepackagesSchemaMessageDataLanguages.language) &&
        Objects.equals(this.locale, domcontentservicepackagesSchemaMessageDataLanguages.locale);
  }

  @Override
  public int hashCode() {
    return Objects.hash(language, locale);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicepackagesSchemaMessageDataLanguages {\n");
    
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
