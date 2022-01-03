package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

/**
 * An object to provide information of the vehicle line.
 */
@ApiModel(description = "An object to provide information of the vehicle line.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchVehicleLineObjectSchema2   {
  @JsonProperty("vehicleLineLead")
  private String vehicleLineLead = null;

  @JsonProperty("vehicleLineVariant")
  private String vehicleLineVariant = null;

  @JsonProperty("vehicleLineMarket")
  private String vehicleLineMarket = null;

  @JsonProperty("businessLine")
  private String businessLine = null;

  public OaContentServiceSearchVehicleLineObjectSchema2 vehicleLineLead(String vehicleLineLead) {
    this.vehicleLineLead = vehicleLineLead;
    return this;
  }

  /**
   * Lead vehicle line, e.g. \"217\".
   * @return vehicleLineLead
  **/
  @ApiModelProperty(value = "Lead vehicle line, e.g. \"217\".")

@Size(max=10)   public String getVehicleLineLead() {
    return vehicleLineLead;
  }

  public void setVehicleLineLead(String vehicleLineLead) {
    this.vehicleLineLead = vehicleLineLead;
  }

  public OaContentServiceSearchVehicleLineObjectSchema2 vehicleLineVariant(String vehicleLineVariant) {
    this.vehicleLineVariant = vehicleLineVariant;
    return this;
  }

  /**
   * Variant of vehicle line, e.g. 2.
   * @return vehicleLineVariant
  **/
  @ApiModelProperty(value = "Variant of vehicle line, e.g. 2.")

@Size(max=10)   public String getVehicleLineVariant() {
    return vehicleLineVariant;
  }

  public void setVehicleLineVariant(String vehicleLineVariant) {
    this.vehicleLineVariant = vehicleLineVariant;
  }

  public OaContentServiceSearchVehicleLineObjectSchema2 vehicleLineMarket(String vehicleLineMarket) {
    this.vehicleLineMarket = vehicleLineMarket;
    return this;
  }

  /**
   * The market for which the owners manual is intended for, e.g. “usa/cnd”.
   * @return vehicleLineMarket
  **/
  @ApiModelProperty(value = "The market for which the owners manual is intended for, e.g. “usa/cnd”.")

@Size(max=10)   public String getVehicleLineMarket() {
    return vehicleLineMarket;
  }

  public void setVehicleLineMarket(String vehicleLineMarket) {
    this.vehicleLineMarket = vehicleLineMarket;
  }

  public OaContentServiceSearchVehicleLineObjectSchema2 businessLine(String businessLine) {
    this.businessLine = businessLine;
    return this;
  }

  /**
   * Business line, value should be \"p\" for \"PKW\".
   * @return businessLine
  **/
  @ApiModelProperty(required = true, value = "Business line, value should be \"p\" for \"PKW\".")
  @NotNull

@Size(max=1)   public String getBusinessLine() {
    return businessLine;
  }

  public void setBusinessLine(String businessLine) {
    this.businessLine = businessLine;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchVehicleLineObjectSchema2 oaContentServiceSearchVehicleLineObjectSchema2 = (OaContentServiceSearchVehicleLineObjectSchema2) o;
    return Objects.equals(this.vehicleLineLead, oaContentServiceSearchVehicleLineObjectSchema2.vehicleLineLead) &&
        Objects.equals(this.vehicleLineVariant, oaContentServiceSearchVehicleLineObjectSchema2.vehicleLineVariant) &&
        Objects.equals(this.vehicleLineMarket, oaContentServiceSearchVehicleLineObjectSchema2.vehicleLineMarket) &&
        Objects.equals(this.businessLine, oaContentServiceSearchVehicleLineObjectSchema2.businessLine);
  }

  @Override
  public int hashCode() {
    return Objects.hash(vehicleLineLead, vehicleLineVariant, vehicleLineMarket, businessLine);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchVehicleLineObjectSchema2 {\n");
    
    sb.append("    vehicleLineLead: ").append(toIndentedString(vehicleLineLead)).append("\n");
    sb.append("    vehicleLineVariant: ").append(toIndentedString(vehicleLineVariant)).append("\n");
    sb.append("    vehicleLineMarket: ").append(toIndentedString(vehicleLineMarket)).append("\n");
    sb.append("    businessLine: ").append(toIndentedString(businessLine)).append("\n");
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
