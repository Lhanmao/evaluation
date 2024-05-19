package com.evaluation_system.web.common;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
//import com.evaluation_system.web.entity.Admin;
//import com.evaluation_system.web.service.AdminService;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 用户token生成工具类
 */
@Component
public class JwtTokenUtils {
    private static UserService staticUserService;
    private static final Logger log= LoggerFactory.getLogger(JwtTokenUtils.class);

    @Resource
    private UserService userService;

    @PostConstruct
    public void setUserService(){
        staticUserService=userService;
    }

    /**
     * 生成token
     */
    public static String getToken(String adminId,String sign){
        return JWT.create().withAudience(adminId)//将user id保存到token里面，作为载荷
                .withExpiresAt(DateUtil.offsetHour(new Date(),2))//2个小时后，token过期
                .sign(Algorithm.HMAC256(sign));//以password作为token的密钥
    }

    /**
     * 获取当前登录的用户信息
     */
    public static User getCurrentUser(){
        String token=null;
        try{
            HttpServletRequest request=((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            token=request.getHeader("token");
            if(StrUtil.isBlank(token)){
                token= request.getParameter("token");
            }
            if(StrUtil.isBlank(token)){
                log.error("获取当前登录的token失败，token: {}",token);
                return null;
            }
            //解析token，获取用户的id
            String adminId=JWT.decode(token).getAudience().get(0);
            return staticUserService.findById(Integer.valueOf(adminId));
        }catch (Exception e){
            log.error("获取当前登录的管理员信息失败，token={}",token,e);
            return null;
        }
    }
}
