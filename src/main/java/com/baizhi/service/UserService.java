package com.baizhi.service;


import com.baizhi.dto.UserMapDto;

import java.util.List;

public interface UserService {
    //根据省份查询(地图)
    public List<UserMapDto> queryMap();

    //根据时间查询(折线图)
    public List<Integer> query();
}
