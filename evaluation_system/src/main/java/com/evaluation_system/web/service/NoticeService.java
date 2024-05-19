package com.evaluation_system.web.service;

import cn.hutool.core.date.DateUtil;
import com.evaluation_system.web.dao.NoticeDao;
import com.evaluation_system.web.entity.Notice;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserLog;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class NoticeService {
    @Resource
    NoticeDao noticeDao;

    public void add(Notice notice) {
        notice.setCreate_date(DateUtil.now());
        noticeDao.insertSelective(notice);
    }

    public void update(Notice notice) {
        noticeDao.updateByPrimaryKeySelective(notice);
    }

    public PageInfo<Notice> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Notice> list=noticeDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public List<Notice> findAll() {
        return noticeDao.findAll();
    }

    public void delete(Integer id) {
        noticeDao.deleteByPrimaryKey(id);
    }

}
