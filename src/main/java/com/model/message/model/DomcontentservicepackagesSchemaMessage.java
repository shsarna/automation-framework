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
 * A named root object to keep the JSON structure as compatible as possible with other data structures (e.g. XML).
 */
@ApiModel(description = "A named root object to keep the JSON structure as compatible as possible with other data structures (e.g. XML).")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-20T16:17:41.083512900+02:00[Europe/Berlin]")
public class DomcontentservicepackagesSchemaMessage   {
  @JsonProperty("info")
  @Valid
  private List<OaServiceInformationObjectSchema> info = new ArrayList<>();

  @JsonProperty("data")
  private DomcontentservicepackagesSchemaMessageData data = null;

  public DomcontentservicepackagesSchemaMessage info(List<OaServiceInformationObjectSchema> info) {
    this.info = info;
    return this;
  }

  public DomcontentservicepackagesSchemaMessage addInfoItem(OaServiceInformationObjectSchema infoItem) {
    this.info.add(infoItem);
    return this;
  }

  /**
   * A list of information objects that provides details regarding the request processing.
   * @return info
  **/
  @ApiModelProperty(required = true, value = "A list of information objects that provides details regarding the request processing.")
      @NotNull
    @Valid
    public List<OaServiceInformationObjectSchema> getInfo() {
    return info;
  }

  public void setInfo(List<OaServiceInformationObjectSchema> info) {
    this.info = info;
  }

  public DomcontentservicepackagesSchemaMessage data(DomcontentservicepackagesSchemaMessageData data) {
    this.data = data;
    return this;
  }

  /**
   * Get data
   * @return data
  **/
  @ApiModelProperty(required = true, value = "")
      @NotNull

    @Valid
    public DomcontentservicepackagesSchemaMessageData getData() {
    return data;
  }

  public void setData(DomcontentservicepackagesSchemaMessageData data) {
    this.data = data;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomcontentservicepackagesSchemaMessage domcontentservicepackagesSchemaMessage = (DomcontentservicepackagesSchemaMessage) o;
    return Objects.equals(this.info, domcontentservicepackagesSchemaMessage.info) &&
        Objects.equals(this.data, domcontentservicepackagesSchemaMessage.data);
  }

  @Override
  public int hashCode() {
    return Objects.hash(info, data);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicepackagesSchemaMessage {\n");
    
    sb.append("    info: ").append(toIndentedString(info)).append("\n");
    sb.append("    data: ").append(toIndentedString(data)).append("\n");
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
