package com.huoping.crm.workbench.controller;

import com.huoping.crm.setting.pojo.User;
import com.huoping.crm.setting.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ActivityController {
    @Autowired
    private UserService userService;

    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request) {
        List<User> acitityUserNames = userService.getAcitityUserNames();
        request.setAttribute("usersName", acitityUserNames);
        return "workbench/activity/index";
    }
}
