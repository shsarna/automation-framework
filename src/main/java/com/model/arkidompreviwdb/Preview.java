package com.model.arkidompreviwdb;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "preview", schema = "arki_dom_preview")
public class Preview {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "preview_id_generator")
    @SequenceGenerator(name = "preview_id_generator",
            schema = "arki_dom_preview",
            sequenceName = "preview_preview_id_seq",
            allocationSize = 1)
    @Column(name = "preview_id", nullable = false)
    private Long previewId;

    @Column(name = "request", nullable = false)
    private String request;

    @Column(name = "user_id")
    private String user_id;

    @Column(name = "status", nullable = false)
    private Integer status;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "creation_timestamp", nullable = false)
    private Date creationTimestamp;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "modification_timestamp")
    private Date modificationTimestamp;

    public Long getPreviewId() {
        return previewId;
    }

    public Preview withPreviewId(Long previewId) {
        this.previewId = previewId;
        return this;
    }

    public String getRequest() {
        return request;
    }

    public Preview withRequest(String request) {
        this.request = request;
        return this;
    }

    public String getUser_id() {
        return user_id;
    }

    public Preview withUser_id(String user_id) {
        this.user_id = user_id;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public Preview withStatus(Integer status) {
        this.status = status;
        return this;
    }

    public Date getCreationTimestamp() {
        return creationTimestamp;
    }

    public Preview withCreationTimestamp(Date creationTimestamp) {
        this.creationTimestamp = creationTimestamp;
        return this;
    }

    public Date getModificationTimestamp() {
        return modificationTimestamp;
    }

    public Preview withModificationTimestamp(Date modificationTimestamp) {
        this.modificationTimestamp = modificationTimestamp;
        return this;
    }
}
