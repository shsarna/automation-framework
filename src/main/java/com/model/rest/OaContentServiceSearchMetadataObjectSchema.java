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
public class OaContentServiceSearchMetadataObjectSchema   {
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
  private List<OaContentServiceValidityObjectSchema2> validities = null;

  @JsonProperty("paId")
  private String paId = null;

  @JsonProperty("stateOfConstruction")
  private String stateOfConstruction = null;

  @JsonProperty("vehicleLine")
  private OaContentServiceSearchVehicleLineObjectSchema vehicleLine = null;

  @JsonProperty("targetDevice")
  private OaContentServiceSearchTargetDeviceObjectSchema targetDevice = null;

  @JsonProperty("market")
  private OaContentServiceSearchMarketObjectSchema market = null;

  @JsonProperty("ip")
  private OaContentServiceSearchIpObjectSchema ip = null;

  public OaContentServiceSearchMetadataObjectSchema objectTypeName(String objectTypeName) {
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

  public OaContentServiceSearchMetadataObjectSchema srcSystemName(String srcSystemName) {
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

  public OaContentServiceSearchMetadataObjectSchema objectTypeFromSrc(String objectTypeFromSrc) {
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

  public OaContentServiceSearchMetadataObjectSchema objectIdFromSrc(String objectIdFromSrc) {
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

  public OaContentServiceSearchMetadataObjectSchema objectNameFromSrc(String objectNameFromSrc) {
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

  public OaContentServiceSearchMetadataObjectSchema validities(List<OaContentServiceValidityObjectSchema2> validities) {
    this.validities = validities;
    return this;
  }

  public OaContentServiceSearchMetadataObjectSchema addValiditiesItem(OaContentServiceValidityObjectSchema2 validitiesItem) {
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
  public List<OaContentServiceValidityObjectSchema2> getValidities() {
    return validities;
  }

  public void setValidities(List<OaContentServiceValidityObjectSchema2> validities) {
    this.validities = validities;
  }

  public OaContentServiceSearchMetadataObjectSchema paId(String paId) {
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

  public OaContentServiceSearchMetadataObjectSchema stateOfConstruction(String stateOfConstruction) {
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

  public OaContentServiceSearchMetadataObjectSchema vehicleLine(OaContentServiceSearchVehicleLineObjectSchema vehicleLine) {
    this.vehicleLine = vehicleLine;
    return this;
  }

  /**
   * Get vehicleLine
   * @return vehicleLine
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchVehicleLineObjectSchema getVehicleLine() {
    return vehicleLine;
  }

  public void setVehicleLine(OaContentServiceSearchVehicleLineObjectSchema vehicleLine) {
    this.vehicleLine = vehicleLine;
  }

  public OaContentServiceSearchMetadataObjectSchema targetDevice(OaContentServiceSearchTargetDeviceObjectSchema targetDevice) {
    this.targetDevice = targetDevice;
    return this;
  }

  /**
   * Get targetDevice
   * @return targetDevice
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchTargetDeviceObjectSchema getTargetDevice() {
    return targetDevice;
  }

  public void setTargetDevice(OaContentServiceSearchTargetDeviceObjectSchema targetDevice) {
    this.targetDevice = targetDevice;
  }

  public OaContentServiceSearchMetadataObjectSchema market(OaContentServiceSearchMarketObjectSchema market) {
    this.market = market;
    return this;
  }

  /**
   * Get market
   * @return market
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchMarketObjectSchema getMarket() {
    return market;
  }

  public void setMarket(OaContentServiceSearchMarketObjectSchema market) {
    this.market = market;
  }

  public OaContentServiceSearchMetadataObjectSchema ip(OaContentServiceSearchIpObjectSchema ip) {
    this.ip = ip;
    return this;
  }

  /**
   * Get ip
   * @return ip
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceSearchIpObjectSchema getIp() {
    return ip;
  }

  public void setIp(OaContentServiceSearchIpObjectSchema ip) {
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
    OaContentServiceSearchMetadataObjectSchema oaContentServiceSearchMetadataObjectSchema = (OaContentServiceSearchMetadataObjectSchema) o;
    return Objects.equals(this.objectTypeName, oaContentServiceSearchMetadataObjectSchema.objectTypeName) &&
        Objects.equals(this.srcSystemName, oaContentServiceSearchMetadataObjectSchema.srcSystemName) &&
        Objects.equals(this.objectTypeFromSrc, oaContentServiceSearchMetadataObjectSchema.objectTypeFromSrc) &&
        Objects.equals(this.objectIdFromSrc, oaContentServiceSearchMetadataObjectSchema.objectIdFromSrc) &&
        Objects.equals(this.objectNameFromSrc, oaContentServiceSearchMetadataObjectSchema.objectNameFromSrc) &&
        Objects.equals(this.validities, oaContentServiceSearchMetadataObjectSchema.validities) &&
        Objects.equals(this.paId, oaContentServiceSearchMetadataObjectSchema.paId) &&
        Objects.equals(this.stateOfConstruction, oaContentServiceSearchMetadataObjectSchema.stateOfConstruction) &&
        Objects.equals(this.vehicleLine, oaContentServiceSearchMetadataObjectSchema.vehicleLine) &&
        Objects.equals(this.targetDevice, oaContentServiceSearchMetadataObjectSchema.targetDevice) &&
        Objects.equals(this.market, oaContentServiceSearchMetadataObjectSchema.market) &&
        Objects.equals(this.ip, oaContentServiceSearchMetadataObjectSchema.ip);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectTypeName, srcSystemName, objectTypeFromSrc, objectIdFromSrc, objectNameFromSrc, validities, paId, stateOfConstruction, vehicleLine, targetDevice, market, ip);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchMetadataObjectSchema {\n");
    
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
