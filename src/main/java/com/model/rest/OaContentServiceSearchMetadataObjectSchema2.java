package com.model.rest;

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
 * An object to provide object metadata information.
 */
@ApiModel(description = "An object to provide object metadata information.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceSearchMetadataObjectSchema2   {
  @JsonProperty("objectTypeName")
  private String objectTypeName = null;

  @JsonProperty("srcSystemName")
  private String srcSystemName = null;

  @JsonProperty("objectTypeFromSrc")
  private String objectTypeFromSrc = null;

  @JsonProperty("objectIdFromSrc")
  private String objectIdFromSrc = null;

  @JsonProperty("objectNameFromSrc")
  private String objectNameFromSrc = null;

  @JsonProperty("validities")
  @Valid
  private List<OaContentServiceValidityObjectSchema> validities = null;

  @JsonProperty("paId")
  private String paId = null;

  @JsonProperty("stateOfConstruction")
  private String stateOfConstruction = null;

  @JsonProperty("vehicleLine")
  private OaContentServiceSearchVehicleLineObjectSchema2 vehicleLine = null;

  @JsonProperty("targetDevice")
  private OaContentServiceSearchTargetDeviceObjectSchema2 targetDevice = null;

  @JsonProperty("market")
  private OaContentServiceSearchMarketObjectSchema2 market = null;

  @JsonProperty("ip")
  private OaContentServiceSearchIpObjectSchema2 ip = null;

  public OaContentServiceSearchMetadataObjectSchema2 objectTypeName(String objectTypeName) {
    this.objectTypeName = objectTypeName;
    return this;
  }

  /**
   * Internal type name of the object.
   * @return objectTypeName
  **/
  @ApiModelProperty(value = "Internal type name of the object.")

@Size(max=50)   public String getObjectTypeName() {
    return objectTypeName;
  }

  public void setObjectTypeName(String objectTypeName) {
    this.objectTypeName = objectTypeName;
  }

  public OaContentServiceSearchMetadataObjectSchema2 srcSystemName(String srcSystemName) {
    this.srcSystemName = srcSystemName;
    return this;
  }

  /**
   * Name of the source system, e.g. \"arki4\".
   * @return srcSystemName
  **/
  @ApiModelProperty(value = "Name of the source system, e.g. \"arki4\".")

@Size(max=50)   public String getSrcSystemName() {
    return srcSystemName;
  }

  public void setSrcSystemName(String srcSystemName) {
    this.srcSystemName = srcSystemName;
  }

  public OaContentServiceSearchMetadataObjectSchema2 objectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
    return this;
  }

  /**
   * Object type that is associated with this object in the source system.
   * @return objectTypeFromSrc
  **/
  @ApiModelProperty(value = "Object type that is associated with this object in the source system.")

@Size(max=300)   public String getObjectTypeFromSrc() {
    return objectTypeFromSrc;
  }

  public void setObjectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
  }

  public OaContentServiceSearchMetadataObjectSchema2 objectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
    return this;
  }

  /**
   * Unique Identifier of this object in the source system.
   * @return objectIdFromSrc
  **/
  @ApiModelProperty(value = "Unique Identifier of this object in the source system.")

@Size(max=1024)   public String getObjectIdFromSrc() {
    return objectIdFromSrc;
  }

  public void setObjectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
  }

  public OaContentServiceSearchMetadataObjectSchema2 objectNameFromSrc(String objectNameFromSrc) {
    this.objectNameFromSrc = objectNameFromSrc;
    return this;
  }

  /**
   * Name of the object from the source system. It is only available for some object types, e.g. for chatbot answer.
   * @return objectNameFromSrc
  **/
  @ApiModelProperty(value = "Name of the object from the source system. It is only available for some object types, e.g. for chatbot answer.")

@Size(max=100)   public String getObjectNameFromSrc() {
    return objectNameFromSrc;
  }

  public void setObjectNameFromSrc(String objectNameFromSrc) {
    this.objectNameFromSrc = objectNameFromSrc;
  }

  public OaContentServiceSearchMetadataObjectSchema2 validities(List<OaContentServiceValidityObjectSchema> validities) {
    this.validities = validities;
    return this;
  }

  public OaContentServiceSearchMetadataObjectSchema2 addValiditiesItem(OaContentServiceValidityObjectSchema validitiesItem) {
    if (this.validities == null) {
      this.validities = new ArrayList<>();
    }
    this.validities.add(validitiesItem);
    return this;
  }

  /**
   * Validities of an object, e.g. equipment code (also known as FIO) for topics.
   * @return validities
  **/
  @ApiModelProperty(value = "Validities of an object, e.g. equipment code (also known as FIO) for topics.")
  @Valid
  public List<OaContentServiceValidityObjectSchema> getValidities() {
    return validities;
  }

  public void setValidities(List<OaContentServiceValidityObjectSchema> validities) {
    this.validities = validities;
  }

  public OaContentServiceSearchMetadataObjectSchema2 paId(String paId) {
    this.paId = paId;
    return this;
  }

  /**
   * Unique identifier for a validity set from a business point of view.
   * @return paId
  **/
  @ApiModelProperty(value = "Unique identifier for a validity set from a business point of view.")

@Size(max=50)   public String getPaId() {
    return paId;
  }

  public void setPaId(String paId) {
    this.paId = paId;
  }

  public OaContentServiceSearchMetadataObjectSchema2 stateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
    return this;
  }

  /**
   * The state of construction of a vehicle in a specific time frame.
   * @return stateOfConstruction
  **/
  @ApiModelProperty(value = "The state of construction of a vehicle in a specific time frame.")

@Size(min=1,max=32)   public String getStateOfConstruction() {
    return stateOfConstruction;
  }

  public void setStateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
  }

  public OaContentServiceSearchMetadataObjectSchema2 vehicleLine(OaContentServiceSearchVehicleLineObjectSchema2 vehicleLine) {
    this.vehicleLine = vehicleLine;
    return this;
  }

  /**
   * Get vehicleLine
   * @return vehicleLine
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchVehicleLineObjectSchema2 getVehicleLine() {
    return vehicleLine;
  }

  public void setVehicleLine(OaContentServiceSearchVehicleLineObjectSchema2 vehicleLine) {
    this.vehicleLine = vehicleLine;
  }

  public OaContentServiceSearchMetadataObjectSchema2 targetDevice(OaContentServiceSearchTargetDeviceObjectSchema2 targetDevice) {
    this.targetDevice = targetDevice;
    return this;
  }

  /**
   * Get targetDevice
   * @return targetDevice
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchTargetDeviceObjectSchema2 getTargetDevice() {
    return targetDevice;
  }

  public void setTargetDevice(OaContentServiceSearchTargetDeviceObjectSchema2 targetDevice) {
    this.targetDevice = targetDevice;
  }

  public OaContentServiceSearchMetadataObjectSchema2 market(OaContentServiceSearchMarketObjectSchema2 market) {
    this.market = market;
    return this;
  }

  /**
   * Get market
   * @return market
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchMarketObjectSchema2 getMarket() {
    return market;
  }

  public void setMarket(OaContentServiceSearchMarketObjectSchema2 market) {
    this.market = market;
  }

  public OaContentServiceSearchMetadataObjectSchema2 ip(OaContentServiceSearchIpObjectSchema2 ip) {
    this.ip = ip;
    return this;
  }

  /**
   * Get ip
   * @return ip
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchIpObjectSchema2 getIp() {
    return ip;
  }

  public void setIp(OaContentServiceSearchIpObjectSchema2 ip) {
    this.ip = ip;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceSearchMetadataObjectSchema2 oaContentServiceSearchMetadataObjectSchema2 = (OaContentServiceSearchMetadataObjectSchema2) o;
    return Objects.equals(this.objectTypeName, oaContentServiceSearchMetadataObjectSchema2.objectTypeName) &&
        Objects.equals(this.srcSystemName, oaContentServiceSearchMetadataObjectSchema2.srcSystemName) &&
        Objects.equals(this.objectTypeFromSrc, oaContentServiceSearchMetadataObjectSchema2.objectTypeFromSrc) &&
        Objects.equals(this.objectIdFromSrc, oaContentServiceSearchMetadataObjectSchema2.objectIdFromSrc) &&
        Objects.equals(this.objectNameFromSrc, oaContentServiceSearchMetadataObjectSchema2.objectNameFromSrc) &&
        Objects.equals(this.validities, oaContentServiceSearchMetadataObjectSchema2.validities) &&
        Objects.equals(this.paId, oaContentServiceSearchMetadataObjectSchema2.paId) &&
        Objects.equals(this.stateOfConstruction, oaContentServiceSearchMetadataObjectSchema2.stateOfConstruction) &&
        Objects.equals(this.vehicleLine, oaContentServiceSearchMetadataObjectSchema2.vehicleLine) &&
        Objects.equals(this.targetDevice, oaContentServiceSearchMetadataObjectSchema2.targetDevice) &&
        Objects.equals(this.market, oaContentServiceSearchMetadataObjectSchema2.market) &&
        Objects.equals(this.ip, oaContentServiceSearchMetadataObjectSchema2.ip);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectTypeName, srcSystemName, objectTypeFromSrc, objectIdFromSrc, objectNameFromSrc, validities, paId, stateOfConstruction, vehicleLine, targetDevice, market, ip);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchMetadataObjectSchema2 {\n");
    
    sb.append("    objectTypeName: ").append(toIndentedString(objectTypeName)).append("\n");
    sb.append("    srcSystemName: ").append(toIndentedString(srcSystemName)).append("\n");
    sb.append("    objectTypeFromSrc: ").append(toIndentedString(objectTypeFromSrc)).append("\n");
    sb.append("    objectIdFromSrc: ").append(toIndentedString(objectIdFromSrc)).append("\n");
    sb.append("    objectNameFromSrc: ").append(toIndentedString(objectNameFromSrc)).append("\n");
    sb.append("    validities: ").append(toIndentedString(validities)).append("\n");
    sb.append("    paId: ").append(toIndentedString(paId)).append("\n");
    sb.append("    stateOfConstruction: ").append(toIndentedString(stateOfConstruction)).append("\n");
    sb.append("    vehicleLine: ").append(toIndentedString(vehicleLine)).append("\n");
    sb.append("    targetDevice: ").append(toIndentedString(targetDevice)).append("\n");
    sb.append("    market: ").append(toIndentedString(market)).append("\n");
    sb.append("    ip: ").append(toIndentedString(ip)).append("\n");
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
