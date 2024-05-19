package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserSession;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface UserSessionDao extends Mapper<UserSession> {
    List<UserSession> findBySearch(@Param("params") Params params);

    List<UserSession> findByCurId(@Param("params") Params params);

    List<UserSession> findByCurList(@Param("params") Params params);

    UserSession findNewContent(Integer id);

    UserSession findHaveSession(UserSession userSession);
}
