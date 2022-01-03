package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Technical devices, which are the recipients for content from the OA System.
 */
@ApiModel(description = "Technical devices, which are the recipients for content from the OA System.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceTargetDeviceObjectSchema   {
  @JsonProperty("device")
  private String device = null;

  @JsonProperty("model")
  private String model = null;

  @JsonProperty("modelVariant")
  private String modelVariant = null;

  @JsonProperty("deviceMarket")
  private String deviceMarket = null;

  @JsonProperty("screenWidth")
  private BigDecimal screenWidth = null;

  @JsonProperty("screenHeight")
  private BigDecimal screenHeight = null;

  public OaContentServiceTargetDeviceObjectSchema device(String device) {
    this.device = device;
    return this;
  }

  /**
   * Name of the target device.
   * @return device
  **/
  @ApiModelProperty(required = true, value = "Name of the target device.")
  @NotNull

@Size(max=50)   public String getDevice() {
    return device;
  }

  public void setDevice(String device) {
    this.device = device;
  }

  public OaContentServiceTargetDeviceObjectSchema model(String model) {
    this.model = model;
    return this;
  }

  /**
   * Model of the target device.  
   * @return model
  **/
  @ApiModelProperty(required = true, value = "Model of the target device.  ")
  @NotNull

@Size(max=50)   public String getModel() {
    return model;
  }

  public void setModel(String model) {
    this.model = model;
  }

  public OaContentServiceTargetDeviceObjectSchema modelVariant(String modelVariant) {
    this.modelVariant = modelVariant;
    return this;
  }

  /**
   * Model variant of the target device.  
   * @return modelVariant
  **/
  @ApiModelProperty(required = true, value = "Model variant of the target device.  ")
  @NotNull

@Size(max=50)   public String getModelVariant() {
    return modelVariant;
  }

  public void setModelVariant(String modelVariant) {
    this.modelVariant = modelVariant;
  }

  public OaContentServiceTargetDeviceObjectSchema deviceMarket(String deviceMarket) {
    this.deviceMarket = deviceMarket;
    return this;
  }

  /**
   * Market of the target device.  
   * @return deviceMarket
  **/
  @ApiModelProperty(required = true, value = "Market of the target device.  ")
  @NotNull

@Size(max=50)   public String getDeviceMarket() {
    return deviceMarket;
  }

  public void setDeviceMarket(String deviceMarket) {
    this.deviceMarket = deviceMarket;
  }

  public OaContentServiceTargetDeviceObjectSchema screenWidth(BigDecimal screenWidth) {
    this.screenWidth = screenWidth;
    return this;
  }

  /**
   * Get screenWidth
   * @return screenWidth
  **/
  @ApiModelProperty(value = "")

  @Valid
  public BigDecimal getScreenWidth() {
    return screenWidth;
  }

  public void setScreenWidth(BigDecimal screenWidth) {
    this.screenWidth = screenWidth;
  }

  public OaContentServiceTargetDeviceObjectSchema screenHeight(BigDecimal screenHeight) {
    this.screenHeight = screenHeight;
    return this;
  }

  /**
   * Get screenHeight
   * @return screenHeight
  **/
  @ApiModelProperty(value = "")

  @Valid
  public BigDecimal getScreenHeight() {
    return screenHeight;
  }

  public void setScreenHeight(BigDecimal screenHeight) {
    this.screenHeight = screenHeight;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceTargetDeviceObjectSchema oaContentServiceTargetDeviceObjectSchema = (OaContentServiceTargetDeviceObjectSchema) o;
    return Objects.equals(this.device, oaContentServiceTargetDeviceObjectSchema.device) &&
        Objects.equals(this.model, oaContentServiceTargetDeviceObjectSchema.model) &&
        Objects.equals(this.modelVariant, oaContentServiceTargetDeviceObjectSchema.modelVariant) &&
        Objects.equals(this.deviceMarket, oaContentServiceTargetDeviceObjectSchema.deviceMarket) &&
        Objects.equals(this.screenWidth, oaContentServiceTargetDeviceObjectSchema.screenWidth) &&
        Objects.equals(this.screenHeight, oaContentServiceTargetDeviceObjectSchema.screenHeight);
  }

  @Override
  public int hashCode() {
    return Objects.hash(device, model, modelVariant, deviceMarket, screenWidth, screenHeight);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceTargetDeviceObjectSchema {\n");
    
    sb.append("    device: ").append(toIndentedString(device)).append("\n");
    sb.append("    model: ").append(toIndentedString(model)).append("\n");
    sb.append("    modelVariant: ").append(toIndentedString(modelVariant)).append("\n");
    sb.append("    deviceMarket: ").append(toIndentedString(deviceMarket)).append("\n");
    sb.append("    screenWidth: ").append(toIndentedString(screenWidth)).append("\n");
    sb.append("    screenHeight: ").append(toIndentedString(screenHeight)).append("\n");
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
