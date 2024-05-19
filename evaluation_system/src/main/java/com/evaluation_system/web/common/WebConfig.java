package com.evaluation_system.web.common;

import cn.hutool.core.util.StrUtil;
import com.evaluation_system.web.entity.User;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;

/**
 * 路由拦截接口类
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Resource
    private JwtInterceptor jwtInterceptor;

    @Override
    public void configurePathMatch(PathMatchConfigurer configurer){
        //指定controller统一接口前缀,相当于在url上拼了一个/api前缀
        configurer.addPathPrefix("/api",clazz->clazz.isAnnotationPresent(RestController.class));
    }

    //加自定义拦截器JwtInterceptor，设置拦截规则
    @Override
    public void addInterceptors(InterceptorRegistry registry){
        //需要放行的页面
        registry.addInterceptor(jwtInterceptor).addPathPatterns("/api/**")
                .excludePathPatterns("/api/login")
                .excludePathPatterns("/api/regist")
                .excludePathPatterns("/api/files/**")
                .excludePathPatterns("/api/user/inport")
                .excludePathPatterns("/api/captcha")
                .excludePathPatterns("/api/systemUser/echarts/bar")
                .excludePathPatterns("/api/rePwd")
                .excludePathPatterns("/api/blog/**")
                .excludePathPatterns("/api/peoplelike/*")
                ;//.excludePathPatterns("/api/user/export")

    }
}
