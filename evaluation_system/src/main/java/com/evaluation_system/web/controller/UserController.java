package com.evaluation_system.web.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.evaluation_system.web.common.log.AutoLog;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.exception.CustomException;
import com.evaluation_system.web.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @PostMapping("/add")
    public Result save(@RequestBody User user){
        if(user.getUser_id()==null){
            userService.add(user);
        }
        else{
            userService.update(user);
        }

        return Result.success();
    }

    @DeleteMapping("/delete/{user_id}")
    @AutoLog("删除用户操作")
    public Result delete(@PathVariable Integer user_id){
        userService.delete(user_id);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params){
        PageInfo<User> list=userService.findBySearch(params);
        return Result.success(list);
    }

//    查询文章作者
    @GetMapping("/findById/{id}")
    public Result findById(@PathVariable Integer id){
        User user= userService.findById(id);
        return Result.success(user);
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<User> list){
        for(User user:list){
            userService.delete(user.getUser_id());
        }
        return Result.success();
    }

    @GetMapping("/export")
    public Result export(HttpServletResponse response) throws IOException {
        //每一行数据对应一个user类
        List<User> all=userService.findAll();
        if(CollectionUtil.isEmpty(all)){//hutool包的工具
            throw new CustomException("未找到数据");
        }

        List<Map<String,Object>> list=new ArrayList<>(all.size());

        for(User user:all){
            Map<String,Object> row=new HashMap<>();
            row.put("姓名",user.getUser_name());
            row.put("昵称",user.getNick_name());
            row.put("用户类型",user.getUser_type());
            row.put("年龄",user.getAge());
            row.put("性别",user.getGender());
            row.put("电话号码",user.getPhone());
            row.put("邮箱",user.getEmail());

            list.add(row);
        }

        ExcelWriter wr= ExcelUtil.getWriter(true);
        wr.write(list,true);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        response.setHeader("Content-Disposition","attachment;filename=user.xlsx");
        ServletOutputStream out=response.getOutputStream();
        wr.flush(out,true);
        wr.close();
        IoUtil.close(System.out);
        return Result.success();
    }

    @PostMapping("/inport")
    public Result inport(MultipartFile file) throws IOException {
        List<User> infoList=ExcelUtil.getReader(file.getInputStream()).readAll(User.class);
        if(!CollectionUtil.isEmpty(infoList)){
            for(User user:infoList){
                try{
                    userService.add(user);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        return Result.success();
    }
}
