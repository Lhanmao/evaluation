package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Blog;
import com.evaluation_system.web.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface BlogDao extends Mapper<Blog> {
    List<Blog> findBySearch(@Param("params") Params params);

    List<Blog> findHot(@Param("params") Params params);

    Blog findById(Integer id);

    List<Blog> findBySearchLike(@Param("params") Params params);

    List<Blog> findBySearchCollect(@Param("params") Params params);

    List<Blog> findDayNum();

    List<Blog> findDayBrand();

    @Select("select tags,read_count from blog")
    List<Blog> findTags();

    List<Blog> findAllBrand();

    List<Blog> findBySearchMyComment(@Param("params") Params params);

    @Select("select id from blog where state='-1'")
    List<Blog> findByState();
}
