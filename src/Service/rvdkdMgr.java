package Service;

import VO.rvdkdBoard;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class rvdkdMgr {
    // rvdkdMgr : 서블릿에서 호출한 것을 처리하고 서블릿의 post로 돌려보냄
    // write.jsp -> 글쓰기 servlet 호출 -> servlet dopost를 통해 보냄(글 제목, 본문 등) -> rvdkdMgr(글쓰기 작업-db에 넣기 등)
    // dopost : 데이터를 보내는 것
    // doget : 데이터를 받는 것

    private static String DRV = "oracle.jdbc.OracleDriver";
    private static String URL = "jdbc:oracle:thin:@15.164.233.149:1521:XE";
    private static String USR = "scott";
    private static String PWD = "tiger";

    Connection conn = null;// db연결 변수
    PreparedStatement pstmt = null; // sql 실행변수
    ResultSet rs = null; // 결과를 보여주는 변수 (조회시에만 쓰임)

    rvdkdBoard b = null; // set-변수설정/get-변수가져옴 할때 쓰임

    public rvdkdMgr() {} // 생성자 생성 - QQQ정확한 역할?

    // 글쓰기 처리
    public void insertBoard(HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        // insertBoard(HttpServletRequest req, HttpServletResponse res) : servlet dopost를 통해 보낸 글 제목, 본문 등을 db로 보내기 위해 작성
        // insertBoard 는 원하는 메서드명으로 작성하면 됨

        String insertSQL = "insert into SCOTT.RVDKDBOARD (BRDNO, USERID, TITLE, CONTENTS, TAGS) values (SCOTT.RVDKDSQ.nextval, 'tempmember', ?, ?, ?)";

        // DB에 넣기(try ~ catch 이용)
        try {
            Class.forName(DRV); // DB연결 객체 생성
            conn = DriverManager.getConnection(URL, USR, PWD);
            pstmt = conn.prepareStatement(insertSQL); // insertSQL을 실행할 것이라는 의미

            pstmt.setString(1, req.getParameter("title")); // ?개수대로 작성, dopost를 통해 보낸 글 제목, 본문 등을 파라메터값으로 받아와서 변수(vo 변수 : setString)에 넣음
            pstmt.setString(2, req.getParameter("contents"));
            pstmt.setString(3, req.getParameter("tags"));

            pstmt.executeUpdate(); // SQL처리를 update함(DB가 바뀌므로 executeUpdate 사용) - SQL문 실행

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {conn.close();}
            if (pstmt != null) {pstmt.close();}
        }

        // 글을 다썼으니 리스트로 가야 함
        res.sendRedirect("riviveDokdo/list.jsp");

        // 이제 writeok는 필요 없으니 삭제, write에서 action을 바꿔 줌
    }

    public List<rvdkdBoard> viewList (int brdno) throws SQLException {
        // public List<rvdkdBoard> - 반환할 값이 list임
        // viewList (int brdno) - view에서 int brdno = Integer.parseInt(request.getParameter("brdno"))로 처리했기 때문에 int 값으로 매개변수 줌

        // 조회수 sql
        String viewCountUpSQL = "update SCOTT.RVDKDBOARD set VIEWS = VIEWS + 1 where BRDNO =" + brdno;
        // "update SCOTT.RVDKDBOARD set VIEWS = VIEWS + 1 where BRDNO=" 는 String 값이므로 viewList (int brdno) 의 brdno와 같다고 인식시켜야 함(+는 연결의 의미)
        // update - table의 값을 업데이트 해줌

        // 글 가져오기
        String viewSQL = "select USERID, TITLE, CONTENTS, VIEWS, THUMBS, TAGS, REGDATE from SCOTT.RVDKDBOARD where BRDNO = " + brdno;

        List<rvdkdBoard> list = null;

        try {
            Class.forName(DRV);
            conn = DriverManager.getConnection(URL,USR,PWD);
            // 조회수 올리기
            pstmt = conn.prepareStatement(viewCountUpSQL); // 이걸 써주면 위의 SQL문에서 자동완성 가능
            pstmt.executeUpdate();

            //글 가져오기
            pstmt = conn.prepareStatement(viewSQL);
            rs = pstmt.executeQuery(); // SQL문 실행
            list = new ArrayList<>();

            if (rs.next()) { // 다음 줄이 존재한다면 계속 실행
                b = new rvdkdBoard();
                b.setUserid(rs.getString(1));
                b.setTitle(rs.getString(2));
                b.setContents(rs.getString(3));
                b.setViews(rs.getString(4));
                b.setThumbs(rs.getString(5));
                b.setTags(rs.getString(6));
                b.setRegdate(rs.getString(7));
                list.add(b);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {conn.close();}
            if (pstmt != null) {pstmt.close();}
            if (rs != null) {rs.close();}
        }

        return list;
    }

    // 게시글 수정
    public void modify (HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
        // 수정은 2단계에 걸쳐 진행
        // 1단계 - 글불러와서 modify페이지에 뿌림
        int brdno = Integer.parseInt(req.getParameter("brdno"));
        req.setCharacterEncoding("utf-8");
        res.setContentType("text/html; charset=utf-8");

        HttpSession session = req.getSession();
        // req의 세션을 가져옴 : 수정하기 위해 요청한 페이지의 세션을 가져옴

        b = (rvdkdBoard) session.getAttribute("b");
        // getAttribute로 view에서 가져온 b(세션 변수의 이름)는 보드의 b로 변경해야 함(변경이유 : mgr에서 처리하기 위해)

        String modifyreadSQL = "select TITLE, CONTENTS, TAGS, BRDNO from SCOTT.RVDKDBOARD where BRDNO = " + brdno;

        try {
            Class.forName(DRV);
            conn = DriverManager.getConnection(URL, USR, PWD);
            pstmt = conn.prepareStatement(modifyreadSQL);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                b.setTitle(rs.getString(1));
                b.setContents(rs.getString(2));
                b.setTags(rs.getString(3));
                b.setBrdno(rs.getString(4)); // 글 수정할때 어느 번호의 글을 수정하여 업데이트 할지 알아내기 위해 사용
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (rs != null) {
                rs.close();
            }
        }

        res.sendRedirect("riviveDokdo/modify.jsp?brdno=" + brdno);
        // 어떠한 글을 수정할지 가져오는 주소 riviveDokdo/modify.jsp?brdno=
    }

    // 2단계 - 수정중인 글 수정완료 및 업데이트
    public void modifyok (HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        int brdno = Integer.parseInt(req.getParameter("brdno"));
        req.setCharacterEncoding("utf-8");
        res.setContentType("text/html; charset=utf-8");

        String modifyCompleteSQL = "update SCOTT.RVDKDBOARD set TITLE = ?, CONTENTS = ?, TAGS = ? where BRDNO = " + brdno;

        try {
            Class.forName(DRV);
            conn = DriverManager.getConnection(URL, USR, PWD);
            pstmt = conn.prepareStatement(modifyCompleteSQL);
            pstmt.setString(1, req.getParameter("listtitle")); // modify에 정의되어있는 값을 따름
            pstmt.setString(2, req.getParameter("contents"));
            pstmt.setString(3, req.getParameter("tags"));
            pstmt.executeQuery();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {conn.close();}
            if (pstmt != null) {pstmt.close();}

        }
        // 처리 후 글번호대로 view로 보냄
        res.sendRedirect("riviveDokdo/view.jsp?brdno=" + brdno);
    }




    // 게시글 삭제
    public void deleteBoard (HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {
        int brdno = Integer.parseInt(req.getParameter("brdno"));
        // view 에서 input에 hidden을 주어 코드를 작성한 이유가 바로 위처럼 번호를 불러오기 위함(어떤 글을 삭제 할지)

        String DeleteSQL = "delete from SCOTT.RVDKDBOARD where BRDNO = " + brdno;
        // where BRDNO = " + brdno; 부분은 띄어쓰기 유념!

        try {
            Class.forName(DRV);
            conn = DriverManager.getConnection(URL, USR, PWD);
            pstmt = conn.prepareStatement(DeleteSQL);
            pstmt.executeUpdate();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (conn != null) {conn.close();}
            if (pstmt != null) {pstmt.close();}
        }

        res.sendRedirect("riviveDokdo/list.jsp");
        // sql을 처리하고 위의 페이지로 보냄
    }
}
