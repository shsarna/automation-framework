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
 * Additional information regarding the provided resource.
 */
@ApiModel(description = "Additional information regarding the provided resource.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-23T09:48:42.164612+02:00[Europe/Berlin]")
public class DomcontentservicemessagingSchemaMessageDataData   {
  @JsonProperty("resourceChanges")
  @Valid
  private List<DomcontentservicemessagingSchemaMessageDataDataResourceChanges> resourceChanges = new ArrayList<>();

  public DomcontentservicemessagingSchemaMessageDataData resourceChanges(List<DomcontentservicemessagingSchemaMessageDataDataResourceChanges> resourceChanges) {
    this.resourceChanges = resourceChanges;
    return this;
  }

  public DomcontentservicemessagingSchemaMessageDataData addResourceChangesItem(DomcontentservicemessagingSchemaMessageDataDataResourceChanges resourceChangesItem) {
    this.resourceChanges.add(resourceChangesItem);
    return this;
  }

  /**
   * Get resourceChanges
   * @return resourceChanges
  **/
  @ApiModelProperty(required = true, value = "")
      @NotNull
    @Valid
    public List<DomcontentservicemessagingSchemaMessageDataDataResourceChanges> getResourceChanges() {
    return resourceChanges;
  }

  public void setResourceChanges(List<DomcontentservicemessagingSchemaMessageDataDataResourceChanges> resourceChanges) {
    this.resourceChanges = resourceChanges;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomcontentservicemessagingSchemaMessageDataData domcontentservicemessagingSchemaMessageDataData = (DomcontentservicemessagingSchemaMessageDataData) o;
    return Objects.equals(this.resourceChanges, domcontentservicemessagingSchemaMessageDataData.resourceChanges);
  }

  @Override
  public int hashCode() {
    return Objects.hash(resourceChanges);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicemessagingSchemaMessageDataData {\n");

    sb.append("    resourceChanges: ").append(toIndentedString(resourceChanges)).append("\n");
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
