//package com.evaluation_system.web.controller;
//
//import com.evaluation_system.web.common.Result;
//import com.google.code.kaptcha.Producer;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.redis.core.StringRedisTemplate;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import javax.imageio.ImageIO;
//import javax.servlet.ServletOutputStream;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.awt.image.BufferedImage;
//import java.io.IOException;
//import java.util.concurrent.TimeUnit;
//
//@CrossOrigin
//@RestController
//@RequestMapping("/captcha")
//@Slf4j
//public class CaptchaController1 {
//
//    @Autowired(required = false)
//    private StringRedisTemplate redisTemplate;
//
//    @Autowired
//    private Producer captchaProducer;
//
//    /**
//     * 设置过期时间10min
//     */
//    private static final long CAPTCHA_CODE_EXPIRED = 60 * 1000;
//
//    /**
//     * 获取图形验证码
//     * @param request
//     * @param response
//     */
//    @GetMapping("/get_captcha")
//    public Result getCaptcha(HttpServletRequest request, HttpServletResponse response){
//        //创建验证码内容
//        String captchaText = captchaProducer.createText();
//        log.info("图形验证码内容为：{}",captchaText);
//
//        redisTemplate.opsForValue().set(getCaptchaKey(request),captchaText,CAPTCHA_CODE_EXPIRED, TimeUnit.MILLISECONDS);
//        //生成图片
//        BufferedImage captchaImage = captchaProducer.createImage(captchaText);
//        try(ServletOutputStream outputStream = response.getOutputStream()){
//            ImageIO.write(captchaImage,"jpg",outputStream);
//        }catch (IOException e){
//            log.error("获取流出错："+e.getMessage());
//        }
//        return Result.success();
//    }
//
//    /**
//     * 获取图形验证码的缓存key
//     * @param request
//     * @return
//     */
//    private String getCaptchaKey(HttpServletRequest request) {
//        String userAgent = request.getHeader("User-Agent");
//        return "account:captcha:"+ userAgent;
//    }
//
//}
