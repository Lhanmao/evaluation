package com.evaluation_system.web.entity;

import javax.persistence.*;

@Table(name="sessioncontent")
public class SessionContent {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;

    private Integer session_id;
    private String content;
    private Integer user_id;
    private Integer target_user_id;
    private String create_date;

    @Transient
    private Integer content_id;

    public Integer getContent_id() {
        return content_id;
    }

    public void setContent_id(Integer content_id) {
        this.content_id = content_id;
    }

    public Integer getTarget_user_id() {
        return target_user_id;
    }

    public void setTarget_user_id(Integer target_user_id) {
        this.target_user_id = target_user_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSession_id() {
        return session_id;
    }

    public void setSession_id(Integer session_id) {
        this.session_id = session_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }
}
