package com.evaluation_system.web.service;

import cn.hutool.core.date.DateUtil;
import com.evaluation_system.web.dao.SessionContentDao;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.SessionContent;
import com.evaluation_system.web.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SessionContentService {
    @Resource
    SessionContentDao sessionContentDao;

    public void add(SessionContent sessionContent) {
        if (sessionContent.getContent() == null || "".equals(sessionContent.getContent())) {
            throw new CustomException("请输入内容");
        }
        sessionContent.setCreate_date(DateUtil.now());
        sessionContentDao.insertSelective(sessionContent);
    }

    public PageInfo<SessionContent> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        List<SessionContent> list = sessionContentDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public void delete(Integer id) {
        sessionContentDao.deleteByPrimaryKey(id);
    }
}
