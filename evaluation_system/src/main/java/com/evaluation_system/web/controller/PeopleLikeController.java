package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.PeopleLike;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.service.PeopleLikeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/peopleLike")
public class PeopleLikeController {
    @Resource
    PeopleLikeService likeService;

    @PostMapping("/add")
    public Result save(@RequestBody PeopleLike peolike){
        PeopleLike haveLike=likeService.findBySearch(peolike);
//        System.out.println(haveLike.getUser_id());
        if(haveLike==null){
            likeService.add(peolike);
        }
        else {
            haveLike.setPeolike(peolike.getPeolike());
            haveLike.setCollect(peolike.getCollect());
            likeService.update(haveLike);
        }
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        likeService.delete(id);
        return Result.success();
    }

//    查找是否存在点赞和收藏
    @PostMapping("/findLike")
    public Result findLike(@RequestBody PeopleLike peolike){
        PeopleLike haveLike=likeService.findBySearch(peolike);
        return Result.success(haveLike);
    }

    @GetMapping("/findLikeNum")
    public Result findLikeNum(Params params){
        Map<String,String> map=new HashMap<>();
        String likeNum="",collectNum="";
        PeopleLike likeData = likeService.findByLike(params);
        PeopleLike collectData = likeService.findByCollect(params);
        if(likeData!=null) {
            likeNum = likeData.getLikeNum();
        }
        if(collectData!=null){
            collectNum=collectData.getCollectNum();
        }

        map.put("likeNum",likeNum);
        map.put("collectNum",collectNum);
//        List<String> list=new ArrayList<>();
//        list.add(likeNum);
//        list.add(collectNum);
//        PeopleLike haveLike=likeService.findBySearch(peolike);
        return Result.success(map);
    }
}
