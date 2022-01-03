package com.model.rest;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Xml data.
 */
@ApiModel(description = "Xml data.")
@Validated
@javax.annotation.Generated(value = "io.swagger.codegen.v3.generators.java.SpringCodegen", date = "2021-04-09T11:11:43.078716100+02:00[Europe/Berlin]")
public class OaContentServiceUpdateXmlObjectSchema   {
  @JsonProperty("xmlDataId")
  private BigDecimal xmlDataId = null;

  @JsonProperty("data")
  private String data = null;

  @JsonProperty("title")
  private String title = null;

  @JsonProperty("schemaRef")
  private String schemaRef = null;

  @JsonProperty("searchMeta")
  @Valid
  private List<OaContentServiceUpdateSearchMetaSchema> searchMeta = null;

  public OaContentServiceUpdateXmlObjectSchema xmlDataId(BigDecimal xmlDataId) {
    this.xmlDataId = xmlDataId;
    return this;
  }

  /**
   * Internal Id of the xml payload.
   * @return xmlDataId
  **/
  @ApiModelProperty(required = true, value = "Internal Id of the xml payload.")
  @NotNull

  @Valid
  public BigDecimal getXmlDataId() {
    return xmlDataId;
  }

  public void setXmlDataId(BigDecimal xmlDataId) {
    this.xmlDataId = xmlDataId;
  }

  public OaContentServiceUpdateXmlObjectSchema data(String data) {
    this.data = data;
    return this;
  }

  /**
   * XML fragment of the content data.
   * @return data
  **/
  @ApiModelProperty(required = true, value = "XML fragment of the content data.")
  @NotNull

  public String getData() {
    return data;
  }

  public void setData(String data) {
    this.data = data;
  }

  public OaContentServiceUpdateXmlObjectSchema title(String title) {
    this.title = title;
    return this;
  }

  /**
   * Optional title or heading for the XML content. Used to search for the content. For data imported from an ARKI4 Super-XML file, it is populated with the title of a topic, extracted from the \"title\" or \"overview-title\" field, if this is present.
   * @return title
  **/
  @ApiModelProperty(value = "Optional title or heading for the XML content. Used to search for the content. For data imported from an ARKI4 Super-XML file, it is populated with the title of a topic, extracted from the \"title\" or \"overview-title\" field, if this is present.")

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public OaContentServiceUpdateXmlObjectSchema schemaRef(String schemaRef) {
    this.schemaRef = schemaRef;
    return this;
  }

  /**
   * Reference to the XML schema (XSD or DTD) which describes the XML data.
   * @return schemaRef
  **/
  @ApiModelProperty(value = "Reference to the XML schema (XSD or DTD) which describes the XML data.")

@Size(max=2000)   public String getSchemaRef() {
    return schemaRef;
  }

  public void setSchemaRef(String schemaRef) {
    this.schemaRef = schemaRef;
  }

  public OaContentServiceUpdateXmlObjectSchema searchMeta(List<OaContentServiceUpdateSearchMetaSchema> searchMeta) {
    this.searchMeta = searchMeta;
    return this;
  }

  public OaContentServiceUpdateXmlObjectSchema addSearchMetaItem(OaContentServiceUpdateSearchMetaSchema searchMetaItem) {
    if (this.searchMeta == null) {
      this.searchMeta = new ArrayList<>();
    }
    this.searchMeta.add(searchMetaItem);
    return this;
  }

  /**
   * Search metadata for xml data.
   * @return searchMeta
  **/
  @ApiModelProperty(value = "Search metadata for xml data.")
  @Valid
  public List<OaContentServiceUpdateSearchMetaSchema> getSearchMeta() {
    return searchMeta;
  }

  public void setSearchMeta(List<OaContentServiceUpdateSearchMetaSchema> searchMeta) {
    this.searchMeta = searchMeta;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    OaContentServiceUpdateXmlObjectSchema oaContentServiceUpdateXmlObjectSchema = (OaContentServiceUpdateXmlObjectSchema) o;
    return Objects.equals(this.xmlDataId, oaContentServiceUpdateXmlObjectSchema.xmlDataId) &&
        Objects.equals(this.data, oaContentServiceUpdateXmlObjectSchema.data) &&
        Objects.equals(this.title, oaContentServiceUpdateXmlObjectSchema.title) &&
        Objects.equals(this.schemaRef, oaContentServiceUpdateXmlObjectSchema.schemaRef) &&
        Objects.equals(this.searchMeta, oaContentServiceUpdateXmlObjectSchema.searchMeta);
  }

  @Override
  public int hashCode() {
    return Objects.hash(xmlDataId, data, title, schemaRef, searchMeta);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class OaContentServiceUpdateXmlObjectSchema {\n");
    
    sb.append("    xmlDataId: ").append(toIndentedString(xmlDataId)).append("\n");
    sb.append("    data: ").append(toIndentedString(data)).append("\n");
    sb.append("    title: ").append(toIndentedString(title)).append("\n");
    sb.append("    schemaRef: ").append(toIndentedString(schemaRef)).append("\n");
    sb.append("    searchMeta: ").append(toIndentedString(searchMeta)).append("\n");
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
