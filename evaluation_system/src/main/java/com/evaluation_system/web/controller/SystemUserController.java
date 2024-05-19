package com.evaluation_system.web.controller;

import cn.hutool.core.collection.CollectionUtil;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.service.UserService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/systemUser")
public class SystemUserController {
    @Resource
    UserService userService;

    @GetMapping("/echarts/bar")
    public Result bar(){
        //查询所有用户
        List<User> list=userService.findUserNum();
        return Result.success(list);
    }

    @GetMapping("/echarts/line")
    public Result line(){
        //查询新注册用户
        List<User> list=userService.findUserDayNew();
        return Result.success(list);
    }

    @GetMapping("/echarts/pie")
    public Result pie(){
        //查询新注册用户
        List<User> list=userService.findGenderDayNew();
        List<Map<String,Object>> mapList=new ArrayList<>();
        if(CollectionUtil.isNotEmpty(list)){
            for(User u:list){
                Map<String,Object> map=new HashMap<>();
                map.put("name",u.getGender());
                map.put("value",u.getNewNum());
                mapList.add(map);
            }
        }
        return Result.success(mapList);
    }
}
