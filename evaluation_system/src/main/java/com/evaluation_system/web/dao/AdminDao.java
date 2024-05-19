//package com.evaluation_system.web.dao;
//
//import com.evaluation_system.web.entity.Admin;
//import com.evaluation_system.web.entity.Params;
//import io.lettuce.core.dynamic.annotation.Param;
//import org.springframework.stereotype.Repository;
//import tk.mybatis.mapper.common.Mapper;
//
//import java.util.List;
//
//@Repository
//public interface AdminDao extends Mapper<Admin> {
//    //基于注解的方式
////    @Select("select * from user ")
////    List<Admin> getUser();
//
//    List<Admin> findBySearch(@Param("params")Params params);
//
//    Admin findByName(@Param("name") String name);
//
//    Admin findByNameAndPassword(@Param("name") String name, @Param("password") String password);
//}
