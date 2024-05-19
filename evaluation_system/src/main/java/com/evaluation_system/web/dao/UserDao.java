package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface UserDao extends Mapper<User> {
    //基于注解的方式
//    @Select("select * from user ")
//    List<Admin> getUser();

    List<User> findBySearch(@Param("params") Params params);

    User findByName(@Param("name") String name);

    User findByNameAndPassword(@Param("name") String name, @Param("password") String password);

    User findByNameAndPhone(@Param("name")String name, @Param("phone")String phone);

    List<User> findUserNum();

    List<User> findUserDayNew();

    List<User> findGenderDayNew();
}
