package com.huoping.crm.shared;

public class MsgData {
    private String code;
    private String message;
    private Object obj;

    public String getCode() {
        return code;
    }

    public MsgData() {
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
        return "MsgData{" +
                "code='" + code + '\'' +
                ", message='" + message + '\'' +
                ", obj=" + obj +
                '}';
    }

    public MsgData(String code, String message, Object obj) {
        this.code = code;
        this.message = message;
        this.obj = obj;
    }
}
