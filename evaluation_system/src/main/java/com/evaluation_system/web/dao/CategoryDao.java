package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Category;
import com.evaluation_system.web.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface CategoryDao extends Mapper<Category> {
    Category findByName(@Param("name") String name);

    List<Category> findBySearch(@Param("params") Params params);
}
