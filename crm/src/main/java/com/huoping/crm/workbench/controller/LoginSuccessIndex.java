package com.huoping.crm.workbench.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 登录成功的页面
 */
@Controller
public class LoginSuccessIndex {
    @RequestMapping("/workbench/LoginSuccessIndex.do")
    public String LoginSuccessIndex() {
        return "workbench/index";
    }
}
