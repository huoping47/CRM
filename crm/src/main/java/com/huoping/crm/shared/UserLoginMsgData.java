package com.huoping.crm.shared;

public class UserLoginMsgData {
    private String code;
    private String message;
    private Object obj;

    public String getCode() {
        return code;
    }

    public UserLoginMsgData() {
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    @Override
    public String toString() {
        return "UserLoginMsgData{" +
                "code='" + code + '\'' +
                ", message='" + message + '\'' +
                ", obj=" + obj +
                '}';
    }

    public UserLoginMsgData(String code, String message, Object obj) {
        this.code = code;
        this.message = message;
        this.obj = obj;
    }
}
