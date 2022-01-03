package com.model.message.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * This object contains the actual payload of the message.
 */
@ApiModel(description = "This object contains the actual payload of the message.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-08-20T16:17:41.083512900+02:00[Europe/Berlin]")
public class DomcontentservicepackagesSchemaMessageData   {
  @JsonProperty("id")
  private Integer id = null;

  @JsonProperty("type")
  private String type = null;

  @JsonProperty("location")
  private String location = null;

  @JsonProperty("status")
  private Integer status = null;

  @JsonProperty("validities")
  private DomServicesCommonNTupleObjectSchema validities = null;

  @JsonProperty("languages")
  @Valid
  private List<DomcontentservicepackagesSchemaMessageDataLanguages> languages = new ArrayList<>();

  @JsonProperty("partNumber")
  private String partNumber = null;

  @JsonProperty("swVersionsNumber")
  private String swVersionsNumber = null;

  @JsonProperty("references")
  @Valid
  private List<OaServiceAndMessageReferenceSchema> references = null;

  public DomcontentservicepackagesSchemaMessageData id(Integer id) {
    this.id = id;
    return this;
  }

  /**
   * Internal ID of the resource.
   * @return id
  **/
  @ApiModelProperty(example = "1", required = true, value = "Internal ID of the resource.")
      @NotNull

    public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public DomcontentservicepackagesSchemaMessageData type(String type) {
    this.type = type;
    return this;
  }

  /**
   * Resource type in urn format urn:<domain>:oa:<service>:<name of service>:<name of resource>
   * @return type
  **/
  @ApiModelProperty(example = "urn:com:mercedes-benz:oa:[service]:[resource]", required = true, value = "Resource type in urn format urn:<domain>:oa:<service>:<name of service>:<name of resource>")
      @NotNull

    public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public DomcontentservicepackagesSchemaMessageData location(String location) {
    this.location = location;
    return this;
  }

  /**
   * Location of the resource.
   * @return location
  **/
  @ApiModelProperty(example = "http://oa.daimler.com/[service]/v1/[resource]/1", required = true, value = "Location of the resource.")
      @NotNull

    public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public DomcontentservicepackagesSchemaMessageData status(Integer status) {
    this.status = status;
    return this;
  }

  /**
   * Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.
   * @return status
  **/
  @ApiModelProperty(example = "1", required = true, value = "Status code indicating the type of change of the resource. Possible values: -1: Error, 0: Resource not changed, 1: Resource created, 2: Resource updated, 3: Resource deleted.")
      @NotNull

    public Integer getStatus() {
    return status;
  }

  public void setStatus(Integer status) {
    this.status = status;
  }

  public DomcontentservicepackagesSchemaMessageData validities(DomServicesCommonNTupleObjectSchema validities) {
    this.validities = validities;
    return this;
  }

  /**
   * Get validities
   * @return validities
  **/
  @ApiModelProperty(required = true, value = "")
      @NotNull

    @Valid
    public DomServicesCommonNTupleObjectSchema getValidities() {
    return validities;
  }

  public void setValidities(DomServicesCommonNTupleObjectSchema validities) {
    this.validities = validities;
  }

  public DomcontentservicepackagesSchemaMessageData languages(List<DomcontentservicepackagesSchemaMessageDataLanguages> languages) {
    this.languages = languages;
    return this;
  }

  public DomcontentservicepackagesSchemaMessageData addLanguagesItem(DomcontentservicepackagesSchemaMessageDataLanguages languagesItem) {
    this.languages.add(languagesItem);
    return this;
  }

  /**
   * List of languages.
   * @return languages
  **/
  @ApiModelProperty(required = true, value = "List of languages.")
      @NotNull
    @Valid
  @Size(min=1)   public List<DomcontentservicepackagesSchemaMessageDataLanguages> getLanguages() {
    return languages;
  }

  public void setLanguages(List<DomcontentservicepackagesSchemaMessageDataLanguages> languages) {
    this.languages = languages;
  }

  public DomcontentservicepackagesSchemaMessageData partNumber(String partNumber) {
    this.partNumber = partNumber;
    return this;
  }

  /**
   * The software part number that together with swVersionsNumber builds the business key for the /containers resource.
   * @return partNumber
  **/
  @ApiModelProperty(example = "A1234567890", required = true, value = "The software part number that together with swVersionsNumber builds the business key for the /containers resource.")
      @NotNull

  @Pattern(regexp="^A\\d{10}$") @Size(min=11,max=11)   public String getPartNumber() {
    return partNumber;
  }

  public void setPartNumber(String partNumber) {
    this.partNumber = partNumber;
  }

  public DomcontentservicepackagesSchemaMessageData swVersionsNumber(String swVersionsNumber) {
    this.swVersionsNumber = swVersionsNumber;
    return this;
  }

  /**
   * The software version that together with partNumber builds the business key for the /containers resource.
   * @return swVersionsNumber
  **/
  @ApiModelProperty(example = "112233", required = true, value = "The software version that together with partNumber builds the business key for the /containers resource.")
      @NotNull

  @Pattern(regexp="^\\d{6}$") @Size(min=6,max=6)   public String getSwVersionsNumber() {
    return swVersionsNumber;
  }

  public void setSwVersionsNumber(String swVersionsNumber) {
    this.swVersionsNumber = swVersionsNumber;
  }

  public DomcontentservicepackagesSchemaMessageData references(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
    return this;
  }

  public DomcontentservicepackagesSchemaMessageData addReferencesItem(OaServiceAndMessageReferenceSchema referencesItem) {
    if (this.references == null) {
      this.references = new ArrayList<>();
    }
    this.references.add(referencesItem);
    return this;
  }

  /**
   * In the references list the history for the processing is documented (tracing). Any consumer who is triggered by a message and creates a new resource has to add a new element to the references list of the triggering message describing the resource that has been processed.
   * @return references
  **/
  @ApiModelProperty(value = "In the references list the history for the processing is documented (tracing). Any consumer who is triggered by a message and creates a new resource has to add a new element to the references list of the triggering message describing the resource that has been processed.")
      @Valid
    public List<OaServiceAndMessageReferenceSchema> getReferences() {
    return references;
  }

  public void setReferences(List<OaServiceAndMessageReferenceSchema> references) {
    this.references = references;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    DomcontentservicepackagesSchemaMessageData domcontentservicepackagesSchemaMessageData = (DomcontentservicepackagesSchemaMessageData) o;
    return Objects.equals(this.id, domcontentservicepackagesSchemaMessageData.id) &&
        Objects.equals(this.type, domcontentservicepackagesSchemaMessageData.type) &&
        Objects.equals(this.location, domcontentservicepackagesSchemaMessageData.location) &&
        Objects.equals(this.status, domcontentservicepackagesSchemaMessageData.status) &&
        Objects.equals(this.validities, domcontentservicepackagesSchemaMessageData.validities) &&
        Objects.equals(this.languages, domcontentservicepackagesSchemaMessageData.languages) &&
        Objects.equals(this.partNumber, domcontentservicepackagesSchemaMessageData.partNumber) &&
        Objects.equals(this.swVersionsNumber, domcontentservicepackagesSchemaMessageData.swVersionsNumber) &&
        Objects.equals(this.references, domcontentservicepackagesSchemaMessageData.references);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, type, location, status, validities, languages, partNumber, swVersionsNumber, references);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class DomcontentservicepackagesSchemaMessageData {\n");
    
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    type: ").append(toIndentedString(type)).append("\n");
    sb.append("    location: ").append(toIndentedString(location)).append("\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
    sb.append("    validities: ").append(toIndentedString(validities)).append("\n");
    sb.append("    languages: ").append(toIndentedString(languages)).append("\n");
    sb.append("    partNumber: ").append(toIndentedString(partNumber)).append("\n");
    sb.append("    swVersionsNumber: ").append(toIndentedString(swVersionsNumber)).append("\n");
    sb.append("    references: ").append(toIndentedString(references)).append("\n");
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
