package com.baizhi.controller;

import com.baizhi.entity.Article;
import com.baizhi.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RequestMapping("/article")
@RestController
public class ArticleController {

    @Autowired
    ArticleService articleService;

    @RequestMapping("/queryAll")
    public Map<String, Object> queryAll(Integer page, Integer rows) {
        Map<String, Object> map = articleService.queryAll(page, rows);

        return map;
    }

    @RequestMapping("/add")
    public void add(Article article) {
        articleService.add(article);
    }

    @RequestMapping("/update")
    public void update(Article article) {
        articleService.update(article);
    }

}

