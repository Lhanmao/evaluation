package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.JwtTokenUtils;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.*;
import com.evaluation_system.web.exception.CustomException;
import com.evaluation_system.web.service.AuditService;
import com.evaluation_system.web.service.BlogService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/audit")
public class AuditController {
    @Resource
    AuditService auditService;
    @Resource
    BlogService blogService;

    @PostMapping("/add")
    public Result save(@RequestBody Audit audit) {
        if (audit.getId() == null) {
            auditService.add(audit);
        } else {
            if (audit.getAudit_content() == null) {
                throw new CustomException("请选择审核意见");
            }
            Blog curBlog = blogService.findById(audit.getBlog_id());
            if (audit.getAudit_content().equals("审核通过")) {
                curBlog.setState("1");
            } else {
                curBlog.setState("0");
            }
            blogService.update(curBlog);
            auditService.update(audit);
        }
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        auditService.delete(id);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Audit> list = auditService.findBySearch(params);
        return Result.success(list);
    }
}
