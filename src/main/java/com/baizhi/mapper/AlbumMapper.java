package com.baizhi.mapper;

import com.baizhi.entity.Album;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumMapper {
    //根据页号查询
    public List<Album> findAll(@Param("start") Integer start, @Param("rows") Integer rows);

    //查询总条数
    public Integer count();

    //修改图片路径
    public void updatecover(@Param("id") String id, @Param("cover") String cover);

    //增
    public void save(Album album);

    //删
    public void delete(String[] id);

    public void delete1(String[] id);

    //改
    public void update(Album album);

    //改数量
    public void updateCount(Album album);

}
