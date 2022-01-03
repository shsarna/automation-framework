package com.model.rest;

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
 * An object that holds the requested data.
 */
@ApiModel(description = "An object that holds the requested data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServicePayloadListResponseSchemaMessageData   {
  @JsonProperty("payloads")
  @Valid
  private List<OaContentServicePayloadObjectSchema> payloads = new ArrayList<>();

  public OaContentServicePayloadListResponseSchemaMessageData payloads(List<OaContentServicePayloadObjectSchema> payloads) {
    this.payloads = payloads;
    return this;
  }

  public OaContentServicePayloadListResponseSchemaMessageData addPayloadsItem(OaContentServicePayloadObjectSchema payloadsItem) {
    this.payloads.add(payloadsItem);
    return this;
  }

  /**
   * A list of objects that holds the requested information about OA payloads.
   * @return payloads
  **/
  @ApiModelProperty(required = true, value = "A list of objects that holds the requested information about OA payloads.")
  @NotNull
  @Valid
  public List<OaContentServicePayloadObjectSchema> getPayloads() {
    return payloads;
  }

  public void setPayloads(List<OaContentServicePayloadObjectSchema> payloads) {
    this.payloads = payloads;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServicePayloadListResponseSchemaMessageData oaContentServicePayloadListResponseSchemaMessageData = (OaContentServicePayloadListResponseSchemaMessageData) o;
    return Objects.equals(this.payloads, oaContentServicePayloadListResponseSchemaMessageData.payloads);
  }

  @Override
  public int hashCode() {
    return Objects.hash(payloads);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServicePayloadListResponseSchemaMessageData {\n");
    
    sb.append("    payloads: ").append(toIndentedString(payloads)).append("\n");
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
