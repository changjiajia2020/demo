package com.fh.controller;

import com.fh.entity.Video;
import com.fh.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("videoController")
public class VideoController {

    @Autowired
    private VideoService videoService;

    // 新增
    @RequestMapping("addVideo")
    @ResponseBody
    public Map<String,Object> addVideo(Video video){
        Map<String,Object> result = new HashMap<String,Object>();
        // 起初，视频数量为0，所以要set值
        // 因为此处的数据类型为Int   但是实体类中
        video.setCount(0l);
        try {
            videoService.addVideo(video);
            result.put("code",200);
            result.put("message","新增成功");
        }catch (Exception e){
            result.put("code",500);
            result.put("message","新增失败");
        }
        return result;
    }

    // 图片上传
    @RequestMapping("uploadFile")
    @ResponseBody
    public Map<String,Object> uploadFile(@RequestParam("image") MultipartFile img, HttpServletRequest request){
        Map<String,Object> result = new HashMap<String, Object>();
        /**
         * 修改图片名称
         * 上传图片
         */
        String originalFilename = img.getOriginalFilename();
        int dotIndex = originalFilename.lastIndexOf(".");
        String suffix = originalFilename.substring(dotIndex);
        String newFileName = UUID.randomUUID() + suffix;

        String realPath = request.getSession().getServletContext().getRealPath("/images");
        File file  = new File(realPath);
        if (! file.exists()) {
            file.mkdir();
        }

        try {
            img.transferTo(new File(realPath + "/" + newFileName));
            // 在浏览器"隐藏域"中，显示的路径
            result.put("filePath","images/" + newFileName);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;

    }

}
