package com.evaluation_system.web.controller;

import cn.hutool.core.collection.CollectionUtil;
import com.evaluation_system.web.common.JwtTokenUtils;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.*;
import com.evaluation_system.web.service.AuditService;
import com.evaluation_system.web.service.BlogService;
import com.evaluation_system.web.service.CommentService;
import com.evaluation_system.web.service.PeopleLikeService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/blog")
public class BlogController {
    @Resource
    BlogService blogService;

    @Resource
    PeopleLikeService likeService;

    @Resource
    CommentService commentService;

    @Resource
    AuditService auditService;

    @PostMapping("/add")
    public Result save(@RequestBody Blog blog){
        if(blog.getId()==null){
            User currUser= JwtTokenUtils.getCurrentUser();
            blog.setUser_id(currUser.getUser_id());

            blogService.add(blog);

            Audit audit=new Audit();
            List<Blog> newBlog=blogService.findByState();
            Blog blog1=newBlog.get(newBlog.size()-1);
            audit.setBlog_id(blog1.getId());
            audit.setAudit_content("未审核");
            auditService.add(audit);
//            for(Blog item:newBlog){
//                audit.setBlog_id(item.getId());
//                audit.setAudit_content("未审核");
//                auditService.add(audit);
//            }
        }
        else {
            blogService.update(blog);
//            System.out.println(blog.getState());
            if(blog.getState().equals("-1")){
                Audit audit=auditService.findByBlogId(blog.getId());
                if(audit==null){
                    Audit audit1=new Audit();
                    audit1.setBlog_id(blog.getId());
                    audit1.setAudit_content("未审核");
                    auditService.add(audit1);
                }else {
                    audit.setAudit_content("未审核");
                    auditService.update(audit);
                }
            }
        }
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id){
        likeService.delByBolgId(id);
        commentService.delByBolgId(id);
        blogService.delete(id);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params){
        PageInfo<Blog> list=blogService.findBySearch(params);
        List<PeopleLike> likeData = likeService.findAllBlogLike();

        for(int i=0;i<list.getList().size();++i){
            for(int j=0;j<likeData.size();++j){
                if(list.getList().get(i).getId()==likeData.get(j).getBlog_id()){
                    list.getList().get(i).setLikeNum(likeData.get(j).getLikeNum());
                }
            }
        }
        return Result.success(list);
    }

    @GetMapping("/hotSearch")
    public Result findHot(Params params){
        PageInfo<Blog> list=blogService.findHot(params);
        List<PeopleLike> likeData = likeService.findAllBlogLike();

        for(int i=0;i<list.getList().size();++i){
            for(int j=0;j<likeData.size();++j){
                if(list.getList().get(i).getId()==likeData.get(j).getBlog_id()){
                    list.getList().get(i).setLikeNum(likeData.get(j).getLikeNum());
                }
            }
        }
        return Result.success(list);
    }

    @GetMapping("/searchLike")
    public Result findBySearchLike(Params params){
        PageInfo<Blog> list=blogService.findBySearchLike(params);
        List<PeopleLike> likeData = likeService.findAllBlogLike();

        for(int i=0;i<list.getList().size();++i){
            for(int j=0;j<likeData.size();++j){
                if(list.getList().get(i).getId()==likeData.get(j).getBlog_id()){
                    list.getList().get(i).setLikeNum(likeData.get(j).getLikeNum());
                }
            }
        }
        return Result.success(list);
    }

    @GetMapping("/searchCollect")
    public Result findBySearchCollect(Params params){
        PageInfo<Blog> list=blogService.findBySearchCollect(params);
        List<PeopleLike> likeData = likeService.findAllBlogLike();

        for(int i=0;i<list.getList().size();++i){
            for(int j=0;j<likeData.size();++j){
                if(list.getList().get(i).getId()==likeData.get(j).getBlog_id()){
                    list.getList().get(i).setLikeNum(likeData.get(j).getLikeNum());
                }
            }
        }
        return Result.success(list);
    }

    @GetMapping("/searchMyComment")
    public Result findBySearchMyComment(Params params){
        PageInfo<Blog> list=blogService.findBySearchMyComment(params);
        List<PeopleLike> likeData = likeService.findAllBlogLike();
        for(int i=0;i<list.getList().size();++i){
            for(int j=0;j<likeData.size();++j){
                if(list.getList().get(i).getId()==likeData.get(j).getBlog_id()){
                    list.getList().get(i).setLikeNum(likeData.get(j).getLikeNum());
                }
            }
        }

        return Result.success(list);
    }

    @GetMapping("/findById/{id}")
    public Result findById(@PathVariable Integer id){
        Blog currBlog=blogService.findById(id);
        return Result.success(currBlog);
    }

    @PutMapping("/delBatch")
    public Result delBatch(@RequestBody List<Blog> list){
        for(Blog blog:list){
            blogService.delete(blog.getId());
        }
        return Result.success();
    }

    @PostMapping("/addRead/{id}")
    public Result addReadCount(@PathVariable Integer id){
        Blog currBlog=blogService.findById(id);
        List<PeopleLike> likeData = likeService.findAllBlogLike();
        int likeNum=0;
        for(PeopleLike peolike:likeData){
            if(id==peolike.getBlog_id()){
                likeNum=Integer.parseInt(peolike.getLikeNum());
            }
        }
        int getCount=currBlog.getRead_count();
        ++getCount;
        currBlog.setRead_count(getCount);
        int ceilNumber = (int) Math.ceil(getCount*0.8+likeNum*0.2);
        currBlog.setPeople_like(ceilNumber);
        blogService.update(currBlog);
        return Result.success();
    }

    @GetMapping("/findDayNum")
    public Result findDayNum(){
        List<Blog> list=blogService.findDayNum();
        return Result.success(list);
    }

    @GetMapping("/findDayBrand")
    public Result findDayBrand(){
        List<Blog> list=blogService.findDayBrand();
        List<Map<String,Object>> mapList=new ArrayList<>();
        if(CollectionUtil.isNotEmpty(list)){
            for(Blog blog:list){
                Map<String,Object> map=new HashMap<>();
                map.put("name",blog.getCategoryName());
                map.put("value",blog.getDayNum());
                mapList.add(map);
            }
        }
        return Result.success(mapList);
    }

    public List findTagsNum(Integer type){
        List<Blog> list=blogService.findTags();
        List<Map<String, Object>> mapList = new ArrayList<>();
        if(CollectionUtil.isNotEmpty(list)) {
            String tagName[] = {"篮球鞋", "足球鞋", "休闲鞋", "通勤鞋"};
            int tagValue[] = {0, 0, 0, 0};
            for (Blog item : list) {
                String s1 = item.getTags().replace("\"", "");
                String s2 = s1.replace("]", "");
                String s3 = s2.replace("[", "");
                String[] splitStrings = s3.split(",");
                for (int i = 0; i < splitStrings.length; ++i) {
                    for (int j = 0; j < tagName.length; ++j) {
                        if (splitStrings[i].equals(tagName[j])) {
                            if(type==0){
                                tagValue[j]++;
                            }
                            else{
                                tagValue[j]+=item.getRead_count();
                            }
                        }
                    }
                }
            }
            for(int i=0;i<tagName.length;i++){
                Map<String,Object> map=new HashMap<>();
                map.put("name",tagName[i]);
                map.put("value",tagValue[i]);
                mapList.add(map);
            }
        }
        return mapList;
    }

    @GetMapping("/findTags/{type}")
    public Result findTags(@PathVariable Integer type){
        return Result.success(findTagsNum(type));
    }

    @GetMapping("/findAllBrand")
    public Result findAllBrand(){
        List<Blog> list=blogService.findAllBrand();
        return Result.success(list);
    }
}
