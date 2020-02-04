package VO;

public class MemberVO {
    private int mbrno;
    private String userid;
    private String passwd;
    private String name;
    private int frnum;
    private String zipcode1;
    private String zipcode2;
    private String addr1;
    private String addr2;
    private String email;
    private String regdate;

    //기본생성자
    public MemberVO () {
    }

    public int getMbrno() {
        return mbrno;
    }

    public void setMbrno(int mbrno) {
        this.mbrno = mbrno;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getFrnum() {
        return frnum;
    }

    public void setFrnum(int frnum) {
        this.frnum = frnum;
    }

    public String getZipcode1() {
        return zipcode1;
    }

    public void setZipcode1(String zipcode1) {
        this.zipcode1 = zipcode1;
    }

    public String getZipcode2() {
        return zipcode2;
    }

    public void setZipcode2(String zipcode2) {
        this.zipcode2 = zipcode2;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }
}
