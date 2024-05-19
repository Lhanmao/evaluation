//package com.evaluation_system.web.entity;
//
//import javax.persistence.*;
//
//@Table(name="admin")
//public class Admin {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Integer id;
//
//    private String name;
//    private String password;
//    private String gender;
//    private Integer age;
//    private String phone;
//    @Transient
//    private String token;
//
//    public String getToken() {
//        return token;
//    }
//
//    public void setToken(String token) {
//        this.token = token;
//    }
//
//    public Integer getId(){
//        return id;
//    }
//    public void setId(Integer id){
//        this.id=id;
//    }
//
//    public String getName(){
//        return name;
//    }
//    public void setName(String name){
//        this.name=name;
//    }
//
//    public String getPassword(){
//        return password;
//    }
//    public void setPassword(String password){
//        this.password=password;
//    }
//
//    public String getGender(){
//        return gender;
//    }
//    public void setGender(String gender){
//        this.gender=gender;
//    }
//
//    public Integer getAge(){
//        return age;
//    }
//    public void setAge(Integer age){
//        this.age=age;
//    }
//
//    public String getPhone(){
//        return phone;
//    }
//    public void setPhone(String phone){
//        this.phone=phone;
//    }
//
//
//
//}
