package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * Metadata objects for a market.
 */
@ApiModel(description = "Metadata objects for a market.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchMarketObjectSchema2   {
  @JsonProperty("name")
  private String name = null;

  public OaContentServiceSearchMarketObjectSchema2 name(String name) {
    this.name = name;
    return this;
  }

  /**
   * The market stored here, is the market, for which an Owners Manual is intended for (e.g. \"ece/row\").
   * @return name
  **/
  @ApiModelProperty(required = true, value = "The market stored here, is the market, for which an Owners Manual is intended for (e.g. \"ece/row\").")
  @NotNull

@Size(max=10)   public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchMarketObjectSchema2 oaContentServiceSearchMarketObjectSchema2 = (OaContentServiceSearchMarketObjectSchema2) o;
    return Objects.equals(this.name, oaContentServiceSearchMarketObjectSchema2.name);
  }

  @Override
  public int hashCode() {
    return Objects.hash(name);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchMarketObjectSchema2 {\n");
    
    sb.append("    name: ").append(toIndentedString(name)).append("\n");
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
