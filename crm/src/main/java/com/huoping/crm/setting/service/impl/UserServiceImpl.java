package com.huoping.crm.setting.service.impl;

import com.huoping.crm.setting.mapper.UserMapper;
import com.huoping.crm.setting.pojo.User;
import com.huoping.crm.setting.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;

    @Override
    public User getUserByActAndByPwd(Map<String, Object> map) {
        return userMapper.getUserByActAndByPwd(map);
    }

    @Override
    public List<User> getAcitityUserNames() {
        return userMapper.getAcitityUserNames();
    }
}
