package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Set of validities called n-tuple.
 */
@ApiModel(description = "Set of validities called n-tuple.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomServicesCommonNTupleObjectSchema   {
  @JsonProperty("businessLine")
  private String businessLine = null;

  @JsonProperty("vehicleLine")
  @Valid
  private List<String> vehicleLine = null;

  @JsonProperty("vehicleMarket")
  @Valid
  private List<String> vehicleMarket = null;

  @JsonProperty("market")
  @Valid
  private List<String> market = null;

  @JsonProperty("deviceName")
  private String deviceName = null;

  @JsonProperty("deviceModel")
  private String deviceModel = null;

  @JsonProperty("deviceModelVariant")
  private String deviceModelVariant = null;

  @JsonProperty("deviceLayout")
  @Valid
  private List<String> deviceLayout = null;

  @JsonProperty("deviceModelMarket")
  @Valid
  private List<String> deviceModelMarket = null;

  @JsonProperty("stateOfConstruction")
  private String stateOfConstruction = null;

  @JsonProperty("paId")
  private String paId = null;

  public DomServicesCommonNTupleObjectSchema businessLine(String businessLine) {
    this.businessLine = businessLine;
    return this;
  }

  /**
   * Business line of a vehicle, value known by now \"p\", \"pkw\" or \"PKW\".
   * @return businessLine
  **/
  @ApiModelProperty(example = "p", value = "Business line of a vehicle, value known by now \"p\", \"pkw\" or \"PKW\".")
  
    public String getBusinessLine() {
    return businessLine;
  }

  public void setBusinessLine(String businessLine) {
    this.businessLine = businessLine;
  }

  public DomServicesCommonNTupleObjectSchema vehicleLine(List<String> vehicleLine) {
    this.vehicleLine = vehicleLine;
    return this;
  }

  public DomServicesCommonNTupleObjectSchema addVehicleLineItem(String vehicleLineItem) {
    if (this.vehicleLine == null) {
      this.vehicleLine = new ArrayList<>();
    }
    this.vehicleLine.add(vehicleLineItem);
    return this;
  }

  /**
   * Vehicle line consisting of the vehicle line lead and vehicle line variant. e.g. \"217.2\".
   * @return vehicleLine
  **/
  @ApiModelProperty(example = "223.0", value = "Vehicle line consisting of the vehicle line lead and vehicle line variant. e.g. \"217.2\".")
  
    public List<String> getVehicleLine() {
    return vehicleLine;
  }

  public void setVehicleLine(List<String> vehicleLine) {
    this.vehicleLine = vehicleLine;
  }

  public DomServicesCommonNTupleObjectSchema vehicleMarket(List<String> vehicleMarket) {
    this.vehicleMarket = vehicleMarket;
    return this;
  }

  public DomServicesCommonNTupleObjectSchema addVehicleMarketItem(String vehicleMarketItem) {
    if (this.vehicleMarket == null) {
      this.vehicleMarket = new ArrayList<>();
    }
    this.vehicleMarket.add(vehicleMarketItem);
    return this;
  }

  /**
   * The market for which the owners manual is intended for, e.g. \"usa/cnd\".
   * @return vehicleMarket
  **/
  @ApiModelProperty(example = "ma-ece/row", value = "The market for which the owners manual is intended for, e.g. \"usa/cnd\".")
  
    public List<String> getVehicleMarket() {
    return vehicleMarket;
  }

  public void setVehicleMarket(List<String> vehicleMarket) {
    this.vehicleMarket = vehicleMarket;
  }

  public DomServicesCommonNTupleObjectSchema market(List<String> market) {
    this.market = market;
    return this;
  }

  public DomServicesCommonNTupleObjectSchema addMarketItem(String marketItem) {
    if (this.market == null) {
      this.market = new ArrayList<>();
    }
    this.market.add(marketItem);
    return this;
  }

  /**
   * The market stored here, is the market, for which an Owners Manual is intended for (e.g. \"ece/row\").
   * @return market
  **/
  @ApiModelProperty(example = "ece/row", value = "The market stored here, is the market, for which an Owners Manual is intended for (e.g. \"ece/row\").")
  
    public List<String> getMarket() {
    return market;
  }

  public void setMarket(List<String> market) {
    this.market = market;
  }

  public DomServicesCommonNTupleObjectSchema deviceName(String deviceName) {
    this.deviceName = deviceName;
    return this;
  }

  /**
   * Name of the target device.
   * @return deviceName
  **/
  @ApiModelProperty(example = "hu", value = "Name of the target device.")
  
    public String getDeviceName() {
    return deviceName;
  }

  public void setDeviceName(String deviceName) {
    this.deviceName = deviceName;
  }

  public DomServicesCommonNTupleObjectSchema deviceModel(String deviceModel) {
    this.deviceModel = deviceModel;
    return this;
  }

  /**
   * Model of the target device.
   * @return deviceModel
  **/
  @ApiModelProperty(example = "NTG7.0", value = "Model of the target device.")
  
    public String getDeviceModel() {
    return deviceModel;
  }

  public void setDeviceModel(String deviceModel) {
    this.deviceModel = deviceModel;
  }

  public DomServicesCommonNTupleObjectSchema deviceModelVariant(String deviceModelVariant) {
    this.deviceModelVariant = deviceModelVariant;
    return this;
  }

  /**
   * Model variant of the target device.
   * @return deviceModelVariant
  **/
  @ApiModelProperty(example = "high", value = "Model variant of the target device.")
  
    public String getDeviceModelVariant() {
    return deviceModelVariant;
  }

  public void setDeviceModelVariant(String deviceModelVariant) {
    this.deviceModelVariant = deviceModelVariant;
  }

  public DomServicesCommonNTupleObjectSchema deviceLayout(List<String> deviceLayout) {
    this.deviceLayout = deviceLayout;
    return this;
  }

  public DomServicesCommonNTupleObjectSchema addDeviceLayoutItem(String deviceLayoutItem) {
    if (this.deviceLayout == null) {
      this.deviceLayout = new ArrayList<>();
    }
    this.deviceLayout.add(deviceLayoutItem);
    return this;
  }

  /**
   * List of layout information of the target device.
   * @return deviceLayout
  **/
  @ApiModelProperty(example = "highResolution", value = "List of layout information of the target device.")
  
    public List<String> getDeviceLayout() {
    return deviceLayout;
  }

  public void setDeviceLayout(List<String> deviceLayout) {
    this.deviceLayout = deviceLayout;
  }

  public DomServicesCommonNTupleObjectSchema deviceModelMarket(List<String> deviceModelMarket) {
    this.deviceModelMarket = deviceModelMarket;
    return this;
  }

  public DomServicesCommonNTupleObjectSchema addDeviceModelMarketItem(String deviceModelMarketItem) {
    if (this.deviceModelMarket == null) {
      this.deviceModelMarket = new ArrayList<>();
    }
    this.deviceModelMarket.add(deviceModelMarketItem);
    return this;
  }

  /**
   * Market of the target device
   * @return deviceModelMarket
  **/
  @ApiModelProperty(example = "hu-ece/row", value = "Market of the target device")
  
    public List<String> getDeviceModelMarket() {
    return deviceModelMarket;
  }

  public void setDeviceModelMarket(List<String> deviceModelMarket) {
    this.deviceModelMarket = deviceModelMarket;
  }

  public DomServicesCommonNTupleObjectSchema stateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
    return this;
  }

  /**
   * The state of construction of a vehicle in a specific time frame to which content is linked to.
   * @return stateOfConstruction
  **/
  @ApiModelProperty(value = "The state of construction of a vehicle in a specific time frame to which content is linked to.")
  
  @Size(min=1,max=32)   public String getStateOfConstruction() {
    return stateOfConstruction;
  }

  public void setStateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
  }

  public DomServicesCommonNTupleObjectSchema paId(String paId) {
    this.paId = paId;
    return this;
  }

  /**
   * Unique identifier for a validity set from a business point of view. 
   * @return paId
  **/
  @ApiModelProperty(value = "Unique identifier for a validity set from a business point of view. ")
  
  @Size(max=50)   public String getPaId() {
    return paId;
  }

  public void setPaId(String paId) {
    this.paId = paId;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomServicesCommonNTupleObjectSchema domServicesCommonNTupleObjectSchema = (DomServicesCommonNTupleObjectSchema) o;
    return Objects.equals(this.businessLine, domServicesCommonNTupleObjectSchema.businessLine) &&
        Objects.equals(this.vehicleLine, domServicesCommonNTupleObjectSchema.vehicleLine) &&
        Objects.equals(this.vehicleMarket, domServicesCommonNTupleObjectSchema.vehicleMarket) &&
        Objects.equals(this.market, domServicesCommonNTupleObjectSchema.market) &&
        Objects.equals(this.deviceName, domServicesCommonNTupleObjectSchema.deviceName) &&
        Objects.equals(this.deviceModel, domServicesCommonNTupleObjectSchema.deviceModel) &&
        Objects.equals(this.deviceModelVariant, domServicesCommonNTupleObjectSchema.deviceModelVariant) &&
        Objects.equals(this.deviceLayout, domServicesCommonNTupleObjectSchema.deviceLayout) &&
        Objects.equals(this.deviceModelMarket, domServicesCommonNTupleObjectSchema.deviceModelMarket) &&
        Objects.equals(this.stateOfConstruction, domServicesCommonNTupleObjectSchema.stateOfConstruction) &&
        Objects.equals(this.paId, domServicesCommonNTupleObjectSchema.paId);
  }

  @Override
  public int hashCode() {
    return Objects.hash(businessLine, vehicleLine, vehicleMarket, market, deviceName, deviceModel, deviceModelVariant, deviceLayout, deviceModelMarket, stateOfConstruction, paId);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomServicesCommonNTupleObjectSchema {\n");

    sb.append("    businessLine: ").append(toIndentedString(businessLine)).append("\n");
    sb.append("    vehicleLine: ").append(toIndentedString(vehicleLine)).append("\n");
    sb.append("    vehicleMarket: ").append(toIndentedString(vehicleMarket)).append("\n");
    sb.append("    market: ").append(toIndentedString(market)).append("\n");
    sb.append("    deviceName: ").append(toIndentedString(deviceName)).append("\n");
    sb.append("    deviceModel: ").append(toIndentedString(deviceModel)).append("\n");
    sb.append("    deviceModelVariant: ").append(toIndentedString(deviceModelVariant)).append("\n");
    sb.append("    deviceLayout: ").append(toIndentedString(deviceLayout)).append("\n");
    sb.append("    deviceModelMarket: ").append(toIndentedString(deviceModelMarket)).append("\n");
    sb.append("    stateOfConstruction: ").append(toIndentedString(stateOfConstruction)).append("\n");
    sb.append("    paId: ").append(toIndentedString(paId)).append("\n");
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
