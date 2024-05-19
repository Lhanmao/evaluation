package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.Comment;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.service.CommentService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/comment")
public class CommentController {
    @Resource
    CommentService commentService;

    @PostMapping("/add")
    public Result save(@RequestBody Comment comment) {
        if (comment.getId() == null) {
            commentService.add(comment);
        } else {
            commentService.update(comment);
        }
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        commentService.delete(id);
        return Result.success();
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Comment> list) {
        for (Comment comment : list) {
            commentService.delete(comment.getId());
        }
        return Result.success();
    }

    @GetMapping("/findAll")
    public Result findAll() {
        List<Comment> list = commentService.findAll();
        return Result.success(list);
    }

    @GetMapping("/findAllComment/{blog_id}")
    public Result findAllComment(@PathVariable Integer blog_id) {
        List<Comment> list = commentService.findAllComment(blog_id);//筛选本文章的评论
        List<Comment> list1 = new ArrayList<>();
        List<Comment> list2 = new ArrayList<>();
        List<Comment> list3 = new ArrayList<>();
        for (Comment item : list) {
            if (item.getPid() == 0) {//筛选一级评论
                list1.add(item);
            }
            else if (item.getTarget_id() == 0) {//筛选二级评论
                list2.add(item);
            } else {//筛选二级回复的评论
                list3.add(item);
            }
        }

        for(int i=0;i<list2.size();i++){
            for(int j=0;j<list3.size();j++){
                if(list2.get(i).getId()==list3.get(j).getTarget_id()){
                    list3.get(j).setRecUserName(list2.get(i).getUser_name());
                }
            }
        }

        for (Comment item2 : list2) {
            List<Comment> listLow = new ArrayList<>();
            for (Comment item3 : list3) {
                if (item2.getId() == item3.getTarget_id()) {
                    listLow.add(item3);
                }
            }
            if(listLow.size()!=0) {
                for(int i=0;i<list2.size();++i){
                    if(item2.getId()==list2.get(i).getId()){
                        list2.get(i).setList(listLow);
                    }
                }
            }
        }

        for (Comment item1 : list1) {
            List<Comment> listLow = new ArrayList<>();
            for (Comment item2 : list2) {
                if (item1.getId() == item2.getPid()) {
                    listLow.add(item2);
                }
            }
            if(listLow.size()!=0) {
                for(int i=0;i<list1.size();++i){
                    if(item1.getId()==list1.get(i).getId()){
                        list1.get(i).setList(listLow);
                    }
                }
            }
        }
        return Result.success(list1);
    }

    @GetMapping("/findCommentNum/{blog_id}")
    public Result findCommentNum(@PathVariable Integer blog_id) {
        List<Comment> list = commentService.findCommentNum(blog_id);
        Map<Integer,String> map=new HashMap<>();
        for(Comment item:list){
            map.put(item.getPid(),item.getCommentNum());
        }
        return Result.success(map);
    }

    @GetMapping("/findNum/{blog_id}")
    public Result findNum(@PathVariable Integer blog_id) {
        Comment comCount=commentService.findNum(blog_id);
        String allComment="";
        if(comCount!=null) {
            allComment = comCount.getAllComment();
        }
        return Result.success(allComment);
    }

    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Comment> list = commentService.findBySearch(params);
        return Result.success(list);
    }

    @GetMapping("/findRecUser/{target_id}")
    public Result findRecUser(@PathVariable Integer target_id) {
        Comment Rec=commentService.findRecUser(target_id);
        return Result.success(Rec);
    }

}
