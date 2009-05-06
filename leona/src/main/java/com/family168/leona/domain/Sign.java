package com.family168.leona.domain;


// Generated by Hibernate Tools
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * Sign .
 *
 * @author Lingo
 */
@Entity
@Table(name = "SIGN")
public class Sign implements java.io.Serializable {
    /** null. */
    private Long id;

    /** null. */
    private Employee employee;

    /** null. */
    private SignState signState;

    /** null. */
    private Date time;

    /** null. */
    private Integer late;

    /** null. */
    private Integer quit;

    /** null. */
    private Integer leave;

    /** null. */
    private Integer work;

    public Sign() {
    }

    public Sign(Employee employee, SignState signState, Date time,
        Integer late, Integer quit, Integer leave, Integer work) {
        this.employee = employee;
        this.signState = signState;
        this.time = time;
        this.late = late;
        this.quit = quit;
        this.leave = leave;
        this.work = work;
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
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "EMPLOYEE_ID")
    public Employee getEmployee() {
        return this.employee;
    }

    /** @param employee null. */
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    /** @return null. */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SIGN_STATE_ID")
    public SignState getSignState() {
        return this.signState;
    }

    /** @param signState null. */
    public void setSignState(SignState signState) {
        this.signState = signState;
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

    /** @return null. */
    @Column(name = "LATE")
    public Integer getLate() {
        return this.late;
    }

    /** @param late null. */
    public void setLate(Integer late) {
        this.late = late;
    }

    /** @return null. */
    @Column(name = "QUIT")
    public Integer getQuit() {
        return this.quit;
    }

    /** @param quit null. */
    public void setQuit(Integer quit) {
        this.quit = quit;
    }

    /** @return null. */
    @Column(name = "LEAVE")
    public Integer getLeave() {
        return this.leave;
    }

    /** @param leave null. */
    public void setLeave(Integer leave) {
        this.leave = leave;
    }

    /** @return null. */
    @Column(name = "WORK")
    public Integer getWork() {
        return this.work;
    }

    /** @param work null. */
    public void setWork(Integer work) {
        this.work = work;
    }
}