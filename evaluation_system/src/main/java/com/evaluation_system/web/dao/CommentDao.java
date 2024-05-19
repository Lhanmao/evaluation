package com.evaluation_system.web.dao;

import com.evaluation_system.web.entity.Comment;
import com.evaluation_system.web.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


@Repository
public interface CommentDao extends Mapper<Comment> {
    List<Comment> findAllComment(Integer blog_id);

    List<Comment> findBySearch(@Param("params") Params params);

    Comment findRecUser(Integer target_id);

    Comment findNum(Integer blog_id);

    List<Comment> findCommentNum(Integer blog_id);

    void delByBolgId(Integer id);
}
