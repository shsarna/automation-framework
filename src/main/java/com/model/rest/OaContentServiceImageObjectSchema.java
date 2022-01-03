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
 * Image data.
 */
@ApiModel(description = "Image data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceImageObjectSchema   {
  @JsonProperty("imageId")
  private String imageId = null;

  @JsonProperty("data")
  private String data = null;

  @JsonProperty("width")
  private BigDecimal width = null;

  @JsonProperty("height")
  private BigDecimal height = null;

  @JsonProperty("md5Checksum")
  private String md5Checksum = null;

  @JsonProperty("layoutInfo")
  private String layoutInfo = null;

  public OaContentServiceImageObjectSchema imageId(String imageId) {
    this.imageId = imageId;
    return this;
  }

  /**
   * Internal Id of the image payload.
   * @return imageId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the image payload.")
  @NotNull

  public String getImageId() {
    return imageId;
  }

  public void setImageId(String imageId) {
    this.imageId = imageId;
  }

  public OaContentServiceImageObjectSchema data(String data) {
    this.data = data;
    return this;
  }

  /**
   * Binary data of the actual image.
   * @return data
  **/
  @ApiModelProperty(required = true, value = "Binary data of the actual image.")
  @NotNull

  public String getData() {
    return data;
  }

  public void setData(String data) {
    this.data = data;
  }

  public OaContentServiceImageObjectSchema width(BigDecimal width) {
    this.width = width;
    return this;
  }

  /**
   * Width of the image in pixels.  
   * @return width
  **/
  @ApiModelProperty(required = true, value = "Width of the image in pixels.  ")
  @NotNull

  @Valid
  public BigDecimal getWidth() {
    return width;
  }

  public void setWidth(BigDecimal width) {
    this.width = width;
  }

  public OaContentServiceImageObjectSchema height(BigDecimal height) {
    this.height = height;
    return this;
  }

  /**
   * Height of the image in pixels.  
   * @return height
  **/
  @ApiModelProperty(required = true, value = "Height of the image in pixels.  ")
  @NotNull

  @Valid
  public BigDecimal getHeight() {
    return height;
  }

  public void setHeight(BigDecimal height) {
    this.height = height;
  }

  public OaContentServiceImageObjectSchema md5Checksum(String md5Checksum) {
    this.md5Checksum = md5Checksum;
    return this;
  }

  /**
   * MD5 hash value for the content of the data field.
   * @return md5Checksum
  **/
  @ApiModelProperty(required = true, value = "MD5 hash value for the content of the data field.")
  @NotNull

@Size(max=32)   public String getMd5Checksum() {
    return md5Checksum;
  }

  public void setMd5Checksum(String md5Checksum) {
    this.md5Checksum = md5Checksum;
  }

  public OaContentServiceImageObjectSchema layoutInfo(String layoutInfo) {
    this.layoutInfo = layoutInfo;
    return this;
  }

  /**
   * Optional field for a layout information of the picture.  Example value: \"auto\".
   * @return layoutInfo
  **/
  @ApiModelProperty(value = "Optional field for a layout information of the picture.  Example value: \"auto\".")

@Size(max=50)   public String getLayoutInfo() {
    return layoutInfo;
  }

  public void setLayoutInfo(String layoutInfo) {
    this.layoutInfo = layoutInfo;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceImageObjectSchema oaContentServiceImageObjectSchema = (OaContentServiceImageObjectSchema) o;
    return Objects.equals(this.imageId, oaContentServiceImageObjectSchema.imageId) &&
        Objects.equals(this.data, oaContentServiceImageObjectSchema.data) &&
        Objects.equals(this.width, oaContentServiceImageObjectSchema.width) &&
        Objects.equals(this.height, oaContentServiceImageObjectSchema.height) &&
        Objects.equals(this.md5Checksum, oaContentServiceImageObjectSchema.md5Checksum) &&
        Objects.equals(this.layoutInfo, oaContentServiceImageObjectSchema.layoutInfo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(imageId, data, width, height, md5Checksum, layoutInfo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceImageObjectSchema {\n");
    
    sb.append("    imageId: ").append(toIndentedString(imageId)).append("\n");
    sb.append("    data: ").append(toIndentedString(data)).append("\n");
    sb.append("    width: ").append(toIndentedString(width)).append("\n");
    sb.append("    height: ").append(toIndentedString(height)).append("\n");
    sb.append("    md5Checksum: ").append(toIndentedString(md5Checksum)).append("\n");
    sb.append("    layoutInfo: ").append(toIndentedString(layoutInfo)).append("\n");
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
