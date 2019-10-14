package com.baizhi.mapper;

import com.baizhi.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerMapper {
    //查所有
    public List<Banner> findAll();

    //根据页号查询
    public List<Banner> selectByPage(@Param("start") Integer start, @Param("rows") Integer rows);

    //查询总条数
    public Integer count();

    //添加
    public void save(Banner banner);

    //修改
    public void update(Banner banner);

    //修改图片路径
    public void updateimg(@Param("id") String id, @Param("imgPath") String imgPath);

    //删除
    public void delete(String[] id);
}
