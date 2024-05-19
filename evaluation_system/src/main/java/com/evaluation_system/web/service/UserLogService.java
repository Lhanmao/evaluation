package com.evaluation_system.web.service;

import com.evaluation_system.web.dao.UserLogDao;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.entity.UserLog;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserLogService {
    @Resource
    private UserLogDao logDao;

    public void add(UserLog userLog){
        logDao.insertSelective(userLog);
    }

    public PageInfo<UserLog> findBySearch(Params params){
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<UserLog> list=logDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    //删除功能
    public void delete(Integer id) {
        logDao.deleteByPrimaryKey(id);
    }
}
