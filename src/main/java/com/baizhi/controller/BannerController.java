package com.baizhi.controller;

import com.baizhi.entity.Banner;
import com.baizhi.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/banner")
public class BannerController {
    @Autowired
    BannerService bannerService;

    @RequestMapping("/edit")
    public String edit(Banner banner, String oper, String id) {
        String edit = bannerService.edit(banner, oper, id);
        return edit;
    }

    @RequestMapping("upload")
    public void upload(MultipartFile imgPath, String bannerId, HttpSession session) {
        //获取图片存储的位置
        String realPath = session.getServletContext().getRealPath("/img");

        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }

        String filename = imgPath.getOriginalFilename();
        String newFileName = new Date().getTime() + "_" + filename;

        bannerService.updateimg(bannerId, newFileName);
        try {
            imgPath.transferTo(new File(realPath, newFileName));

        } catch (IOException e) {
            e.printStackTrace();

        }

    }

    //查所有
    @RequestMapping("/Easypoi")
    public void findAll(HttpServletResponse response) throws IOException {
        List<Banner> all = bannerService.findAll(response);
    }

    //分页
    @RequestMapping("/selectByPage")
    public Map<String, Object> selectByPage(Integer page, Integer rows) {

        Map<String, Object> map = bannerService.selectByPage(page, rows);

        return map;
    }
}
