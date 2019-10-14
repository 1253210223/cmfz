package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.Map;

public interface ChapterService {
    //根据页号查询
    public Map<String, Object> findAll(Integer page, Integer rows, String albumid);


    //删 增 改
    public String edit(Chapter chapter, String oper, String[] id, String albumid);

    //改音频路径
    public void updatefilePath(Chapter chapter);

}
