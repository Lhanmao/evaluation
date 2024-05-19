package com.evaluation_system.web.common.log;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.evaluation_system.web.common.JwtTokenUtils;
import com.evaluation_system.web.common.Result;
import com.evaluation_system.web.entity.User;
import com.evaluation_system.web.entity.UserLog;
import com.evaluation_system.web.service.UserLogService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Component
@Aspect
public class LogAspect {
    @Resource
    private UserLogService userLogService;

    @Around("@annotation(autoLog)")
    public Object doAround(ProceedingJoinPoint joinPoint,AutoLog autoLog) throws Throwable{
        //操作内容
        String name=autoLog.value();

        //操作时间
        String time=DateUtil.now();

        //操作人
        String username="";
//        User user= JwtTokenUtils.getCurrentUser();
//        if(user!=null){
//            username=user.getUser_name();
//        }

        //ip
        HttpServletRequest request=((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//        assert request!=null;
        String ip=request.getRemoteAddr();

        //执行方法
        Result result=(Result) joinPoint.proceed();
        if(ObjectUtil.isNotNull(result.getData())){
            if(result.getData() instanceof User){
                username=((User)result.getData()).getUser_name();
            }
        }

        //保存到数据库
        UserLog userLog=new UserLog(null,name, time,username,ip);
        userLogService.add(userLog);

        return result;
    }
}
