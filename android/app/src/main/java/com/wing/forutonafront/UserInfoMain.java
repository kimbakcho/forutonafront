package com.wing.forutonafront;


public class UserInfoMain extends Userinfo {
    public String getSnstoken() {
        return snstoken;
    }

    public void setSnstoken(String snstoken) {
        this.snstoken = snstoken;
    }

    String snstoken="";

    public String getPhoneauthcheckcode() {
        return phoneauthcheckcode;
    }

    public void setPhoneauthcheckcode(String phoneauthcheckcode) {
        this.phoneauthcheckcode = phoneauthcheckcode;
    }

    String phoneauthcheckcode;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    String password;
}
