package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * Information product data.
 */
@ApiModel(description = "Information product data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceIpObjectSchema   {
  @JsonProperty("name")
  private String name = null;

  public OaContentServiceIpObjectSchema name(String name) {
    this.name = name;
    return this;
  }

  /**
   * Name of the information product. This short name uniquely identifies the target medium.
   * @return name
  **/
  @ApiModelProperty(required = true, value = "Name of the information product. This short name uniquely identifies the target medium.")
  @NotNull

@Size(max=50)   public String getName() {
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
    OaContentServiceIpObjectSchema oaContentServiceIpObjectSchema = (OaContentServiceIpObjectSchema) o;
    return Objects.equals(this.name, oaContentServiceIpObjectSchema.name);
  }

  @Override
  public int hashCode() {
    return Objects.hash(name);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceIpObjectSchema {\n");
    
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
