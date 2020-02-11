package Servlet;

import Service.rvdkdMgr;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

@WebServlet("/modifyServlet")
public class modifyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws UnsupportedEncodingException {
        req.setCharacterEncoding("utf-8");
        rvdkdMgr mgr = new rvdkdMgr();

        try {
            mgr.modifyok(req, res);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
