package com.project.service.impl;

import com.project.domain.Student;
import com.project.mapper.StudentMapper;
import com.project.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper mapper;


    @Override
    public Student getStudentWithSid(String id) {
        try{
            Student student=new Student();
            student=mapper.selectById(id);
            return student;
        }catch (Exception e){
            e.printStackTrace();
        }

        return null;
    }
}
