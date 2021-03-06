package com.family168.leona.domain;


// Generated by Hibernate Tools
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * SignState .
 *
 * @author Lingo
 */
@Entity
@Table(name = "SIGN_STATE")
public class SignState implements java.io.Serializable {
    /** null. */
    private Long id;

    /** null. */
    private String name;

    /** null. */
    private Date time;

    /** . */
    private Set<Sign> signs = new HashSet<Sign>(0);

    public SignState() {
    }

    public SignState(String name, Date time, Set<Sign> signs) {
        this.name = name;
        this.time = time;
        this.signs = signs;
    }

    /** @return null. */
    @Id
    @GeneratedValue
    @Column(name = "ID", unique = true, nullable = false)
    public Long getId() {
        return this.id;
    }

    /** @param id null. */
    public void setId(Long id) {
        this.id = id;
    }

    /** @return null. */
    @Column(name = "NAME", length = 20)
    public String getName() {
        return this.name;
    }

    /** @param name null. */
    public void setName(String name) {
        this.name = name;
    }

    /** @return null. */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "TIME", length = 6)
    public Date getTime() {
        return this.time;
    }

    /** @param time null. */
    public void setTime(Date time) {
        this.time = time;
    }

    /** @return . */
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "signState")
    public Set<Sign> getSigns() {
        return this.signs;
    }

    /** @param signs . */
    public void setSigns(Set<Sign> signs) {
        this.signs = signs;
    }
}
