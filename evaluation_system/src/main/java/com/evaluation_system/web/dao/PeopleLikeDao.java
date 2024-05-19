package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.PeopleLike;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


@Repository
public interface PeopleLikeDao extends Mapper<PeopleLike> {
    PeopleLike findBySearch(@Param("user_id") Integer user_id,@Param("blog_id") Integer blog_id);

    PeopleLike findByCollect(@Param("params") Params params);

    PeopleLike findByLike(@Param("params") Params params);

    List<PeopleLike> findAllBlogLike();

    void delByBolgId(Integer id);
}
