package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Object that holds the information regarding imported content.
 */
@ApiModel(description = "Object that holds the information regarding imported content.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceBulkObjectSchema   {
  @JsonProperty("bulkId")
  private BigDecimal bulkId = null;

  @JsonProperty("request")
  private OaContentServiceContentSchema request = null;

  @JsonProperty("response")
  private String response = null;

  @JsonProperty("requestTime")
  private String requestTime = null;

  @JsonProperty("responseTime")
  private String responseTime = null;

  public OaContentServiceBulkObjectSchema bulkId(BigDecimal bulkId) {
    this.bulkId = bulkId;
    return this;
  }

  /**
   * Unique Id of the bulked list.
   * @return bulkId
  **/
  @ApiModelProperty(required = true, value = "Unique Id of the bulked list.")
  @NotNull

  @Valid
  public BigDecimal getBulkId() {
    return bulkId;
  }

  public void setBulkId(BigDecimal bulkId) {
    this.bulkId = bulkId;
  }

  public OaContentServiceBulkObjectSchema request(OaContentServiceContentSchema request) {
    this.request = request;
    return this;
  }

  /**
   * Get request
   * @return request
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  @Valid
  public OaContentServiceContentSchema getRequest() {
    return request;
  }

  public void setRequest(OaContentServiceContentSchema request) {
    this.request = request;
  }

  public OaContentServiceBulkObjectSchema response(String response) {
    this.response = response;
    return this;
  }

  /**
   * Get response
   * @return response
  **/
  @ApiModelProperty(required = true, value = "")
  @NotNull

  public String getResponse() {
    return response;
  }

  public void setResponse(String response) {
    this.response = response;
  }

  public OaContentServiceBulkObjectSchema requestTime(String requestTime) {
    this.requestTime = requestTime;
    return this;
  }

  /**
   * Timestamp when the request was received. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return requestTime
  **/
  @ApiModelProperty(required = true, value = "Timestamp when the request was received. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")
  @NotNull

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getRequestTime() {
    return requestTime;
  }

  public void setRequestTime(String requestTime) {
    this.requestTime = requestTime;
  }

  public OaContentServiceBulkObjectSchema responseTime(String responseTime) {
    this.responseTime = responseTime;
    return this;
  }

  /**
   * Timestamp when the response was created. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).
   * @return responseTime
  **/
  @ApiModelProperty(required = true, value = "Timestamp when the response was created. It is formatted in consideration of ISO 8601 in the following format:  YYYY-MM-DDThh:mm:ss.fff�hh:mm  (e.g. 2018-06-05T08:09:34.651+01:00) or YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-01-27T08:09:34.651Z).")
  @NotNull

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getResponseTime() {
    return responseTime;
  }

  public void setResponseTime(String responseTime) {
    this.responseTime = responseTime;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceBulkObjectSchema oaContentServiceBulkObjectSchema = (OaContentServiceBulkObjectSchema) o;
    return Objects.equals(this.bulkId, oaContentServiceBulkObjectSchema.bulkId) &&
        Objects.equals(this.request, oaContentServiceBulkObjectSchema.request) &&
        Objects.equals(this.response, oaContentServiceBulkObjectSchema.response) &&
        Objects.equals(this.requestTime, oaContentServiceBulkObjectSchema.requestTime) &&
        Objects.equals(this.responseTime, oaContentServiceBulkObjectSchema.responseTime);
  }

  @Override
  public int hashCode() {
    return Objects.hash(bulkId, request, response, requestTime, responseTime);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceBulkObjectSchema {\n");
    
    sb.append("    bulkId: ").append(toIndentedString(bulkId)).append("\n");
    sb.append("    request: ").append(toIndentedString(request)).append("\n");
    sb.append("    response: ").append(toIndentedString(response)).append("\n");
    sb.append("    requestTime: ").append(toIndentedString(requestTime)).append("\n");
    sb.append("    responseTime: ").append(toIndentedString(responseTime)).append("\n");
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
