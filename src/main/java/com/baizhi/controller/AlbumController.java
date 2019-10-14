package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

@RequestMapping("/album")
@RestController
public class AlbumController {
    @Autowired
    AlbumService albumService;

    @RequestMapping("findAll")
    public Map<String, Object> findAll(Integer page, Integer rows) {
        Map<String, Object> map = albumService.findAll(page, rows);
        return map;
    }

    @RequestMapping("upload")
    public void upload(MultipartFile cover, String bannerId, HttpSession session) {
        //获取图片存储的位置
        String realPath = session.getServletContext().getRealPath("/img");

        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
        }

        String filename = cover.getOriginalFilename();
        String newFileName = new Date().getTime() + "_" + filename;

        albumService.updatecover(bannerId, newFileName);
        try {
            cover.transferTo(new File(realPath, newFileName));

        } catch (IOException e) {
            e.printStackTrace();

        }

    }

    @RequestMapping("/edit")
    public String edit(Album album, String oper, String[] id) {
        String edit = albumService.edit(album, oper, id);
        return edit;
    }
}
