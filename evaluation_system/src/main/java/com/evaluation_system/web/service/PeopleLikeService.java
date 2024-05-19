package com.evaluation_system.web.service;

import com.evaluation_system.web.dao.PeopleLikeDao;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.PeopleLike;
import com.evaluation_system.web.exception.CustomException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PeopleLikeService {
    @Resource
    PeopleLikeDao likeDao;

    public void add(PeopleLike like) {
        if(like.getUser_id()==null){
            throw new CustomException("用户未登录");
        }

        likeDao.insertSelective(like);
    }

    public void update(PeopleLike like) {
        likeDao.updateByPrimaryKeySelective(like);
    }

    public void delete(Integer id) {
        likeDao.deleteByPrimaryKey(id);
    }

    public PeopleLike findBySearch(PeopleLike peolike) {
        return likeDao.findBySearch(peolike.getUser_id(),peolike.getBlog_id());
    }

    public PeopleLike findByCollect(Params params) {
        return likeDao.findByCollect(params);
    }

    public PeopleLike findByLike(Params params) {
        return likeDao.findByLike(params);
    }

    public List<PeopleLike> findAllBlogLike() {
        return likeDao.findAllBlogLike();
    }

    public void delByBolgId(Integer id) {
        likeDao.delByBolgId(id);
    }
}
