package com.evaluation_system.web.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import com.evaluation_system.web.common.JwtTokenUtils;
import com.evaluation_system.web.common.captcha.GetCaptcha;
import com.evaluation_system.web.dao.UserDao;
import com.evaluation_system.web.entity.Params;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.exception.CustomException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

@Service
public class UserService {

    @Autowired(required = false)
    private StringRedisTemplate redisTemplate;

    @Resource
    private UserDao userDao;

//    public List<Admin> getUser() {
//        return adminDao.getUser();
//        使用tk.mybatis包里的方法
//        return userDao.selectAll();
//    }

    //新增功能
    public void add(User user){
        //用户名不能为空
        if(user.getUser_name()==null || "".equals(user.getUser_name())){
            throw new CustomException("用户名不能为空");
        }
        //重复性判断
        User haveUser=userDao.findByName(user.getUser_name());
        if(haveUser!=null){
            //如果已经有了该用户名
            throw new CustomException("该用户名已存在，请勿重复添加");
        }
        //初始化密码
        if(user.getPassword()==null){
            user.setPassword("123456");
        }

        Date currentDate=DateUtil.date();
        user.setCreate_date(DateUtil.formatDate(currentDate));

        userDao.insertSelective(user);
    }

    public PageInfo<User> findBySearch(Params params){
        //开启分页查询
        PageHelper.startPage(params.getPageNum(),params.getPageSize());
        List<User> list=userDao.findBySearch(params);
        //此时必须返回含分页参数的数据
        return PageInfo.of(list);
    }

    //更新功能
    public void update(User user) {
        if(user.getNick_name()==null||"".equals(user.getNick_name())){
            throw new CustomException("昵称不能为空");
        }
        if(user.getPhone()==null || "".equals(user.getPhone())){
            throw new CustomException("电话号码不能为空");
        }
        //更新修改信息的时间
        user.setUpdate_time(DateUtil.now());

        userDao.updateByPrimaryKeySelective(user);
    }

    //删除功能
    public void delete(Integer id) {
        userDao.deleteByPrimaryKey(id);
    }

    public User login(User user) {
        // 1、进行非空判断
        if(user.getUser_name()==null || "".equals(user.getUser_name())){
            throw new CustomException("用户名不能为空");
        }
        if(user.getPassword()==null || "".equals(user.getPassword())){
            throw new CustomException("密码不能为空");
        }
        // 2、进行数据库数据匹配
        User haveUser=userDao.findByNameAndPassword(user.getUser_name(),user.getPassword());
        if(haveUser == null){
            throw new CustomException("用户名或者密码输入错误");
        }

        String verCode=redisTemplate.boundValueOps(GetCaptcha.captchaKey).get();
        if(!user.getVerCode().toLowerCase().equals(verCode)){
            throw new CustomException("验证码错误");
        }
        redisTemplate.delete(GetCaptcha.captchaKey);

        //生成登录用户对应的token,然后跟着user一起返回前端
        String token= JwtTokenUtils.getToken(haveUser.getUser_id().toString(),haveUser.getPassword());
        haveUser.setToken(token);

        //更新登录时间
        haveUser.setLogin_date(DateUtil.now());
        update(haveUser);
        return haveUser;
    }

    //注册功能
    public void regist(User user){
        Pattern PHONE_PATTERN = Pattern.compile("^1[3-9]\\d{9}$");//手机号码验证
        String regex = "\\S{6,}";
        //用户注册必要信息非空判断
        if(user.getUser_name()==null || "".equals(user.getUser_name())){
            throw new CustomException("用户名不能为空");
        }
        if(user.getPassword()==null || "".equals(user.getPassword())){
            throw new CustomException("密码不能为空");
        }else{
            if(!user.getPassword().matches(regex)){
                throw new CustomException("密码长度不少于6位");
            }
        }
        if(user.getAge()==null || "".equals(user.getAge())){
            throw new CustomException("年龄不能为空");
        }
        if(user.getPhone()==null || "".equals(user.getPhone())){
            throw new CustomException("手机号不能为空");
        }else{
            if(!PHONE_PATTERN.matcher(user.getPhone()).matches()){
                throw new CustomException("请输入正确手机号");
            }
        }
        if(user.getUser_type()==null){
            user.setUser_type("用户");
        }
        //重复性判断
        User haveUser=userDao.findByName(user.getUser_name());
        if(haveUser!=null){
            //如果已经有了该用户名
            throw new CustomException("该用户名已存在，请重新命名");
        }

        //添加用户创建时间
        Date currentDate=DateUtil.date();
        user.setCreate_date(DateUtil.formatDate(currentDate));

        //添加注册用户的默认昵称和图片
        String tile= RandomUtil.randomString(6);
        user.setNick_name("小白鞋_"+tile);
        user.setAvatar("1709812514131");

        userDao.insertSelective(user);
    }

    public User findById(Integer id) {
        return userDao.selectByPrimaryKey(id);
    }

    public List<User> findAll() {
        return userDao.selectAll();
    }

    public List<User> findUserNum() {
        return userDao.findUserNum();
    }

    public void repwd(User user) {
        String regex = "\\S{6,}";
        // 1、进行非空判断
        if(user.getUser_name()==null || "".equals(user.getUser_name())){
            throw new CustomException("用户名不能为空");
        }
        if(user.getPhone()==null || "".equals(user.getPhone())){
            throw new CustomException("手机号码不能为空");
        }
        if(user.getPassword()==null || "".equals(user.getPassword())){
            throw new CustomException("密码不能为空");
        }else{
            if(!user.getPassword().matches(regex)){
                throw new CustomException("密码长度不少于6位");
            }
        }

        // 2、进行数据库数据匹配
        User haveUser=userDao.findByNameAndPhone(user.getUser_name(),user.getPhone());
        if(haveUser == null){
            throw new CustomException("用户名或者手机号码输入错误");
        }
        haveUser.setPassword(user.getPassword());
        update(haveUser);
    }

    public List<User> findUserDayNew() {
        return userDao.findUserDayNew();
    }

    public List<User> findGenderDayNew() {
        return userDao.findGenderDayNew();
    }
}
