package com.model.arkidompreviwdb;

import javax.persistence.*;

@Entity
@Table(name = "preview_property", schema = "arki_dom_preview")
public class PreviewProperty {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "preview_property_id_generator")
    @SequenceGenerator(name = "preview_property_id_generator",
            schema = "arki_dom_preview",
            sequenceName = "preview_property_preview_property_id_seq",
            allocationSize = 1)
    @Column(name = "preview_property_id", nullable = false)
    private Long previewPropertyId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "preview_id", nullable = false)
    private Preview preview;

    @Column(name = "property_group", nullable = false)
    private String group;

    @Column(name = "property_key", nullable = false)
    private String key;

    @Column(name = "property_value", nullable = false)
    private String value;

    public Long getPreviewPropertyId() {
        return previewPropertyId;
    }

    public PreviewProperty withPreviewPropertyId(Long previewPropertyId) {
        this.previewPropertyId = previewPropertyId;
        return this;
    }

    public Preview getPreview() {
        return preview;
    }

    public PreviewProperty withPreview(Preview preview) {
        this.preview = preview;
        return this;
    }

    public String getGroup() {
        return group;
    }

    public PreviewProperty withGroup(String group) {
        this.group = group;
        return this;
    }

    public String getKey() {
        return key;
    }

    public PreviewProperty withKey(String key) {
        this.key = key;
        return this;
    }

    public String getValue() {
        return value;
    }

    public PreviewProperty withValue(String value) {
        this.value = value;
        return this;
    }
}