package com.baizhi.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chapter {

    private String id;
    private String filePath;//音频路径
    private String title;//名字
    private String size;//体积大小
    private String timeLong;//时长
    private String status;
    private String albumId;
}
