package Servlet;

import Service.rvdkdMgr;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/mdServlet")
public class mdServlet extends HttpServlet {

    protected void doPost (HttpServletRequest req, HttpServletResponse res) throws IOException {
        // throws IOException 수동으로 작성

        req.setCharacterEncoding("utf-8");
        rvdkdMgr mgr = new rvdkdMgr(); // mgr 객체 생성

        String select = req.getParameter("mdselect");
        // view 에서 보낸 mdselect 값을 받아옴(수정이든 삭제든)

        switch (select) {
            case "modify" : { // 문자열이므로 "" 꼭 써야 함

                try { // mgr의 modify 메서드에 sql문이 포함되므로 (db에서 실패할수도 있으므로) try-catch 써야 함
                    mgr.modify(req, res);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break; // 반드시 써줘야 함, 만약 쓰지 않으면 아래의 delete까지 수행을 반복함
            }

            case "delete" : {

                try {
                    mgr.deleteBoard(req, res);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break; // 여기서는 안전상 break 쓰는게 좋음
            }
        }

    }


}
