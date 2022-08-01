package com.huoping.crm.setting.web.controller;

import com.huoping.crm.setting.pojo.User;
import com.huoping.crm.setting.service.UserService;
import com.huoping.crm.shared.UserLoginMsgData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
//@RestController  本类全部都是ajax可以写这个注解
public class UserController {
    @Autowired
    UserService userService;

    //根据这个路径提供相对应的登录页面
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }


    @RequestMapping("/settings/qx/user/login.do")
    @ResponseBody
    public Object login(String loginact, String loginpwd, String isRemPwd, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginact);
        map.put("loginPwd", loginpwd);
        User user = userService.getUserByActAndByPwd(map);
        UserLoginMsgData userLoginMsgData = new UserLoginMsgData();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String date = sdf.format(new Date());
        if (user == null) {
            //登录失败/用户名或者密码错误
            userLoginMsgData.setCode("0");
            userLoginMsgData.setMessage("<span style='color: red'>用户名或者密码错误</span>");
        } else if ("0".equals(user.getLockstate())) {
            //登录失败,账号状态不正确
            userLoginMsgData.setCode("0");
            userLoginMsgData.setMessage("<span style='color: red'>账号状态不正确</span>");
        } else if (request.getRemoteAddr().contains(user.getAllowips())) {
            //登录失败,IP地址不支持
            userLoginMsgData.setCode("0");
            userLoginMsgData.setMessage("<span style='color: red'>IP地址不支持</span>");
        } else if (date.compareTo(user.getExpiretime()) > 0) {
            //登录失败,您的账号以过期
            userLoginMsgData.setCode("0");
            userLoginMsgData.setMessage("<span style='color: red'>您的账号以过期</span>");
        } else {
            userLoginMsgData.setCode("1");
            userLoginMsgData.setMessage("欢迎回来");
        }
        return userLoginMsgData;
    }
}
