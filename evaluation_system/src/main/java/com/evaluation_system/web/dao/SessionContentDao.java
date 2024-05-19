package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.SessionContent;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface SessionContentDao extends Mapper<SessionContent> {
    List<SessionContent> findBySearch(@Param("params") Params params);
}
