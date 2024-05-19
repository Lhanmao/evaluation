package com.evaluation_system.web.exception;

/**
 * 用户异常处理类
 */
public class CustomException extends RuntimeException{
    private String msg;

    public CustomException(String msg){
        this.msg=msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
