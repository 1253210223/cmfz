package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String id;
    private String headImg;
    private String xname;
    private String sex;
    private String province;
    private String city;
    private String sign;
    private String username;
    private String password;
    private String status;
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    @JsonFormat(pattern = "yyyy-mm-dd")
    private Date userTime;
}
