package com.baizhi.serviceimpl;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.Banner;
import com.baizhi.mapper.BannerMapper;
import com.baizhi.service.BannerService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

@Service
@Transactional
public class BannerServiceimpl implements BannerService {
    @Autowired
    BannerMapper bannerMapper;

    //查询所有
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Banner> findAll(HttpServletResponse response) throws IOException {

        List<Banner> all = bannerMapper.findAll();
        for (Banner banner : all) {
            banner.setImgPath("E:\\第三阶段\\resources\\project\\cmfz\\src\\main\\webapp\\img\\" + banner.getImgPath());
        }

        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("轮播图列表", "轮播图"), Banner.class, all);

        String encode = URLEncoder.encode("轮播图信息.xls", "UTF-8");
        //设置响应头
        response.setHeader("content-disposition", "attachment;filename=" + encode);

        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        return null;
    }

    //根据页号查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> selectByPage(Integer page, Integer rows) {
        /*totle  总页数
         * page   当前页
         * records 总条数
         * rows   每页展示的数据
         * */
        Map<String, Object> map = new HashMap<>();
        //根据页号查询
        Integer start = (page - 1) * rows;
        List<Banner> banners = bannerMapper.selectByPage(start, rows);
        //查询总条数
        Integer count = bannerMapper.count();

        Integer total = count % rows == 0 ? count / rows : count / rows + 1;


        map.put("rows", banners);
        map.put("records", count);
        map.put("page", page);
        map.put("total", total);
        return map;
    }


    @Override
    public String edit(Banner banner, String oper, String ids) {
        if (oper.equals("add")) {
            String s = UUID.randomUUID().toString();
            banner.setId(s);
            banner.setCreate_date(new Date());
            bannerMapper.save(banner);
            return s;
        } else if (oper.equals("del")) {
            String[] split = ids.split(",");

            bannerMapper.delete(split);
            return null;
        } else {
            bannerMapper.update(banner);
            return null;
        }
    }

    @Override
    public void updateimg(String id, String imgPath) {
        bannerMapper.updateimg(id, imgPath);
    }
}
