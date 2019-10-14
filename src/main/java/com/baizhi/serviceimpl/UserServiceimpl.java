package com.baizhi.serviceimpl;


import com.baizhi.dto.UserMapDto;
import com.baizhi.mapper.UserMapper;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceimpl implements UserService {
    @Autowired
    UserMapper userMapper;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<UserMapDto> queryMap() {
        List<UserMapDto> users = userMapper.queryMap();
        return users;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)
    public List<Integer> query() {
        List<Integer> query = userMapper.query();
        return query;
    }
}
