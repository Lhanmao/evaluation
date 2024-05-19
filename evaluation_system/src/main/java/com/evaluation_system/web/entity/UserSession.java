package com.evaluation_system.web.entity;

import javax.persistence.*;

@Table(name="usersession")
public class UserSession {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer user_id;
    private Integer target_user_id;

    @Transient
    private Integer content_id;

    @Transient
    private String content;

    @Transient
    private String create_date;

    @Transient
    private String user_name;

    @Transient
    private String target_user_name;

    @Transient
    private String user_avatar;

    @Transient
    private String target_user_avatar;

    public Integer getContent_id() {
        return content_id;
    }

    public void setContent_id(Integer content_id) {
        this.content_id = content_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getTarget_user_name() {
        return target_user_name;
    }

    public void setTarget_user_name(String target_user_name) {
        this.target_user_name = target_user_name;
    }

    public String getUser_avatar() {
        return user_avatar;
    }

    public void setUser_avatar(String user_avatar) {
        this.user_avatar = user_avatar;
    }

    public String getTarget_user_avatar() {
        return target_user_avatar;
    }

    public void setTarget_user_avatar(String target_user_avatar) {
        this.target_user_avatar = target_user_avatar;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getTarget_user_id() {
        return target_user_id;
    }

    public void setTarget_user_id(Integer target_user_id) {
        this.target_user_id = target_user_id;
    }
}
