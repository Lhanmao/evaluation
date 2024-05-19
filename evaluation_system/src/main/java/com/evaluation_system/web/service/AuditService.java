package com.evaluation_system.web.service;

import com.evaluation_system.web.dao.AuditDao;
import com.evaluation_system.web.entity.Audit;
import com.evaluation_system.web.entity.Blog;
import com.evaluation_system.web.entity.Params;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AuditService {
    @Resource
    AuditDao auditDao;

    public void add(Audit audit) {
        auditDao.insertSelective(audit);
    }

    public void update(Audit audit) {
        auditDao.updateByPrimaryKeySelective(audit);
    }

    public void delete(Integer id) {
        auditDao.deleteByPrimaryKey(id);
    }

    public PageInfo<Audit> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Audit> list=auditDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public Audit findByBlogId(Integer blog_id){
        return auditDao.findByBlogId(blog_id);
    }
}
