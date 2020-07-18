package com.project.mapper;

import com.project.domain.Student;
import java.util.List;

public interface StudentMapper {
    int insert(Student record);

    List<Student> selectAll();
}