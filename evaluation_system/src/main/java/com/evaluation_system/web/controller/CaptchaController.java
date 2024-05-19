package com.evaluation_system.web.controller;

import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.common.captcha.GetCaptcha;
import com.wf.captcha.ArithmeticCaptcha;
import com.wf.captcha.SpecCaptcha;
import com.wf.captcha.base.Captcha;
import com.wf.captcha.utils.CaptchaUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@CrossOrigin
@RestController
@RequestMapping
public class CaptchaController {

    @Autowired(required = false)
    private StringRedisTemplate redisTemplate;

    @RequestMapping("/captcha")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception{
        //png类型
        //设置验证码的长宽、个数
        SpecCaptcha captcha=new SpecCaptcha(135,33,4);
        captcha.setCharType(Captcha.TYPE_NUM_AND_UPPER);

        //将验证码存入redis
        String codeKey=getCaptchaKey(request);
        redisTemplate.opsForValue().set(codeKey,captcha.text().toLowerCase());
        //将key值存起来，方便其他方法调用
        GetCaptcha.captchaKey=codeKey;

        CaptchaUtil.out(captcha,request,response);

//        //算数类型
//        ArithmeticCaptcha captcha1=new ArithmeticCaptcha(135,33);
//        captcha1.setLen(4);//设置几位数的运算
//        captcha1.getArithmeticString();//获取运算的公式
//        captcha1.text();
//        CaptchaUtil.out(captcha1,request,response);
    }

    /**
     * 获取图形验证码的缓存key
     * @param request
     * @return
     */
    private String getCaptchaKey(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        return "account:captcha:"+ userAgent;
    }

}
