package com.baizhi;

import com.baizhi.entity.Admin;
import com.baizhi.entity.Album;
import com.baizhi.entity.Article;
import com.baizhi.entity.Banner;
import com.baizhi.mapper.*;
import com.baizhi.service.BannerService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CmfzApplicationTests {

    @Autowired
    AdminMapper adminMapper;
    @Autowired
    BannerMapper bannerMapper;
    @Autowired
    BannerService bannerService;
    @Autowired
    AlbumMapper albumMapper;
    @Autowired
    ArticleMapper articleMapper;
    @Autowired
    UserMapper userMapper;


    /*管理员登录*/
    @Test
    public void testAdmin() {
        Admin admin = adminMapper.adminlogin("wq");

        System.out.println(admin);
    }

    //轮播图
    @Test
    public void testBanner() {
        java.util.Date date = new java.util.Date();
        Banner banner = new Banner();
        banner.setId("1");
        banner.setTitle("cc");
        banner.setImgPath("cc.jpg");
        banner.setDes("222222");
        banner.setStatus("1");

        bannerMapper.update(banner);
    }

    //专辑
    @Test
    public void testAlbum() {
        List<Album> all = albumMapper.findAll(1, 3);
        for (Album album : all) {
            System.out.println(album);
        }
    }

    @Test
    public void testarticle() {
        List<Article> articles = articleMapper.queryAll(0, 1);
        for (Article article : articles) {
            System.out.println(article);
        }
    }


}
