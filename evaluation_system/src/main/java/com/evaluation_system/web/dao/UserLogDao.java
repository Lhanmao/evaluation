package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserLog;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface UserLogDao extends Mapper<UserLog> {
    List<UserLog> findBySearch(@Param("params") Params params);
}
