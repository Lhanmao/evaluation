package com.evaluation_system.web.service;

import cn.hutool.core.date.DateUtil;
import com.evaluation_system.web.dao.BlogDao;
import com.evaluation_system.web.entity.Blog;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BlogService {
    @Resource
    BlogDao blogDao;

    public void add(Blog blog) {
        if (blog.getTitle() == null || "".equals(blog.getTitle())) {
            throw new CustomException("标题不能为空");
        }

        blog.setRead_count(0);
        //发布时间
        blog.setDate(DateUtil.now());
        blog.setState("-1");
        blog.setPeople_like(0);
        blogDao.insertSelective(blog);
    }

    public void update(Blog blog) {
        blogDao.updateByPrimaryKeySelective(blog);
    }

    public void delete(Integer id) {
        blogDao.deleteByPrimaryKey(id);
    }

    public PageInfo<Blog> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Blog> list = blogDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public PageInfo<Blog> findHot(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Blog> list = blogDao.findHot(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public Blog findById(Integer id) {
        return blogDao.findById(id);
    }

    public PageInfo<Blog> findBySearchLike(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Blog> list = blogDao.findBySearchLike(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public PageInfo<Blog> findBySearchCollect(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Blog> list = blogDao.findBySearchCollect(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public List<Blog> findDayNum() {
        return blogDao.findDayNum();
    }

    public List<Blog> findDayBrand() {
        return blogDao.findDayBrand();
    }

    public List<Blog> findTags() {
        return blogDao.findTags();
    }

    public List<Blog> findAllBrand() {
        return blogDao.findAllBrand();
    }

    public PageInfo<Blog> findBySearchMyComment(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<Blog> list = blogDao.findBySearchMyComment(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public List<Blog> findByState() {
        return blogDao.findByState();
    }
}
