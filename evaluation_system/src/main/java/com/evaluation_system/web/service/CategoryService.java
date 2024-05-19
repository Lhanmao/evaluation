package com.evaluation_system.web.service;

import com.evaluation_system.web.dao.CategoryDao;
import com.evaluation_system.web.entity.Category;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CategoryService {
    @Resource
    CategoryDao categoryDao;

    public void add(Category category) {
        if(category.getName()==null || "".equals(category.getName())){
            throw new CustomException("目录名不能为空");
        }
        //重复性判断
        Category haveCate=categoryDao.findByName(category.getName());
        if(haveCate!=null){
            //如果已经有了该目录名
            throw new CustomException("该目录已存在，请勿重复添加");
        }
        categoryDao.insertSelective(category);
    }

    public void update(Category category) {
        categoryDao.updateByPrimaryKeySelective(category);
    }

    public void delete(Integer id) {
        categoryDao.deleteByPrimaryKey(id);
    }

    public PageInfo<Category> findBySearch(Params params) {
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<Category> list=categoryDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    public List<Category> findAll() {
        return categoryDao.selectAll();
    }
}
