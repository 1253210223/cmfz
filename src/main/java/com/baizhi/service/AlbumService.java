package com.baizhi.service;


import com.baizhi.entity.Album;

import java.util.Map;

public interface AlbumService {
    //根据页号查询
    public Map<String, Object> findAll(Integer page, Integer rows);

    //修改图片路径
    public void updatecover(String id, String cover);

    //增 删 改
    public String edit(Album album, String oper, String[] id);
}
