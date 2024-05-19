package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Audit;
import com.evaluation_system.web.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface AuditDao extends Mapper<Audit> {
    List<Audit> findBySearch(@Param("params") Params params);

    @Select("select * from audit where blog_id=#{blog_id}")
    Audit findByBlogId(Integer blog_id);
}
