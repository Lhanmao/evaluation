package com.evaluation_system.web.common.log;

import java.lang.annotation.*;

/**
 * 自定义日志信息记录注释
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AutoLog {
    String value() default "";
}
