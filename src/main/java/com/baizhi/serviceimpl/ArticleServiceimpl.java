package com.baizhi.serviceimpl;

import com.baizhi.entity.Article;
import com.baizhi.mapper.ArticleMapper;
import com.baizhi.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class ArticleServiceimpl implements ArticleService {

    @Autowired
    ArticleMapper articleMapper;


    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> queryAll(Integer page, Integer rows) {

        Map<String, Object> map = new HashMap<>();

        //查询总条数
        Integer count = articleMapper.count();
        //获取起始条数
        Integer start = (page - 1) * rows;
        //展示的
        List<Article> articles = articleMapper.queryAll(start, rows);
        //总页数
        Integer total = count % rows == 0 ? count / rows : count / rows + 1;

        map.put("total", total);
        map.put("records", count);
        map.put("rows", articles);
        map.put("page", page);


        return map;
    }

    @Override
    public void add(Article article) {

        String s = UUID.randomUUID().toString();
        java.util.Date date = new java.util.Date();

        article.setId(s);
        article.setCreateDate(date);
        articleMapper.add(article);
    }

    @Override
    public void update(Article article) {
        articleMapper.update(article);
    }

}
