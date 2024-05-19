package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Notice;
import com.evaluation_system.web.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface NoticeDao extends Mapper<Notice> {
    List<Notice> findBySearch(@Param("params") Params params);

    List<Notice> findAll();
}
