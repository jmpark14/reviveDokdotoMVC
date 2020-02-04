package Service;

import VO.rvdkdBoard;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class rvdkdMgr {
    // rvdkdMgr : 서블릿에서 호출한 것을 처리하고 서블릿의 post로 돌려보냄
    // write.jsp -> 글쓰기 servlet 호출 -> servlet dopost를 통해 보냄(글 제목, 본문 등) -> rvdkdMgr(글쓰기 작업-dv에 넣기 등)
    // dopost : 데이터를 보내는 것
    // doget : 데이터를 받는 것

    private static String DRV = "oracle.jdbc.OracleDriver";
    private static String URL = "jdbc.oracle:thin:@15.164.233.149:1521:XE";
    private static String USR = "scott";
    private static String PWD = "tiger";

    Connection conn = null;// db연결 변수
    PreparedStatement pstmt = null; // sql 실행변수
    ResultSet rs = null; // 결과를 보여주는 변수 (조회시에만 쓰임)

    rvdkdBoard b = null; // set-변수설정/get-변수가져옴 할때 쓰임

    public rvdkdMgr() {} // 생성자 생성

    // 글쓰기 처리
    public void insertBoard(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        // insertBoard(HttpServletRequest req, HttpServletResponse res) : servlet dopost를 통해 보낸 글 제목, 본문 등을 db로 보내기 위해 작성
        // insertBoard 는 원하는 메서드명으로 작성하면 됨

        String insertSQL = "insert into SCOTT.RVDKDBOARD (BRDNO, USERID, TITLE, CONTENTS, TAGS) values (SCOTT.RVDKDSQ.nextval, tempmember, ?, ? ?)";

        // DB에 넣기(try ~ catch 이용)
        try {
            Class.forName(DRV); // DB연결 객체 생성
            conn = DriverManager.getConnection(URL, USR, PWD);
            pstmt = conn.prepareStatement(insertSQL); // insertSQL을 실행할 것이라는 의미

            pstmt.setString(1, req.getParameter("title")); // ?개수대로 작성, dopost를 통해 보낸 글 제목, 본문 등을 파라메터값으로 받아와서 변수(vo 변수 : setString)에 넣음
            pstmt.setString(2, req.getParameter("contents"));
            pstmt.setString(3, req.getParameter("tags"));

            pstmt.executeUpdate(); // SQL처리를 완료함(DB가 바뀌므로 executeUpdate 사용)

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {conn.close();}
            if (pstmt != null) {pstmt.close();}
        }

        // 글을 다썼으니 리스트로 가야 함
        res.sendRedirect("riviveDokdo/list.jsp");

        // 이제 writeok는 필요 없으니 삭제, write에서 action을 수


    }
}
