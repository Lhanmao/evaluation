package com.evaluation_system.web.service;

import com.evaluation_system.web.dao.UserSessionDao;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserSession;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserSessionService {
    @Resource
    UserSessionDao userSessionDao;

    public void add(UserSession userSession) {
        userSessionDao.insertSelective(userSession);
    }

    public void delete(Integer id) {
        userSessionDao.deleteByPrimaryKey(id);
    }

    public PageInfo<UserSession> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<UserSession> list=userSessionDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public List<UserSession> findByCurId(Params params) {
        return userSessionDao.findByCurId(params);
    }

    public List<UserSession> findByCurList(Params params) {
        return userSessionDao.findByCurList(params);
    }

    public UserSession findNewContent(Integer id) {
        return userSessionDao.findNewContent(id);
    }

    public UserSession findHaveSession(UserSession userSession) {
        return userSessionDao.findHaveSession(userSession);
    }
}
