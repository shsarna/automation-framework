package com.model.domswdb;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "dom_release", schema = "dom_sw_service")
public class DomSwRelease {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "dom_release_dom_release_id_seq")
    @SequenceGenerator(name = "dom_release_dom_release_id_seq",
            sequenceName = "dom_sw_service.dom_release_dom_release_id_seq",
            allocationSize = 1)
    @Column(name = "dom_release_id")
    private Long id;

    @NotNull
    @Column(name = "url")
    private String url;

    @NotNull
    @Column(name = "major_version")
    private Integer majorVersion;

    @NotNull
    @Column(name = "minor_version")
    private Integer minorVersion;

    @NotNull
    @Column(name = "patch_version")
    private Integer patchVersion;

    @ManyToOne
    @JoinColumn(name = "dom_release_type_id", foreignKey = @ForeignKey(name = "fk_dom_release_dom_release_type"))
    private DomSwReleaseType releaseType;

    public Long getId() {
        return id;
    }

    public DomSwRelease setId(Long id) {
        this.id = id;
        return this;
    }

    public String getUrl() {
        return url;
    }

    public DomSwRelease setUrl(String url) {
        this.url = url;
        return this;
    }

    public Integer getMajorVersion() {
        return majorVersion;
    }

    public DomSwRelease setMajorVersion(Integer majorVersion) {
        this.majorVersion = majorVersion;
        return this;
    }

    public Integer getMinorVersion() {
        return minorVersion;
    }

    public DomSwRelease setMinorVersion(Integer minorVersion) {
        this.minorVersion = minorVersion;
        return this;
    }

    public Integer getPatchVersion() {
        return patchVersion;
    }

    public DomSwRelease setPatchVersion(Integer patchVersion) {
        this.patchVersion = patchVersion;
        return this;
    }

    public DomSwReleaseType getReleaseType() {
        return releaseType;
    }

    public DomSwRelease setReleaseType(DomSwReleaseType releaseType) {
        this.releaseType = releaseType;
        return this;
    }
}
