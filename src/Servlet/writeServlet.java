package Servlet;

import Service.rvdkdMgr;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

@WebServlet("/writeServlet") // 서블릿으로 사용하겠다고 선언
public class writeServlet extends HttpServlet {
    // extends HttpServlet : dopost, doget 을 사용하기 위해 선언
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws UnsupportedEncodingException {
        // HttpServletRequest req, HttpServletResponse res : dopost(데이터 보냄)에 대해 요청하고 응답받기 위해 사용
        // protected 사용 이유 : 보안, private을 사용할 경우 doPost 작동 안함

        req.setCharacterEncoding("UTF-8"); // 인코딩 설정

        rvdkdMgr mgr = new rvdkdMgr(); // mgr 객체 생성


    }

}
