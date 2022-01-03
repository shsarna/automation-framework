package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object to provide metadata information.
 */
@ApiModel(description = "An object to provide metadata information.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceMetadataObjectSchema   {
  @JsonProperty("objectId")
  private BigDecimal objectId = null;

  @JsonProperty("objectTypeName")
  private String objectTypeName = null;

  @JsonProperty("srcSystemName")
  private String srcSystemName = null;

  @JsonProperty("objectIdFromSrc")
  private String objectIdFromSrc = null;

  @JsonProperty("objectTypeFromSrc")
  private String objectTypeFromSrc = null;

  @JsonProperty("objectNamefromSrc")
  private String objectNamefromSrc = null;

  @JsonProperty("validities")
  @Valid
  private List<OaContentServiceValidityObjectSchema> validities = null;

  @JsonProperty("paId")
  private String paId = null;

  @JsonProperty("stateOfConstruction")
  private String stateOfConstruction = null;

  @JsonProperty("vehicleLine")
  private OaContentServiceVehicleLineObjectSchema vehicleLine = null;

  @JsonProperty("targetDevice")
  private OaContentServiceTargetDeviceObjectSchema targetDevice = null;

  @JsonProperty("market")
  private OaContentServiceMarketObjectSchema market = null;

  @JsonProperty("ip")
  private OaContentServiceIpObjectSchema ip = null;

  public OaContentServiceMetadataObjectSchema objectId(BigDecimal objectId) {
    this.objectId = objectId;
    return this;
  }

  /**
   * Internal Id of the object.
   * @return objectId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the object.")
  @NotNull

  @Valid
  public BigDecimal getObjectId() {
    return objectId;
  }

  public void setObjectId(BigDecimal objectId) {
    this.objectId = objectId;
  }

  public OaContentServiceMetadataObjectSchema objectTypeName(String objectTypeName) {
    this.objectTypeName = objectTypeName;
    return this;
  }

  /**
   * Internal type name of the object which is defined in the OA system.
   * @return objectTypeName
  **/
  @ApiModelProperty(value = "Internal type name of the object which is defined in the OA system.")

@Size(max=50)   public String getObjectTypeName() {
    return objectTypeName;
  }

  public void setObjectTypeName(String objectTypeName) {
    this.objectTypeName = objectTypeName;
  }

  public OaContentServiceMetadataObjectSchema srcSystemName(String srcSystemName) {
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

  public OaContentServiceMetadataObjectSchema objectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
    return this;
  }

  /**
   * Unique Identifier of this object in the source system.  
   * @return objectIdFromSrc
  **/
  @ApiModelProperty(value = "Unique Identifier of this object in the source system.  ")

@Size(max=1024)   public String getObjectIdFromSrc() {
    return objectIdFromSrc;
  }

  public void setObjectIdFromSrc(String objectIdFromSrc) {
    this.objectIdFromSrc = objectIdFromSrc;
  }

  public OaContentServiceMetadataObjectSchema objectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
    return this;
  }

  /**
   * Object type that is associated with this object in the source system.  
   * @return objectTypeFromSrc
  **/
  @ApiModelProperty(value = "Object type that is associated with this object in the source system.  ")

@Size(max=300)   public String getObjectTypeFromSrc() {
    return objectTypeFromSrc;
  }

  public void setObjectTypeFromSrc(String objectTypeFromSrc) {
    this.objectTypeFromSrc = objectTypeFromSrc;
  }

  public OaContentServiceMetadataObjectSchema objectNamefromSrc(String objectNamefromSrc) {
    this.objectNamefromSrc = objectNamefromSrc;
    return this;
  }

  /**
   * Name of the object from the source system. It is only available for some object types, e.g. for chatbot answer.
   * @return objectNamefromSrc
  **/
  @ApiModelProperty(value = "Name of the object from the source system. It is only available for some object types, e.g. for chatbot answer.")

@Size(max=100)   public String getObjectNamefromSrc() {
    return objectNamefromSrc;
  }

  public void setObjectNamefromSrc(String objectNamefromSrc) {
    this.objectNamefromSrc = objectNamefromSrc;
  }

  public OaContentServiceMetadataObjectSchema validities(List<OaContentServiceValidityObjectSchema> validities) {
    this.validities = validities;
    return this;
  }

  public OaContentServiceMetadataObjectSchema addValiditiesItem(OaContentServiceValidityObjectSchema validitiesItem) {
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

  public OaContentServiceMetadataObjectSchema paId(String paId) {
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

  public OaContentServiceMetadataObjectSchema stateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
    return this;
  }

  /**
   * Value for the state of construction of a vehicle over time related to the vehicle line.
   * @return stateOfConstruction
  **/
  @ApiModelProperty(value = "Value for the state of construction of a vehicle over time related to the vehicle line.")

@Size(min=1,max=32)   public String getStateOfConstruction() {
    return stateOfConstruction;
  }

  public void setStateOfConstruction(String stateOfConstruction) {
    this.stateOfConstruction = stateOfConstruction;
  }

  public OaContentServiceMetadataObjectSchema vehicleLine(OaContentServiceVehicleLineObjectSchema vehicleLine) {
    this.vehicleLine = vehicleLine;
    return this;
  }

  /**
   * Get vehicleLine
   * @return vehicleLine
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceVehicleLineObjectSchema getVehicleLine() {
    return vehicleLine;
  }

  public void setVehicleLine(OaContentServiceVehicleLineObjectSchema vehicleLine) {
    this.vehicleLine = vehicleLine;
  }

  public OaContentServiceMetadataObjectSchema targetDevice(OaContentServiceTargetDeviceObjectSchema targetDevice) {
    this.targetDevice = targetDevice;
    return this;
  }

  /**
   * Get targetDevice
   * @return targetDevice
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceTargetDeviceObjectSchema getTargetDevice() {
    return targetDevice;
  }

  public void setTargetDevice(OaContentServiceTargetDeviceObjectSchema targetDevice) {
    this.targetDevice = targetDevice;
  }

  public OaContentServiceMetadataObjectSchema market(OaContentServiceMarketObjectSchema market) {
    this.market = market;
    return this;
  }

  /**
   * Get market
   * @return market
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceMarketObjectSchema getMarket() {
    return market;
  }

  public void setMarket(OaContentServiceMarketObjectSchema market) {
    this.market = market;
  }

  public OaContentServiceMetadataObjectSchema ip(OaContentServiceIpObjectSchema ip) {
    this.ip = ip;
    return this;
  }

  /**
   * Get ip
   * @return ip
  **/
  @ApiModelProperty(value = "")

  @Valid
  public OaContentServiceIpObjectSchema getIp() {
    return ip;
  }

  public void setIp(OaContentServiceIpObjectSchema ip) {
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
    OaContentServiceMetadataObjectSchema oaContentServiceMetadataObjectSchema = (OaContentServiceMetadataObjectSchema) o;
    return Objects.equals(this.objectId, oaContentServiceMetadataObjectSchema.objectId) &&
        Objects.equals(this.objectTypeName, oaContentServiceMetadataObjectSchema.objectTypeName) &&
        Objects.equals(this.srcSystemName, oaContentServiceMetadataObjectSchema.srcSystemName) &&
        Objects.equals(this.objectIdFromSrc, oaContentServiceMetadataObjectSchema.objectIdFromSrc) &&
        Objects.equals(this.objectTypeFromSrc, oaContentServiceMetadataObjectSchema.objectTypeFromSrc) &&
        Objects.equals(this.objectNamefromSrc, oaContentServiceMetadataObjectSchema.objectNamefromSrc) &&
        Objects.equals(this.validities, oaContentServiceMetadataObjectSchema.validities) &&
        Objects.equals(this.paId, oaContentServiceMetadataObjectSchema.paId) &&
        Objects.equals(this.stateOfConstruction, oaContentServiceMetadataObjectSchema.stateOfConstruction) &&
        Objects.equals(this.vehicleLine, oaContentServiceMetadataObjectSchema.vehicleLine) &&
        Objects.equals(this.targetDevice, oaContentServiceMetadataObjectSchema.targetDevice) &&
        Objects.equals(this.market, oaContentServiceMetadataObjectSchema.market) &&
        Objects.equals(this.ip, oaContentServiceMetadataObjectSchema.ip);
  }

  @Override
  public int hashCode() {
    return Objects.hash(objectId, objectTypeName, srcSystemName, objectIdFromSrc, objectTypeFromSrc, objectNamefromSrc, validities, paId, stateOfConstruction, vehicleLine, targetDevice, market, ip);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceMetadataObjectSchema {\n");
    
    sb.append("    objectId: ").append(toIndentedString(objectId)).append("\n");
    sb.append("    objectTypeName: ").append(toIndentedString(objectTypeName)).append("\n");
    sb.append("    srcSystemName: ").append(toIndentedString(srcSystemName)).append("\n");
    sb.append("    objectIdFromSrc: ").append(toIndentedString(objectIdFromSrc)).append("\n");
    sb.append("    objectTypeFromSrc: ").append(toIndentedString(objectTypeFromSrc)).append("\n");
    sb.append("    objectNamefromSrc: ").append(toIndentedString(objectNamefromSrc)).append("\n");
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
