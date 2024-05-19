package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserLog;
import com.evaluation_system.web.entity.UserSession;
import com.evaluation_system.web.service.UserSessionService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/userSession")
public class UserSessionController {
    @Resource
    UserSessionService userSessionService;

    @PostMapping("/add")
    public Result save(@RequestBody UserSession userSession){
        UserSession haveSession=userSessionService.findHaveSession(userSession);
        if(haveSession==null&&userSession.getUser_id()!=userSession.getTarget_user_id()){
            userSessionService.add(userSession);
            System.out.println("空");
        }
//        System.out.println(haveSession.getId());
//        System.out.println(haveSession.getUser_id());
//        System.out.println(haveSession.getTarget_user_id());
//        userSessionService.add(userSession);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params ){
        PageInfo<UserSession> list=userSessionService.findBySearch(params);
        return Result.success(list);
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        userSessionService.delete(id);
        return Result.success();
    }

    @GetMapping("/findByCurList")
    public Result findByCurList(Params params){
        List<UserSession> list=userSessionService.findByCurList(params);
        for(int i=0;i<list.size();++i){
            UserSession userSession=userSessionService.findNewContent(list.get(i).getId());
            if(userSession!=null) {
                String content=userSession.getContent();
                list.get(i).setContent(content);
            }
        }
        return Result.success(list);
    }

    @GetMapping("/findByCurId")
    public Result findByCurId(Params params ){
        List<UserSession> list=userSessionService.findByCurId(params);
        return Result.success(list);
    }

//    @GetMapping("/findNewContent/{id}")
//    public Result findNewContent(@PathVariable Integer id){
//        UserSession userSession=userSessionService.findNewContent(id);
//        return Result.success(userSession.getContent());
//    }

}
