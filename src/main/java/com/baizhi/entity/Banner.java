package com.baizhi.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Banner {
    @Excel(name = "编号", width = 40, needMerge = true)
    private String id;
    @Excel(name = "图片路径", type = 2, width = 20, height = 10)
    private String imgPath;
    @Excel(name = "标题", needMerge = true)
    private String title;
    @Excel(name = "状态", needMerge = true)
    private String status;
    @Excel(name = "描述", needMerge = true)
    private String des;
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    @JsonFormat(pattern = "yyyy-mm-dd")
    @Excel(name = "创建日期", format = "yyyy-MM-dd", needMerge = true, width = 20)
    private Date create_date;
}
