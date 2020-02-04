<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %> <%-- 언어 및 인코딩 설정--%>
<%@include file="jdbc.jsp"%> <%-- sql문을 전달하기 위해 jdbc 인클루드 함--%>
<% request.setCharacterEncoding("UTF-8"); %> <%-- QQQ-왜 한번 더 인코딩 설정을 하는 것일까? --%>

<%
    Connection conn = null; // DB에 연결을 명령하는 DB 연결 명령어, null값으로 초기화(아직 연결 안하므로)
    PreparedStatement pstmt = null; // DB 처리 명령어/SQL문을 모아서 DB로 보내 처리/보안의 이유로도 사용됨 null값으로 초기화(아직 처리 안하므로)
    String insertSQL = "insert into SCOTT.RVDKDBOARD (BRDNO, USERID, TITLE, CONTENTS, TAGS) VALUES (SCOTT.RVDKDSQ.nextval,'ds',?,?,?)";
//    String insertSQL = "insert into SCOTT.RVDKDBOARD (BRDNO, USERID, TITLE, CONTENTS, TAGS) VALUES (SCOTT.RVDKDSQ.nextval, 'ds',?,?,?)";
    // 게시판에 작성한 컬럼을 db에 넣는 sql구문. 글번호는 자동으로 넣고(시퀀스는 미리 구문 만들어서 db에 추가), USERID에 임시 값 넣음,

    boolean isInsert = false; // 게시물 삽입여부를 확인하는 변수(아직 삽입 전이므로 false로 초기화)

    String title = request.getParameter("title"); // name이 title인 값을 가져와서 title 변수에 저장
    String contents = request.getParameter("contents"); // name이 contents인 값을 가져와서 contents 변수에 저장
    String tags = request.getParameter("tags"); // name이 tags인 값을 가져와서 tags 변수에 저장

    // 구현시 오류화면을 피하기 위해 예외처리 - (여기부터 직접 코드 써보기)
    try {
        Class.forName(DRV); // SQL문을 DRV와 연결
        conn = DriverManager.getConnection(URL, USR, PWD); // Drivermanager를 통해 DB의 URL, USR, PWD에 연결하라는 명령
        pstmt = conn.prepareStatement(insertSQL); // 연결된 DB에서 insertSQL을 처리하라는 명령

        pstmt.setString(1, title); // QQQ- DB에 들어가는 insertSQL문 중 title 처리(=입력)
        pstmt.setString(2, contents); // QQQ- DB에 들어가는 insertSQL문 중 contents 처리(=입력)
        pstmt.setString(3, tags); // QQQ- DB에 들어가는 insertSQL문 중 tags 처리(=입력)

    } catch (Exception ex) { // try안의 코드가 맞지 않다면 이곳으로 이동
        ex.printStackTrace(); // QQQ-? 알아보기
    } finally { // try -> finally 혹은 catch -> finally 로 이동, try -> finally 는 예외가 발생하지 않고 finally 이하 구문 실행, catch -> finally는 예외가 발생하여 finally 구문 실행
        if (pstmt != null) {pstmt.close();} // 예외없고, 최초에 null이었던 DB 처리 명령어가 데이터를 입력하는 과정에서 더이상 null이 아님, 닫아줌, 보안상의 이유도 있음
        if (conn != null) {conn.close();} // 예외없고, 최초에 null이었던 DB 연결 명령어가 데이터를 입력하는 과정에서 더이상 null이 아님, 닫아줌, 보안상의 이유도 있음
    }


    try {
        Class.forName(DRV); // SQL문을 DRV와 연결
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(insertSQL);

        pstmt.setString(1, title);
        pstmt.setString(2, contents);
        pstmt.setString(3, tags);

        int cnt = pstmt.executeUpdate(); // int cnt: 게시물이 올라가지 않으면 0, 1개라도 들어가면
        if(cnt >0) { // if 조건에 걸려서
            isInsert = true; // 게시물 삽입여부를 확인하는 변수는 TRUE가 됨
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }finally {
        if(pstmt != null) {
            pstmt.close();
        }
        if(conn != null) {
            conn.close();
        }
    }

    // try ~ catch문 빠져나와서
    if(isInsert) response.sendRedirect("list.jsp"); // if(isInsert) == if(isInsert == TRUE) => 게시물 삽입여부가 사실로 확인되면 페이지는 list.jsp로 리디렉션 됨
    else out.print("<script>history.go(-1);</script>"); // write에서 writeok로 갔다가 만약 게시물 삽입하되지 않았다면 -1페이지 뒤로 이동하여 다시 write페이지로 이동 됨


%>