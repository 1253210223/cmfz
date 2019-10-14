package com.baizhi.serviceimpl;

import com.baizhi.entity.Album;
import com.baizhi.mapper.AlbumMapper;
import com.baizhi.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class AlbumServiceimpl implements AlbumService {
    @Autowired
    AlbumMapper albumMapper;

    //根据页号查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> findAll(Integer page, Integer rows) {
        /*totle  总页数
         * page   当前页
         * records 总条数
         * rows   每页展示的数据
         * */
        Map<String, Object> map = new HashMap<>();
        //根据页号查询
        Integer start = (page - 1) * rows;
        List<Album> banners = albumMapper.findAll(start, rows);
        //查询总条数
        Integer count = albumMapper.count();

        Integer total = count % rows == 0 ? count / rows : count / rows + 1;


        map.put("rows", banners);
        map.put("records", count);
        map.put("page", page);
        map.put("total", total);
        return map;
    }

    //修改图片路径
    @Override
    public void updatecover(String id, String cover) {
        albumMapper.updatecover(id, cover);
    }

    @Override
    public String edit(Album album, String oper, String[] id) {
        if (oper.equals("add")) {
            String s = UUID.randomUUID().toString();
            album.setId(s);
            album.setPublishDate(new Date());
            albumMapper.save(album);
            return s;
        } else if (oper.equals("del")) {
            //String[] split = id.split(",");

            /*albumMapper.delete(split);
            albumMapper.delete1(split);*/

            albumMapper.delete(id);
            albumMapper.delete1(id);
            return null;
        } else {
            albumMapper.update(album);
            return null;
        }
    }


}
