package com.model.domswdb;

import org.hibernate.annotations.NaturalId;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "dom_release_type", schema = "dom_sw_service")
public class DomSwReleaseType {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "dom_release_type_dom_release_type_id_seq")
    @SequenceGenerator(
            name = "dom_release_type_dom_release_type_id_seq",
            sequenceName = "dom_sw_service.dom_release_type_dom_release_type_id_seq",
            allocationSize = 1
    )
    @Column(name = "dom_release_type_id")
    private Long id;

    @NotNull
    @Column(name = "dom_release_type_name", unique = true)
    @NaturalId
    private String releaseTypeName;

    @Column(name = "description")
    private String releaseTypeDescription;

    public Long getId() {
        return id;
    }

    public DomSwReleaseType setId(Long id) {
        this.id = id;
        return this;
    }

    public String getReleaseTypeName() {
        return releaseTypeName;
    }

    public DomSwReleaseType setReleaseTypeName(String releaseTypeName) {
        this.releaseTypeName = releaseTypeName;
        return this;
    }

    public String getReleaseTypeDescription() {
        return releaseTypeDescription;
    }

    public DomSwReleaseType setReleaseTypeDescription(String releaseTypeDescription) {
        this.releaseTypeDescription = releaseTypeDescription;
        return this;
    }
}