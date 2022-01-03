package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * An object that provides details to a media object.
 */
@ApiModel(description = "An object that provides details to a media object.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomContentServiceMediaSchema   {
  @JsonProperty("mediaId")
  private Integer mediaId = null;

  @JsonProperty("status")
  private String status = null;

  @JsonProperty("tags")
  @Valid
  private List<DomcontentservicemediaSchemaTags> tags = null;

  public DomContentServiceMediaSchema mediaId(Integer mediaId) {
    this.mediaId = mediaId;
    return this;
  }

  /**
   * Unique identifier of the media in the source system.
   * @return mediaId
  **/
  @ApiModelProperty(example = "1", required = true, value = "Unique identifier of the media in the source system.")
      @NotNull

    public Integer getMediaId() {
    return mediaId;
  }

  public void setMediaId(Integer mediaId) {
    this.mediaId = mediaId;
  }

  public DomContentServiceMediaSchema status(String status) {
    this.status = status;
    return this;
  }

  /**
   * Status of the media publication, e.g. \"PUBLISHED\".
   * @return status
  **/
  @ApiModelProperty(example = "PUBLISHED", required = true, value = "Status of the media publication, e.g. \"PUBLISHED\".")
      @NotNull

    public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public DomContentServiceMediaSchema tags(List<DomcontentservicemediaSchemaTags> tags) {
    this.tags = tags;
    return this;
  }

  public DomContentServiceMediaSchema addTagsItem(DomcontentservicemediaSchemaTags tagsItem) {
    if (this.tags == null) {
      this.tags = new ArrayList<>();
    }
    this.tags.add(tagsItem);
    return this;
  }

  /**
   * A list of key-value pairs indicating the validities of the media object.
   * @return tags
  **/
  @ApiModelProperty(value = "A list of key-value pairs indicating the validities of the media object.")
      @Valid
    public List<DomcontentservicemediaSchemaTags> getTags() {
    return tags;
  }

  public void setTags(List<DomcontentservicemediaSchemaTags> tags) {
    this.tags = tags;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomContentServiceMediaSchema domContentServiceMediaSchema = (DomContentServiceMediaSchema) o;
    return Objects.equals(this.mediaId, domContentServiceMediaSchema.mediaId) &&
        Objects.equals(this.status, domContentServiceMediaSchema.status) &&
        Objects.equals(this.tags, domContentServiceMediaSchema.tags);
  }

  @Override
  public int hashCode() {
    return Objects.hash(mediaId, status, tags);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomContentServiceMediaSchema {\n");

    sb.append("    mediaId: ").append(toIndentedString(mediaId)).append("\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
    sb.append("    tags: ").append(toIndentedString(tags)).append("\n");
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
