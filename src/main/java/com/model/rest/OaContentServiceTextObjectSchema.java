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
 * Text object data.
 */
@ApiModel(description = "Text object data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceTextObjectSchema   {
  @JsonProperty("textDataId")
  private BigDecimal textDataId = null;

  @JsonProperty("data")
  private String data = null;

  @JsonProperty("md5Checksum")
  private String md5Checksum = null;

  public OaContentServiceTextObjectSchema textDataId(BigDecimal textDataId) {
    this.textDataId = textDataId;
    return this;
  }

  /**
   * Internal Id of the payload data.
   * @return textDataId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the payload data.")
  @NotNull

  @Valid
  public BigDecimal getTextDataId() {
    return textDataId;
  }

  public void setTextDataId(BigDecimal textDataId) {
    this.textDataId = textDataId;
  }

  public OaContentServiceTextObjectSchema data(String data) {
    this.data = data;
    return this;
  }

  /**
   * String representation of the text.
   * @return data
  **/
  @ApiModelProperty(required = true, value = "String representation of the text.")
  @NotNull

  public String getData() {
    return data;
  }

  public void setData(String data) {
    this.data = data;
  }

  public OaContentServiceTextObjectSchema md5Checksum(String md5Checksum) {
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


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceTextObjectSchema oaContentServiceTextObjectSchema = (OaContentServiceTextObjectSchema) o;
    return Objects.equals(this.textDataId, oaContentServiceTextObjectSchema.textDataId) &&
        Objects.equals(this.data, oaContentServiceTextObjectSchema.data) &&
        Objects.equals(this.md5Checksum, oaContentServiceTextObjectSchema.md5Checksum);
  }

  @Override
  public int hashCode() {
    return Objects.hash(textDataId, data, md5Checksum);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceTextObjectSchema {\n");
    
    sb.append("    textDataId: ").append(toIndentedString(textDataId)).append("\n");
    sb.append("    data: ").append(toIndentedString(data)).append("\n");
    sb.append("    md5Checksum: ").append(toIndentedString(md5Checksum)).append("\n");
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
