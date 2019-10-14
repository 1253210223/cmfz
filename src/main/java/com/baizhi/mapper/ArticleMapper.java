package com.baizhi.mapper;

import com.baizhi.entity.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleMapper {
    //分页
    public List<Article> queryAll(@Param("start") Integer start, @Param("rows") Integer rows);

    //查总量
    public Integer count();

    //添加
    public void add(Article article);

    //修改
    public void update(Article article);
}
