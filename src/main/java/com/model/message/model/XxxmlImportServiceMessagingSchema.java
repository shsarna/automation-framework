package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Objects;

/**
 * Common OA System response structure
 */
@ApiModel(description = "Common OA System response structure")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class XxxmlImportServiceMessagingSchema   {
  @JsonProperty("message")
  private XxxmlimportservicemessagingSchemaMessage message = null;

  public XxxmlImportServiceMessagingSchema message(XxxmlimportservicemessagingSchemaMessage message) {
    this.message = message;
    return this;
  }

  /**
   * Get message
   * @return message
  **/
  @ApiModelProperty(required = true, value = "")
      @NotNull

    @Valid
    public XxxmlimportservicemessagingSchemaMessage getMessage() {
    return message;
  }

  public void setMessage(XxxmlimportservicemessagingSchemaMessage message) {
    this.message = message;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    XxxmlImportServiceMessagingSchema xxxmlImportServiceMessagingSchema = (XxxmlImportServiceMessagingSchema) o;
    return Objects.equals(this.message, xxxmlImportServiceMessagingSchema.message);
  }

  @Override
  public int hashCode() {
    return Objects.hash(message);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class XxxmlImportServiceMessagingSchema {\n");

    sb.append("    message: ").append(toIndentedString(message)).append("\n");
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