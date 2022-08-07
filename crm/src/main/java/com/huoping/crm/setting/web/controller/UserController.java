package com.huoping.crm.setting.web.controller;

import com.huoping.crm.setting.pojo.User;
import com.huoping.crm.setting.service.UserService;
import com.huoping.crm.shared.MsgData;
import com.huoping.crm.shared.untils.DateTimeUntil;
import com.huoping.crm.shared.untils.StaticDataUntil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
    public Object login(String loginact, String loginpwd, String isRemPwd, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginact);
        map.put("loginPwd", loginpwd);
        User user = userService.getUserByActAndByPwd(map);
        MsgData msgData = new MsgData();
        String date = DateTimeUntil.DateTimeForMatString(new Date());
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        if (user == null) {
            //登录失败/用户名或者密码错误
            msgData.setCode(StaticDataUntil.RETURN_CODE_ERROR);
            msgData.setMessage("<span style='color: red'>用户名或者密码错误</span>");
        } else if ("0".equals(user.getLockstate())) {
            //登录失败,账号状态不正确
            msgData.setCode(StaticDataUntil.RETURN_CODE_ERROR);
            msgData.setMessage("<span style='color: red'>账号状态不正确</span>");
        } else if (request.getRemoteAddr().contains(user.getAllowips())) {
            //登录失败,IP地址不支持
            msgData.setCode(StaticDataUntil.RETURN_CODE_ERROR);
            msgData.setMessage("<span style='color: red'>IP地址不支持</span>");
        } else if (date.compareTo(user.getExpiretime()) > 0) {
            //登录失败,您的账号以过期
            msgData.setCode(StaticDataUntil.RETURN_CODE_ERROR);
            msgData.setMessage("<span style='color: red'>您的账号以过期</span>");
        } else {
            //登录成功,将用户的数据存入session中,主页展示登录用户的信息
            msgData.setCode(StaticDataUntil.RETURN_CODE_SUCCESS);
            session.setAttribute(StaticDataUntil.SESSION_USER_USERNAME, user);
            //实现记住密码,往cookie中存储数据
            if ("true".equals(isRemPwd)) {
                Cookie loginActCookie = new Cookie("loginAct", loginact);
                Cookie loginPwdCookie = new Cookie("loginPwd", loginpwd);
                loginActCookie.setMaxAge(10 * 24 * 60 * 60);
                loginPwdCookie.setMaxAge(10 * 27 * 60 * 60);
                loginActCookie.setPath("/");
                loginPwdCookie.setPath("/");
                response.addCookie(loginActCookie);
                response.addCookie(loginPwdCookie);
            }
        }
        return msgData;
    }


    /**
     * 确定退出业务
     *
     * @param session
     * @return
     */
    @RequestMapping("/setting/qx/user/ExitLogin.do")
    public String ExitLogin(HttpServletResponse response, HttpSession session) {
        Cookie c = new Cookie("loginAct", "A");
        Cookie c1 = new Cookie("loginPwd", "A");
        c.setPath("/");
        c1.setPath("/");
        c.setMaxAge(0);
        c1.setMaxAge(0);
        response.addCookie(c1);
        response.addCookie(c);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }
}
