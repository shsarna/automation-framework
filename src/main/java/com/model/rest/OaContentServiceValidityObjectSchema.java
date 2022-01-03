package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * Validities of an object, e.g. equipment code (also known as FIO) for topics.  
 */
@ApiModel(description = "Validities of an object, e.g. equipment code (also known as FIO) for topics.  ")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceValidityObjectSchema   {
  @JsonProperty("validityCode")
  private String validityCode = null;

  @JsonProperty("validityTypeName")
  private String validityTypeName = null;

  public OaContentServiceValidityObjectSchema validityCode(String validityCode) {
    this.validityCode = validityCode;
    return this;
  }

  /**
   * Value of the validity code.  Example values for validities of type \"equipment_code\" (FIO):   - \"ZX_581\" (for automatic air conditioning)  - \"ZX_Diesel_L\" (for all kinds of Diesel motors).  
   * @return validityCode
  **/
  @ApiModelProperty(required = true, value = "Value of the validity code.  Example values for validities of type \"equipment_code\" (FIO):   - \"ZX_581\" (for automatic air conditioning)  - \"ZX_Diesel_L\" (for all kinds of Diesel motors).  ")
  @NotNull

@Pattern(regexp="Z[A-Z]_[a-zA-Z0-9�������+-_]+") @Size(max=50)   public String getValidityCode() {
    return validityCode;
  }

  public void setValidityCode(String validityCode) {
    this.validityCode = validityCode;
  }

  public OaContentServiceValidityObjectSchema validityTypeName(String validityTypeName) {
    this.validityTypeName = validityTypeName;
    return this;
  }

  /**
   * Name of the validity_type.  Example value: \"equipment_code\", which defines a certain technical feature of a vehicle, like a certain motor, air conditioning, etc.
   * @return validityTypeName
  **/
  @ApiModelProperty(value = "Name of the validity_type.  Example value: \"equipment_code\", which defines a certain technical feature of a vehicle, like a certain motor, air conditioning, etc.")

@Size(max=50)   public String getValidityTypeName() {
    return validityTypeName;
  }

  public void setValidityTypeName(String validityTypeName) {
    this.validityTypeName = validityTypeName;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceValidityObjectSchema oaContentServiceValidityObjectSchema = (OaContentServiceValidityObjectSchema) o;
    return Objects.equals(this.validityCode, oaContentServiceValidityObjectSchema.validityCode) &&
        Objects.equals(this.validityTypeName, oaContentServiceValidityObjectSchema.validityTypeName);
  }

  @Override
  public int hashCode() {
    return Objects.hash(validityCode, validityTypeName);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceValidityObjectSchema {\n");
    
    sb.append("    validityCode: ").append(toIndentedString(validityCode)).append("\n");
    sb.append("    validityTypeName: ").append(toIndentedString(validityTypeName)).append("\n");
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
