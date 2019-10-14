package com.baizhi.serviceimpl;

import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.mapper.AlbumMapper;
import com.baizhi.mapper.ChapterMapper;
import com.baizhi.service.ChapterService;
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
public class ChapterServiceimpl implements ChapterService {
    @Autowired
    ChapterMapper chapterMapper;
    @Autowired
    AlbumMapper albumMapper;

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String, Object> findAll(Integer page, Integer rows, String albumid) {
        /*totle  总页数
         * page   当前页
         * records 总条数
         * rows   每页展示的数据
         * */
        Map<String, Object> map = new HashMap<>();
        //根据页号查询
        Integer start = (page - 1) * rows;
        List<Chapter> chapters = chapterMapper.findAll(start, rows, albumid);
        //查询总条数
        Integer count = chapterMapper.count(albumid);

        Integer total = count % rows == 0 ? count / rows : count / rows + 1;


        map.put("rows", chapters);
        map.put("records", count);
        map.put("page", page);
        map.put("total", total);

        return map;
    }


    //删
    @Override
    public String edit(Chapter chapter, String oper, String[] id, String albumid) {

        if (oper.equals("add")) {
            String s = UUID.randomUUID().toString();
            chapter.setId(s);
            chapter.setTimeLong("sdf");
            chapter.setSize("sss");
            chapter.setAlbumId(albumid);
            chapterMapper.save(chapter);
            return s;
        } else if (oper.equals("del")) {

            //String[] split = id.split(",");
            //chapterMapper.delete(split);

            chapterMapper.delete(id);

            Integer count = chapterMapper.count(albumid);
            Album album = new Album();
            album.setId(albumid);
            album.setCount(count);

            albumMapper.updateCount(album);
            return null;
        } else {
            chapterMapper.update(chapter);
            return null;
        }

    }

    @Override
    public void updatefilePath(Chapter chapter) {
        chapterMapper.updatefilePath(chapter);

        Integer count = chapterMapper.count(chapter.getAlbumId());

        Album album = new Album();
        album.setCount(count);
        album.setId(chapter.getAlbumId());
        albumMapper.updateCount(album);
    }


}
