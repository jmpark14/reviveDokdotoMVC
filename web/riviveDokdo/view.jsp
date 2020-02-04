<%@ page import="VO.rvdkdBoard" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    //list에서 brdno 값을 가져옴
    int brdno = Integer.parseInt(request.getParameter("brdno"));
    Connection conn = null;;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    rvdkdBoard b = new rvdkdBoard();


    String viewCountUpSQL = "UPDATE SCOTT.RVDKDBOARD SET VIEWS = VIEWS + 1 WHERE BRDNO = " + brdno;
    String viewSQL = "SELECT USERID, TITLE, CONTENTS, VIEWS, THUMBS, TAGS, REGDATE, FILENAME FROM RVDKDBOARD WHERE BRDNO = " + brdno;

    //조회수 올리기
    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(viewCountUpSQL);

        pstmt.executeUpdate();
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (conn != null) {
            conn.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
    }

    //글 가져오기
    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(viewSQL);

        rs = pstmt.executeQuery();

        while (rs.next()) {
            b.setUserid(rs.getString(1));
            b.setTitle(rs.getString(2));
            b.setContents(rs.getString(3));
            b.setViews(rs.getString(4));
            b.setThumbs(rs.getString(5));
            b.setTags(rs.getString(6));
            b.setRegdate(rs.getString(7));
            b.setFileName(rs.getString(8));
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
%>

<!DOCTYPE html>
<html>
<head lang="ko">
    <title>독도의 역사 독도의 진실</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <style>
        body {
            width: 100%; height: 100vh; background-image: url("../img/back-groud_night.png"); background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>
<%@include file="head.jsp"%>
<body>
<div class="container">
    <div id="main" style=" margin: 20px 0">
        <div style="color: white">
            <i class="fas fa-book-open fa-2x"> <strong>게시판 - </strong><small> 게시글 보기</small></i>
        </div>
        <div class="text-right" style="margin: 3px">
            <a href="write.jsp"><i class="fas fa-edit"></i></a>
        </div>
        <hr color="white">
        <div class="row" style="margin: 10px 30px 20px 30px">
            <div class="col-6">
                <button type="button" class="btn btn-outline-light" id="prevbtn">
                    <i class="fa fa-chevron-left">이전게시물</i>
                </button>
                <button type="button" class="btn btn-outline-light" id="nextbtn">
                    <i class="fa fa-chevron-right">다음게시물</i>
                </button>
            </div>
            <div class="col-6 text-right">
                <button type="button" class="btn btn-outline-light" id="newbtn">
                    <i class="fa fa-plus-circle">새글쓰기</i>
                </button>
                <button type="button" class="btn btn-outline-light" id="listbtn">
                    <i class="fa fa-list">목록으로</i>
                </button>
            </div>
        </div><!--버튼-->

        <div class="row" style="margin: 10px 30px 20px 30px">
            <table class="table">
                <tr>
                    <th colspan="2" style="background-color: skyblue; border-bottom: 2px solid #000000" class="text-center">
                        <h3><%=b.getTitle()%></h3>
                    </th>
                </tr>
                <tr style="color: white">
                    <td><%=b.getUserid()%></td>
                    <td class="text-right"><small><%=b.getRegdate().substring(0,10)%> / <%=b.getViews()%></small></td>
                </tr>
                <tr style="color: white">
                    <td colspan="2">

                        <p><%=b.getContents().replace("\n\r","<br>")%></p>
                        <%-- ~~().replace("\n\r","<br>") : 줄바꿈 기능이 먹히게끔 함--%>
                    </td>
                </tr>
                <tr style="color: white">
                    <td colspan="2" style="border-bottom: 2px solid; color: white">
                        <%
                            if (b.getTags() == null) {
                                out.print("<a>TAG : <a>");
                            } else {
                                String tags = b.getTags();
                                out.print("<a>TAG : " + tags + "<a>");
                            }
                        %>
                    </td>
                </tr>
            </table>
        </div><!--게시판 본문-->
        <form>
            <div class="form-group text-center">
                <button type="submit" class="btn btn-outline-primary" id="thumbtn">
                    <i class="fas fa-thumbs-up" style="padding-bottom: 5px"> 추천 <%=b.getThumbs()%></i>
                </button>
            </div>
        </form>
        <div class="row" style="margin: 10px 30px 20px 30px">

            <div class="col-6">
                <button type="button" class="btn btn-outline-warning" id="updatebtn">
                    <i class="fa fa-pencil"> 수정하기</i>
                </button>
                <button type="button" class="btn btn-outline-danger" id="deletebtn">
                    <i class="fa fa-trash-o"> 삭제하기</i>
                </button>
            </div>
            <div class="col-6 text-right">
                <button type="button" class="btn btn-outline-light" id="listbtn1">
                    <i class="fa fa-list">목록으로</i>
                </button>
            </div>
        </div><!--하단버튼-->
    </div>
</div>

<%@include file="footer.jsp"%>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script src="https://kit.fontawesome.com/3197007a76.js" crossorigin="anonymous"></script>

<script>
    //새글쓰기 버튼을 클릭시
    $(function() {
        $('#newbtn').on('click', function(e) {
            location.href = 'write.jsp';
        });
    });

    //목록으로 버튼을 클릭시
    $(function () {
        $('#listbtn').on('click', function (e) {
            location.href = 'list.jsp';
        });
        $('#listbtn1').on('click', function (e) {
            location.href = 'list.jsp';
        });
    });

</script>
</body>
</html>
