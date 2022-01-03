package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import java.util.Objects;

/**
 * DomcontentservicemediaSchemaTags
 */
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomcontentservicemediaSchemaTags   {
  @JsonProperty("key")
  private String key = null;

  @JsonProperty("value")
  private String value = null;

  public DomcontentservicemediaSchemaTags key(String key) {
    this.key = key;
    return this;
  }

  /**
   * Key of the validity, e.g. \"hu-platform\".
   * @return key
  **/
  @ApiModelProperty(example = "hu-platform", required = true, value = "Key of the validity, e.g. \"hu-platform\".")
      @NotNull

    public String getKey() {
    return key;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public DomcontentservicemediaSchemaTags value(String value) {
    this.value = value;
    return this;
  }

  /**
   * Value of the validity, e.g. \"NTG7.0\".
   * @return value
  **/
  @ApiModelProperty(example = "NTG7.0", required = true, value = "Value of the validity, e.g. \"NTG7.0\".")
      @NotNull

    public String getValue() {
    return value;
  }

  public void setValue(String value) {
    this.value = value;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomcontentservicemediaSchemaTags domcontentservicemediaSchemaTags = (DomcontentservicemediaSchemaTags) o;
    return Objects.equals(this.key, domcontentservicemediaSchemaTags.key) &&
        Objects.equals(this.value, domcontentservicemediaSchemaTags.value);
  }

  @Override
  public int hashCode() {
    return Objects.hash(key, value);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicemediaSchemaTags {\n");

    sb.append("    key: ").append(toIndentedString(key)).append("\n");
    sb.append("    value: ").append(toIndentedString(value)).append("\n");
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
