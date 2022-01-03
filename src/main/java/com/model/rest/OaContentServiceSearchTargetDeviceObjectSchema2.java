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
public class OaContentServiceSearchTargetDeviceObjectSchema2   {
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

  public OaContentServiceSearchTargetDeviceObjectSchema2 device(String device) {
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

  public OaContentServiceSearchTargetDeviceObjectSchema2 model(String model) {
    this.model = model;
    return this;
  }

  /**
   * Model of the target device.  
   * @return model
  **/
  @ApiModelProperty(value = "Model of the target device.  ")

@Size(max=50)   public String getModel() {
    return model;
  }

  public void setModel(String model) {
    this.model = model;
  }

  public OaContentServiceSearchTargetDeviceObjectSchema2 modelVariant(String modelVariant) {
    this.modelVariant = modelVariant;
    return this;
  }

  /**
   * Model variant of the target device.  
   * @return modelVariant
  **/
  @ApiModelProperty(value = "Model variant of the target device.  ")

@Size(max=50)   public String getModelVariant() {
    return modelVariant;
  }

  public void setModelVariant(String modelVariant) {
    this.modelVariant = modelVariant;
  }

  public OaContentServiceSearchTargetDeviceObjectSchema2 deviceMarket(String deviceMarket) {
    this.deviceMarket = deviceMarket;
    return this;
  }

  /**
   * Market of the target device.  
   * @return deviceMarket
  **/
  @ApiModelProperty(value = "Market of the target device.  ")

@Size(max=50)   public String getDeviceMarket() {
    return deviceMarket;
  }

  public void setDeviceMarket(String deviceMarket) {
    this.deviceMarket = deviceMarket;
  }

  public OaContentServiceSearchTargetDeviceObjectSchema2 screenWidth(BigDecimal screenWidth) {
    this.screenWidth = screenWidth;
    return this;
  }

  /**
   * Screen resolution width in pixels.  
   * @return screenWidth
  **/
  @ApiModelProperty(value = "Screen resolution width in pixels.  ")

  @Valid
  public BigDecimal getScreenWidth() {
    return screenWidth;
  }

  public void setScreenWidth(BigDecimal screenWidth) {
    this.screenWidth = screenWidth;
  }

  public OaContentServiceSearchTargetDeviceObjectSchema2 screenHeight(BigDecimal screenHeight) {
    this.screenHeight = screenHeight;
    return this;
  }

  /**
   * Screen resolution height in pixels.  
   * @return screenHeight
  **/
  @ApiModelProperty(value = "Screen resolution height in pixels.  ")

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
    OaContentServiceSearchTargetDeviceObjectSchema2 oaContentServiceSearchTargetDeviceObjectSchema2 = (OaContentServiceSearchTargetDeviceObjectSchema2) o;
    return Objects.equals(this.device, oaContentServiceSearchTargetDeviceObjectSchema2.device) &&
        Objects.equals(this.model, oaContentServiceSearchTargetDeviceObjectSchema2.model) &&
        Objects.equals(this.modelVariant, oaContentServiceSearchTargetDeviceObjectSchema2.modelVariant) &&
        Objects.equals(this.deviceMarket, oaContentServiceSearchTargetDeviceObjectSchema2.deviceMarket) &&
        Objects.equals(this.screenWidth, oaContentServiceSearchTargetDeviceObjectSchema2.screenWidth) &&
        Objects.equals(this.screenHeight, oaContentServiceSearchTargetDeviceObjectSchema2.screenHeight);
  }

  @Override
  public int hashCode() {
    return Objects.hash(device, model, modelVariant, deviceMarket, screenWidth, screenHeight);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchTargetDeviceObjectSchema2 {\n");
    
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
