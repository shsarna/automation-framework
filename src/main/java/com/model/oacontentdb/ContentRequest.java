package com.model.oacontentdb;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

@Entity
@Table(name = "content_request", schema = "oa_content")
public class ContentRequest implements Serializable {

    private static final long serialVersionUID = 7174259511835603535L;

    @Id
    @SequenceGenerator(
            allocationSize = 1,
            name = "oa_content.content_request_content_request_id_seq",
            sequenceName = "oa_content.content_request_content_request_id_seq"
    )
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "oa_content.content_request_content_request_id_seq")
    @Column(name = "content_request_id", nullable = false)
    private Long contentRequestId;

    @Column(nullable = false)
    private String request;

    @Column(name = "request_timestamp", nullable = false)
    private Timestamp requestTimestamp;

    @Column(name = "logfile_path", nullable = false)
    private String logFilePath;

    @Column(name = "request_type", nullable = false)
    private Character requestType;

    @Column(name = "response")
    private String response;

    @Column(name = "response_timestamp")
    private Timestamp responseTimestamp;

    @Column(name = "result")
    private String resultFilePath;

    @Column(name = "result_timestamp")
    private Timestamp resultTimestamp;

    @Column(name = "status",
            nullable = false)
    private Integer status;

    @Column(length = 50,
            name = "user_id",
            nullable = false)
    private String userId;

    public Long getContentRequestId() {

        return contentRequestId;
    }

    public String getLogFilePath() {

        return logFilePath;
    }

    public String getRequest() {

        return request;
    }

    public Timestamp getRequestTimestamp() {

        return requestTimestamp;
    }

    public Character getRequestType() {

        return requestType;
    }

    public String getResponse() {

        return response;
    }

    public Timestamp getResponseTimestamp() {

        return responseTimestamp;
    }

    public String getResultFilePath() {

        return resultFilePath;
    }

    public Timestamp getResultTimestamp() {

        return resultTimestamp;
    }

    public Integer getStatus() {

        return status;
    }

    public String getUserId() {

        return userId;
    }

    public void setContentRequestId(final Long contentRequestId) {

        this.contentRequestId = contentRequestId;
    }

    public void setLogFilePath(final String logFilePath) {

        this.logFilePath = logFilePath;
    }

    public void setRequest(final String request) {

        this.request = request;
    }

    public void setRequestTimestamp(final Timestamp requestTimestamp) {

        this.requestTimestamp = requestTimestamp;
    }

    public void setRequestType(final Character requestType) {

        this.requestType = requestType;
    }

    public void setResponse(final String response) {

        this.response = response;
    }

    public void setResponseTimestamp(final Timestamp responseTimestamp) {

        this.responseTimestamp = responseTimestamp;
    }

    public void setResultFilePath(final String resultFilePath) {

        this.resultFilePath = resultFilePath;
    }

    public void setResultTimestamp(final Timestamp resultTimestamp) {

        this.resultTimestamp = resultTimestamp;
    }

    public void setStatus(final Integer status) {

        this.status = status;
    }

    public void setUserId(final String userId) {

        this.userId = userId;
    }

}

