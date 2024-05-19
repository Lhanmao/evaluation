package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Comment;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.SessionContent;
import com.evaluation_system.web.entity.UserSession;
import com.evaluation_system.web.service.SessionContentService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/sessioncontent")
public class SessionContentController {
    @Resource
    SessionContentService sessionContentService;

    @PostMapping("/add")
    public Result save(@RequestBody SessionContent sessionContent){
        sessionContentService.add(sessionContent);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params ){
        PageInfo<SessionContent> list=sessionContentService.findBySearch(params);
        return Result.success(list);
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        sessionContentService.delete(id);
        return Result.success();
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<SessionContent> list) {
        for (SessionContent sessionContent : list) {
            sessionContentService.delete(sessionContent.getContent_id());
        }
        return Result.success();
    }

}
