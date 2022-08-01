package com.huoping.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class indexController {
    //如果域名是  https:127.0.0.1:8080/crm/  那么可以省略不写  '/'就是代表https:127.0.0.1:8080/crm/的根路径
    @RequestMapping("/")
    public String index() {
        //请求转发
        return "index";
    }
}
