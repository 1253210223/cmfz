package com.baizhi.controller;


import com.baizhi.dto.UserMapDto;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@RequestMapping("/user")
@RestController
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("/query")
    public List<Integer> query(Date userTime) {
        List<Integer> query = userService.query();
        return query;

    }

    @RequestMapping("/queryMap")
    public List<UserMapDto> queryMap() {
        List<UserMapDto> users = userService.queryMap();
        return users;
    }

}
