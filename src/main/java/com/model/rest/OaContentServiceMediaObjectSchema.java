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
 * Media object data.
 */
@ApiModel(description = "Media object data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceMediaObjectSchema   {
  @JsonProperty("mediaRefDataId")
  private BigDecimal mediaRefDataId = null;

  @JsonProperty("extMediaId")
  private String extMediaId = null;

  @JsonProperty("extMediaUrl")
  private String extMediaUrl = null;

  @JsonProperty("filename")
  private String filename = null;

  public OaContentServiceMediaObjectSchema mediaRefDataId(BigDecimal mediaRefDataId) {
    this.mediaRefDataId = mediaRefDataId;
    return this;
  }

  /**
   * Internal id of the media data.
   * @return mediaRefDataId
  **/
  @ApiModelProperty(required = true, value = "Internal id of the media data.")
  @NotNull

  @Valid
  public BigDecimal getMediaRefDataId() {
    return mediaRefDataId;
  }

  public void setMediaRefDataId(BigDecimal mediaRefDataId) {
    this.mediaRefDataId = mediaRefDataId;
  }

  public OaContentServiceMediaObjectSchema extMediaId(String extMediaId) {
    this.extMediaId = extMediaId;
    return this;
  }

  /**
   * External media identifier which identifies the media file inside the external reference system.
   * @return extMediaId
  **/
  @ApiModelProperty(value = "External media identifier which identifies the media file inside the external reference system.")

@Size(max=1000)   public String getExtMediaId() {
    return extMediaId;
  }

  public void setExtMediaId(String extMediaId) {
    this.extMediaId = extMediaId;
  }

  public OaContentServiceMediaObjectSchema extMediaUrl(String extMediaUrl) {
    this.extMediaUrl = extMediaUrl;
    return this;
  }

  /**
   * External URL of the media in the external reference system.
   * @return extMediaUrl
  **/
  @ApiModelProperty(value = "External URL of the media in the external reference system.")

@Size(max=1000)   public String getExtMediaUrl() {
    return extMediaUrl;
  }

  public void setExtMediaUrl(String extMediaUrl) {
    this.extMediaUrl = extMediaUrl;
  }

  public OaContentServiceMediaObjectSchema filename(String filename) {
    this.filename = filename;
    return this;
  }

  /**
   * Name of the media file.
   * @return filename
  **/
  @ApiModelProperty(value = "Name of the media file.")

@Size(max=1000)   public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceMediaObjectSchema oaContentServiceMediaObjectSchema = (OaContentServiceMediaObjectSchema) o;
    return Objects.equals(this.mediaRefDataId, oaContentServiceMediaObjectSchema.mediaRefDataId) &&
        Objects.equals(this.extMediaId, oaContentServiceMediaObjectSchema.extMediaId) &&
        Objects.equals(this.extMediaUrl, oaContentServiceMediaObjectSchema.extMediaUrl) &&
        Objects.equals(this.filename, oaContentServiceMediaObjectSchema.filename);
  }

  @Override
  public int hashCode() {
    return Objects.hash(mediaRefDataId, extMediaId, extMediaUrl, filename);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceMediaObjectSchema {\n");
    
    sb.append("    mediaRefDataId: ").append(toIndentedString(mediaRefDataId)).append("\n");
    sb.append("    extMediaId: ").append(toIndentedString(extMediaId)).append("\n");
    sb.append("    extMediaUrl: ").append(toIndentedString(extMediaUrl)).append("\n");
    sb.append("    filename: ").append(toIndentedString(filename)).append("\n");
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
