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
public class OaContentServiceSearchImageObjectSchema   {
  @JsonProperty("imgWidth")
  private BigDecimal imgWidth = null;

  @JsonProperty("imgHeight")
  private BigDecimal imgHeight = null;

  @JsonProperty("layoutInfo")
  private String layoutInfo = null;

  public OaContentServiceSearchImageObjectSchema imgWidth(BigDecimal imgWidth) {
    this.imgWidth = imgWidth;
    return this;
  }

  /**
   * Width of the image in pixels.  
   * @return imgWidth
  **/
  @ApiModelProperty(required = true, value = "Width of the image in pixels.  ")
  @NotNull

  @Valid
  public BigDecimal getImgWidth() {
    return imgWidth;
  }

  public void setImgWidth(BigDecimal imgWidth) {
    this.imgWidth = imgWidth;
  }

  public OaContentServiceSearchImageObjectSchema imgHeight(BigDecimal imgHeight) {
    this.imgHeight = imgHeight;
    return this;
  }

  /**
   * Height of the image in pixels.  
   * @return imgHeight
  **/
  @ApiModelProperty(required = true, value = "Height of the image in pixels.  ")
  @NotNull

  @Valid
  public BigDecimal getImgHeight() {
    return imgHeight;
  }

  public void setImgHeight(BigDecimal imgHeight) {
    this.imgHeight = imgHeight;
  }

  public OaContentServiceSearchImageObjectSchema layoutInfo(String layoutInfo) {
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
    OaContentServiceSearchImageObjectSchema oaContentServiceSearchImageObjectSchema = (OaContentServiceSearchImageObjectSchema) o;
    return Objects.equals(this.imgWidth, oaContentServiceSearchImageObjectSchema.imgWidth) &&
        Objects.equals(this.imgHeight, oaContentServiceSearchImageObjectSchema.imgHeight) &&
        Objects.equals(this.layoutInfo, oaContentServiceSearchImageObjectSchema.layoutInfo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(imgWidth, imgHeight, layoutInfo);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceSearchImageObjectSchema {\n");
    
    sb.append("    imgWidth: ").append(toIndentedString(imgWidth)).append("\n");
    sb.append("    imgHeight: ").append(toIndentedString(imgHeight)).append("\n");
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
