package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.entity.UserLog;
import com.evaluation_system.web.service.UserLogService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@CrossOrigin
@RestController
@RequestMapping("/log")
public class UserLogController {

    @Resource
    private UserLogService userLogService;

    @PostMapping
    public Result save(@RequestBody UserLog userLog){
        userLogService.add(userLog);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params ){
        PageInfo<UserLog> list=userLogService.findBySearch(params);
        return Result.success(list);
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        userLogService.delete(id);
        return Result.success();
    }
}
