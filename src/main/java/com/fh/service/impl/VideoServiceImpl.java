package com.fh.service.impl;


import com.fh.dao.VideoDao;
import com.fh.entity.Video;
import com.fh.service.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    private VideoDao videoDao;

    @Override
    public void addVideo(Video video) {
        videoDao.addVideo(video);
    }
}
