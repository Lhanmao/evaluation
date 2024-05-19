package com.evaluation_system.web.common;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.exception.CustomException;
import com.evaluation_system.web.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * jwt拦截器
 */
@Component
public class JwtInterceptor implements HandlerInterceptor {
    private static final Logger log= LoggerFactory.getLogger(JwtInterceptor.class);

    @Resource
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handler){
        //1、从http请求的header中获取token
        String token=request.getHeader("token");
        if(StrUtil.isBlank(token)){
            //如果没有，再去url参数获取试试
            token=request.getParameter("token");
        }
        //2、开始执行认证
        if(StrUtil.isBlank(token)){
            throw new CustomException("无token，请重新登录");
        }
        //获取token中的userId
        String userId;
        User user;
        try{
            userId= JWT.decode(token).getAudience().get(0);
            //根据token中的userId查询数据库
            user=userService.findById(Integer.parseInt(userId));
        }catch (Exception e){
            String errMsg="token验证失败，请重新登录";
            log.error(errMsg+",token="+token,e);
            throw new CustomException(errMsg);
        }
        if(user==null){
            throw new CustomException("用户不存在,请重新登录");
        }
        try{
            //用户密码加签名验证token
            JWTVerifier jwtVerifier=JWT.require(Algorithm.HMAC256(user.getPassword())).build();
            jwtVerifier.verify(token);//验证token
        }catch (JWTVerificationException e){
            throw new CustomException("token验证失败，请重新登录");
        }
//        log.info("允许放行");
        return true;
    }
}
