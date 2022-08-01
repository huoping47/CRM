package com.huoping.crm.setting.service;

import com.huoping.crm.setting.pojo.User;

import java.util.Map;

public interface UserService {
    User getUserByActAndByPwd(Map<String, Object> map);
}
