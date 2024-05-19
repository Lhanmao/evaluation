//package com.evaluation_system.web.controller;
//
//import com.evaluation_system.web.common.Result;
//import com.evaluation_system.web.entity.Admin;
//import com.evaluation_system.web.entity.Params;
//import com.evaluation_system.web.service.AdminService;
//import com.github.pagehelper.PageInfo;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.web.bind.annotation.*;
//
//import javax.annotation.Resource;
//
//
//@CrossOrigin
//@RestController
//@RequestMapping("/admin")
//public class AdminController {
//
//    @Resource
//    private AdminService adminService;
//
////    @GetMapping("/hello")
////    public Result hello(){
////        return Result.success("HelloWorld!");
////    }
////
////    @GetMapping("/getUser")
////    public Result getUser(){
////        List<Admin> list=adminService.getUser();
////        return Result.success(list);
////    }
//
//    @PostMapping("/add")
//    public Result save(@RequestBody Admin admin){
//        if(admin.getId()==null){
//            adminService.add(admin);
//        }
//        else{
//            adminService.update(admin);
//        }
//
//        return Result.success();
//    }
//
//    @DeleteMapping("/delete/{id}")
//    public Result delete(@PathVariable Integer id){
//        adminService.delete(id);
//        return Result.success();
//    }
//
//    @GetMapping("/search")
//    public Result findBySearch(Params params){
//        PageInfo<Admin> list=adminService.findBySearch(params);
//        return Result.success(list);
//    }
//
//}
