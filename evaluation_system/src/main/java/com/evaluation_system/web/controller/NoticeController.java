package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Notice;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.UserLog;
import com.evaluation_system.web.service.NoticeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/notice")
public class NoticeController {
    @Resource
    NoticeService noticeService;

    @PostMapping("/add")
    public Result save(@RequestBody Notice notice){
        if(notice.getId()==null){
            noticeService.add(notice);
        }
        else{
            noticeService.update(notice);
        }
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params){
        PageInfo<Notice> list=noticeService.findBySearch(params);
        return Result.success(list);
    }

    @GetMapping("/findAll")
    public Result findAll(){
        List<Notice> list=noticeService.findAll();
        return Result.success(list);
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        noticeService.delete(id);
        return Result.success();
    }
}
