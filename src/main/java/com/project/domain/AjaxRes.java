package com.project.domain;

public class AjaxRes {
    private boolean success;
    private String msg;
    private boolean employee=false;

    public boolean isEmployee() {
        return employee;
    }

    public void setEmployee(boolean employee) {
        this.employee = employee;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Override
    public String toString() {
        return "AjaxRes{" +
                "success=" + success +
                ", msg='" + msg + '\'' +
                ", employee=" + employee +
                '}';
    }
}
