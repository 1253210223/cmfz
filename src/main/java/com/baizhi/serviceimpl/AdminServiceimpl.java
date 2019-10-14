package com.baizhi.serviceimpl;

import com.baizhi.entity.Admin;
import com.baizhi.mapper.AdminMapper;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Transactional
@Service
public class AdminServiceimpl implements AdminService {

    @Autowired
    AdminMapper adminMapper;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Admin adminlogin(String username) {


        Admin admin = adminMapper.adminlogin(username);
        return admin;
    }

}
