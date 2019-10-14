package com.baizhi.service;

import com.baizhi.entity.Banner;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;


public interface BannerService {

    //查所有
    public List<Banner> findAll(HttpServletResponse response) throws IOException;

    //根据页号查询
    public Map<String, Object> selectByPage(Integer page, Integer rows);

    //查询所有条数
    //public Integer count();

    //增，删，改
    public String edit(Banner banner, String oper, String ids);

    public void updateimg(String id, String imgPath);

}
