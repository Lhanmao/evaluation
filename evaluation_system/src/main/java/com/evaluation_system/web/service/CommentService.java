package com.evaluation_system.web.service;

import cn.hutool.core.date.DateUtil;
import com.evaluation_system.web.dao.CommentDao;
import com.evaluation_system.web.entity.Comment;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentService {
    @Resource
    CommentDao commentDao;

    public void add(Comment comment) {
        if(comment.getContent()==null||comment.getContent()==""){
            throw new CustomException("评论不能为空");
        }

        //添加用户发布时间
        comment.setCreate_time(DateUtil.now());

        commentDao.insertSelective(comment);
    }

    public void update(Comment comment) {
        commentDao.updateByPrimaryKeySelective(comment);
    }

    public void delete(Integer id) {
        commentDao.deleteByPrimaryKey(id);
    }

    public List<Comment> findAll() {
        return commentDao.selectAll();
    }

    public List<Comment> findAllComment(Integer blog_id) {
        return commentDao.findAllComment(blog_id);
    }

    public PageInfo<Comment> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Comment> list=commentDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public Comment findRecUser(Integer target_id) {
        return commentDao.findRecUser(target_id);
    }

    public Comment findNum(Integer blog_id) {
        return commentDao.findNum(blog_id);
    }

    public List<Comment> findCommentNum(Integer blog_id) {
        return commentDao.findCommentNum(blog_id);
    }

    public void delByBolgId(Integer id) {
        commentDao.delByBolgId(id);
    }
}
