package com.baizhi.mapper;

import com.baizhi.entity.Chapter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChapterMapper {
    //根据页号查询
    public List<Chapter> findAll(@Param("start") Integer start, @Param("rows") Integer rows, @Param("albumid") String albumid);

    //查所有条数
    public Integer count(@Param("albumid") String albumid);

    //增
    public void save(Chapter chapter);

    //删
    public void delete(String[] id);

    //改
    public void update(Chapter chapter);


    //修改音频路径
    public void updatefilePath(Chapter chapter);

}
