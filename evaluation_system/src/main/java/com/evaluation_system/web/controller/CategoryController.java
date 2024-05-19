package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Category;
import com.evaluation_system.web.entity.Comment;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.service.CategoryService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/category")
public class CategoryController {
    @Resource
    CategoryService categoryService;

    @PostMapping("/add")
    public Result save(@RequestBody Category category){
        if(category.getId()==null){
            categoryService.add(category);
        }
        else {
            categoryService.update(category);
        }
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        categoryService.delete(id);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params){
        PageInfo<Category> list=categoryService.findBySearch(params);
        return Result.success(list);
    }

    @GetMapping("/findAll")
    public Result findAll(){
        List<Category> list=categoryService.findAll();
        return Result.success(list);
    }

}
