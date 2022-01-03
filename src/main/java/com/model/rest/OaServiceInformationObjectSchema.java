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
 * An object to provide information of different categories like information, warning or error in a standardized way.
 */
@ApiModel(description = "An object to provide information of different categories like information, warning or error in a standardized way.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaServiceInformationObjectSchema   {
  @JsonProperty("type")
  private Integer type = null;

  @JsonProperty("timestamp")
  private String timestamp = null;

  @JsonProperty("message")
  private String message = null;

  @JsonProperty("code")
  private BigDecimal code = null;

  public OaServiceInformationObjectSchema type(Integer type) {
    this.type = type;
    return this;
  }

  /**
   * The classification of the information.
   * @return type
  **/
  @ApiModelProperty(example = "1", required = true, value = "The classification of the information.")
  @NotNull

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public OaServiceInformationObjectSchema timestamp(String timestamp) {
    this.timestamp = timestamp;
    return this;
  }

  /**
   * The point of time when the message was created. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-05-05T08:09:34.651Z) or YYYY-MM-DDThh:mm:ss.fff±hh:mm (e.g. 2020-05-05T08:09:34.651+01:00).
   * @return timestamp
  **/
  @ApiModelProperty(example = "2020-05-01T08:09:34.651Z", required = true, value = "The point of time when the message was created. It is formatted in consideration of ISO 8601 in the following format: YYYY-MM-DDThh:mm:ss.fffZ (e.g. 2020-05-05T08:09:34.651Z) or YYYY-MM-DDThh:mm:ss.fff±hh:mm (e.g. 2020-05-05T08:09:34.651+01:00).")
  @NotNull

@Pattern(regexp="\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}((\\+|\\-)\\d{2}:\\d{2}|Z)")   public String getTimestamp() {
    return timestamp;
  }

  public void setTimestamp(String timestamp) {
    this.timestamp = timestamp;
  }

  public OaServiceInformationObjectSchema message(String message) {
    this.message = message;
    return this;
  }

  /**
   * A text that contains the details regarding the provided information.
   * @return message
  **/
  @ApiModelProperty(example = "Custom message.", required = true, value = "A text that contains the details regarding the provided information.")
  @NotNull

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public OaServiceInformationObjectSchema code(BigDecimal code) {
    this.code = code;
    return this;
  }

  /**
   * A freely definable code to provide an easy approach for the consuming application to check for specific (none-error) cases.
   * @return code
  **/
  @ApiModelProperty(example = "0", value = "A freely definable code to provide an easy approach for the consuming application to check for specific (none-error) cases.")

  @Valid
  public BigDecimal getCode() {
    return code;
  }

  public void setCode(BigDecimal code) {
    this.code = code;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaServiceInformationObjectSchema oaServiceInformationObjectSchema = (OaServiceInformationObjectSchema) o;
    return Objects.equals(this.type, oaServiceInformationObjectSchema.type) &&
        Objects.equals(this.timestamp, oaServiceInformationObjectSchema.timestamp) &&
        Objects.equals(this.message, oaServiceInformationObjectSchema.message) &&
        Objects.equals(this.code, oaServiceInformationObjectSchema.code);
  }

  @Override
  public int hashCode() {
    return Objects.hash(type, timestamp, message, code);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaServiceInformationObjectSchema {\n");
    
    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    timestamp: ").append(toIndentedString(timestamp)).append("\n");
    sb.append("    message: ").append(toIndentedString(message)).append("\n");
    sb.append("    code: ").append(toIndentedString(code)).append("\n");
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
