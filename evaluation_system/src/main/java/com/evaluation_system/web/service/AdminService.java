//package com.evaluation_system.web.service;
//
//import com.evaluation_system.web.common.JwtTokenUtils;
//import com.evaluation_system.web.dao.AdminDao;
//import com.evaluation_system.web.entity.Admin;
//import com.evaluation_system.web.entity.Params;
//import com.evaluation_system.web.exception.CustomException;
//import com.github.pagehelper.Page;
//import com.github.pagehelper.PageHelper;
//import com.github.pagehelper.PageInfo;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import javax.annotation.Resource;
//import java.util.List;
//
//@Service
//public class AdminService {
//    @Resource
//    private AdminDao adminDao;
//
////    public List<Admin> getUser() {
////        return adminDao.getUser();
////        使用tk.mybatis包里的方法
////        return userDao.selectAll();
////    }
//
//    //新增功能
//    public void add(Admin admin){
//        //用户名不能为空
//        if(admin.getName()==null || "".equals(admin.getName())){
//            throw new CustomException("用户名不能为空");
//        }
//        //重复性判断
//        Admin user=adminDao.findByName(admin.getName());
//        if(user!=null){
//            //如果已经有了该用户名
//            throw new CustomException("该用户名已存在，请勿重复添加");
//        }
//        //初始化密码
//        if(admin.getPassword()==null){
//            admin.setPassword("123456");
//        }
//        adminDao.insertSelective(admin);
//    }
//
//    public PageInfo<Admin> findBySearch(Params params){
//        //开启分页查询
//        PageHelper.startPage(params.getPageNum(),params.getPageSize());
//        List<Admin> list=adminDao.findBySearch(params);
//        //此时必须返回含分页参数的数据
//        return PageInfo.of(list);
//    }
//
//    //更新功能
//    public void update(Admin admin) {
//        adminDao.updateByPrimaryKeySelective(admin);
//    }
//
//    //删除功能
//    public void delete(Integer id) {
//        adminDao.deleteByPrimaryKey(id);
//    }
//
//    public Admin login(Admin admin) {
//        // 1、进行非空判断
//        if(admin.getName()==null || "".equals(admin.getName())){
//            throw new CustomException("用户名不能为空");
//        }
//        if(admin.getPassword()==null || "".equals(admin.getPassword())){
//            throw new CustomException("密码不能为空");
//        }
//        // 2、进行数据库数据匹配
//        Admin user=adminDao.findByNameAndPassword(admin.getName(),admin.getPassword());
//        if(user == null){
//            throw new CustomException("用户名或者密码输入错误");
//        }
//
//        //生成登录用户对应的token,然后跟着user一起返回前端
//        String token=JwtTokenUtils.getToken(user.getId().toString(),user.getPassword());
//        user.setToken(token);
//        return user;
//    }
//
//    //注册功能
//    public void regist(Admin admin){
//        //用户名不能为空
//        if(admin.getName()==null || "".equals(admin.getName())){
//            throw new CustomException("用户名不能为空");
//        }
//        if(admin.getPassword()==null || "".equals(admin.getPassword())){
//            throw new CustomException("密码不能为空");
//        }
//        if(admin.getAge()==null || "".equals(admin.getAge())){
//            throw new CustomException("年龄不能为空");
//        }
//        if(admin.getPhone()==null || "".equals(admin.getPhone())){
//            throw new CustomException("手机号不能为空");
//        }
//        //重复性判断
//        Admin user=adminDao.findByName(admin.getName());
//        if(user!=null){
//            //如果已经有了该用户名
//            throw new CustomException("该用户名已存在，请重新命名");
//        }
//        adminDao.insertSelective(admin);
//    }
//
//    public Admin findById(Integer id) {
//        return adminDao.selectByPrimaryKey(id);
//    }
//}
