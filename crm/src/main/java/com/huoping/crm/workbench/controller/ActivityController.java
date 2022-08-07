package com.huoping.crm.workbench.controller;

import com.huoping.crm.setting.pojo.User;
import com.huoping.crm.setting.service.UserService;
import com.huoping.crm.shared.MsgData;
import com.huoping.crm.shared.untils.DateTimeUntil;
import com.huoping.crm.shared.untils.StaticDataUntil;
import com.huoping.crm.shared.untils.UUIDUntil;
import com.huoping.crm.workbench.entity.TblActivity;
import com.huoping.crm.workbench.service.TblActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class ActivityController {
    @Autowired
    private UserService userService;

    @Autowired
    private TblActivityService tblActivityService;

    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request) {
        List<User> acitityUserNames = userService.getAcitityUserNames();
        request.setAttribute("usersName", acitityUserNames);
        List<TblActivity> tblActivities = tblActivityService.selectActivityList();
        request.setAttribute("tblActivities", tblActivities);
        return "workbench/activity/index";
    }


    @RequestMapping("/workbench/activity/insertActivityData.do")
    @ResponseBody
    public Object insertAcitityData(TblActivity tblActivity, HttpSession session) {
        System.out.println("进入了这里");
        tblActivity.setId(UUIDUntil.getUUID());
        User user = (User) session.getAttribute(StaticDataUntil.SESSION_USER_USERNAME);
        tblActivity.setCreateby(user.getId());
        tblActivity.setCreatetime(DateTimeUntil.TimeForMatString(new Date()));
        MsgData msgData = new MsgData();
        try {
            int result = tblActivityService.insertAcitityData(tblActivity);
            if (result <= 0) {
                msgData.setCode("0");
                msgData.setMessage("不好意思,服务器较忙");
            } else {
                msgData.setCode("1");
            }
        } catch (Exception e) {
            msgData.setCode("0");
            msgData.setMessage("不好意思,服务器较忙");
            e.printStackTrace();
        }
        return msgData;
    }
}
