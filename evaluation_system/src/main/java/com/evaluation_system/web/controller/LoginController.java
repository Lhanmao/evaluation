package com.evaluation_system.web.controller;

import cn.hutool.core.date.DateUtil;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.common.log.AutoLog;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


@CrossOrigin
@RestController
public class LoginController {

    @Resource
    private UserService userService;

    @PostMapping("/login")
    @AutoLog("用户登录")
    public Result login(@RequestBody User user){
        User loginUser = userService.login(user);
        return Result.success(loginUser);
    }
    @PostMapping("/regist")
    public Result regist(@RequestBody User user){
        userService.regist(user);
        return Result.success();
    }
    @PostMapping("/rePwd")
    public Result repwd(@RequestBody User user){
        userService.repwd(user);
        return Result.success();
    }
}
