package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.service.AdminService;
import com.baizhi.util.ValidateImageCodeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    AdminService adminService;


    @ResponseBody
    @RequestMapping("/login")
    public Map<String, String> adminlogin(String username, String password, String image, HttpSession session) {
        Map<String, String> map = new HashMap<>();
        String verCode = (String) session.getAttribute("code");

        if (verCode.equals(image)) {
            Admin admin = adminService.adminlogin(username);
            if (admin != null) {
                if (password.equals(admin.getPassword())) {
                    map.put("admin", "true");
                    map.put("message", null);
                    session.setAttribute("username", username);
                    return map;
                } else {
                    map.put("admin", null);
                    map.put("message", "密码错误");
                    return map;
                }
            } else {
                map.put("admin", "true");
                map.put("message", "用户不存在");
                return map;
            }
        } else {
            map.put("admin", null);
            map.put("message", "验证码错误");
            return map;
        }

    }


    @RequestMapping("/image")
    public void image(HttpSession session, HttpServletResponse response) throws IOException {
        String securityCode = ValidateImageCodeUtils.getSecurityCode();
        session.setAttribute("code", securityCode);
        BufferedImage image = ValidateImageCodeUtils.createImage(securityCode);
        ImageIO.write(image, "png", response.getOutputStream());
    }

    @RequestMapping("/adminEsc")
    public String adminEsc(HttpSession session) {
        session.invalidate();
        return "redirect:/login/login.jsp";
    }

}
