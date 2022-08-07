package com.huoping.crm.setting.service;

import com.huoping.crm.setting.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User getUserByActAndByPwd(Map<String, Object> map);

    List<User> getAcitityUserNames();

}
