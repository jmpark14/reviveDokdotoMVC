<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="VO.rvdkdBoard" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="jdbc.jsp"%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    // SQL 변수
    //String listSQL = "select brdno,title,userid,views,regdate from SCOTT.RVDKDBOARD order by brdno desc";
    String countSQL = "select count(brdno) from SCOTT.RVDKDBOARD";
    String pagingSQL = "select * from (select bd.brdno, bd.title, bd.userid, bd.views, bd.regdate, bd.thumbs, rownum as rnum from (select brdno,title,userid,views,regdate, thumbs from SCOTT.RVDKDBOARD order by brdno desc) bd where rownum <= ?) bd2 where bd2.rnum >= ? ";
    List<rvdkdBoard> lists = null;

    // 글번호 초기화
    int bdcnt = 0;


    // 글 갯수 반환
    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(countSQL);

        rs = pstmt.executeQuery();
        if(rs.next()) {
            bdcnt = rs.getInt(1);
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }

    }

    //게시글 목록 보여줌
    /*
    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL,USR,PWD);
        pstmt = conn.prepareStatement(listSQL);

        rs = pstmt.executeQuery();
        lists = new ArrayList<>();

        while (rs.next()) {
            rvdkdBoard b = new rvdkdBoard();
            b.setBrdno(rs.getString(1));
            b.setTitle(rs.getString(2));
            b.setUserid(rs.getString(3));
            b.setViews(rs.getString(4));
            b.setRegdate(rs.getString(5));
            lists.add(b);
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }*/

    //게시글이 30개를 넘기면 페이지를 ++함
    int perPage = 30;
    int totalPage = bdcnt / perPage;
    if (bdcnt % perPage > 0) {
        ++totalPage;
    }

    //페이지 넘김 구현
    int cPage = 1;

    try {
        cPage = Integer.parseInt(request.getParameter("cpage"));
    } catch (Exception ex) {
        ex.printStackTrace();
    }



    //현재 페이지 표시
    int startPage = ((cPage -1) / 10) * 10 + 1;
    int endPage = startPage + 10 - 1;

    //게시물 30단위로 보여주기
    // ex) cp=1 : bdno = 1,30
    // ex) cp=2 : bdno = 31,60
    // ex) cp=3 : bdno = 61,90
    int startNum = ((cPage-1) * perPage) + 1;
    int endNum = startNum + perPage - 1;

    try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL,USR,PWD);
        pstmt = conn.prepareStatement(pagingSQL);
        pstmt.setInt(1, endNum);
        pstmt.setInt(2, startNum);

        rs = pstmt.executeQuery();
        lists = new ArrayList<>();
        while (rs.next()) {
            rvdkdBoard b = new rvdkdBoard();
            b.setBrdno(rs.getString(1));
            b.setTitle(rs.getString(2));
            b.setUserid(rs.getString(3));
            b.setViews(rs.getString(4));
            b.setRegdate(rs.getString(5));
            b.setThumbs(rs.getString(6));
            lists.add(b);
        }



    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    // 글번호 재계산...하나 지워도 맞추도록...갯수
    int brdno = bdcnt - ((cPage-1) * perPage);

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
            <i class="fas fa-list fa-2x"> 게시판</i>
        </div>
        <div class="text-right" style="margin: 3px"><%--글쓰기 아이콘--%>
            <a href="write.jsp"><i class="fas fa-edit"></i></a>
        </div>
        <div class="row"><%--게시판--%>
            <div class="col">
                <table class="table table-striped table-dark">
                    <thead style="background-color: grey">
                    <tr>
                        <th class="text-center" style="width: 8%">번호</th>
                        <th>제목</th>
                        <th class="text-center" style="width: 10%">작성자</th>
                        <th class="text-center" style="width: 10%">작성일</th>
                        <th class="text-center" style="width: 7%">추천</th>
                        <th class="text-center" style="width: 7%">조회</th>
                    </tr>
                    </thead>
                    <tbody>
                        <% try {
                            for (rvdkdBoard b : lists) { %>
                        <tr>
                            <td class="text-center"><%=brdno-- %></td>
                            <td><a href="view.jsp?brdno=<%=b.getBrdno()%>"><%=b.getTitle()%></a></td>
                            <td class="text-center"><%=b.getUserid()%></td>
                            <td class="text-center"><%=b.getRegdate().substring(0,10)%></td>
                            <td class="text-center"><%=b.getThumbs()%></td>
                            <td class="text-center"><%=b.getViews()%></td>
                        </tr>
                        <% }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }%>
                        <%
                            //리스트에 아무것도 없을시 게시물 없다고 출력
                            if(lists == null || lists.isEmpty()) {
                                out.println("<tr><td></td>" +
                                        "<td class=\"text-right\">등록된 게시물이 없습니다.</td>" +
                                        "<td></td>" +
                                        "<td></td>" +
                                        "<td></td>" +
                                        "<td></td><tr>");
                                //없는 페이지로 가면 에러 창 출력
                            } else if (cPage > totalPage) {
                                response.sendRedirect("listerror.jsp");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="text-right" style="padding: 10px 0 5px 0;"><%--글쓰기 버튼--%>
            <button type="button" class="btn btn-outline-light" id="write">글쓰기</button>
        </div>
        <div align="center" style="margin: 5px 0 10px 0">
            <% if (cPage > 10)
                out.print("<span><a href='list.jsp?cpage="+(startPage-1)+"'>이전</a>&nbsp;</span>"); %>
            <%for (int i = startPage; i <= endPage; ++i) { %>
            <% if (i > totalPage) break;
                if (cPage == i) out.print("<b style='color:white; font-size: 20px'>" + i +"&nbsp;</b>"); // 현재 페이지에는 링크 x
                else out.print("<span><a style='color:white' href='list.jsp?cpage="+i+"'>" + i +"</a>&nbsp;</span>");
            %>
            <% } %>
            <% if (endPage < totalPage)
                out.print("<span><a href='list.jsp?cpage="+(endPage+1)+"'>다음</a>&nbsp;</span>"); %>
        </div>
        <form class="form-group row justify-content-center" name="searchFrm" method="post" action="list.jsp"><%--게시물 검색--%>
            <div class="w100" style="padding-right:10px">
                <select class="form-control form-control" name="searchType" id="searchType">
                    <option value="title">제목</option>
                    <option value="contents">본문</option>
                    <option value="userid">작성자</option>

                </select>
            </div>
            <div class="w300" style="padding-right:10px">
                <input type="text" class="form-control form-control" name="keyword" id="keyword">
            </div>
            <div>
                <button class="btn btn-primary" name="btnSearch" id="btnSearch" onclick="check()">검색</button>
            </div>
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script src="https://kit.fontawesome.com/3197007a76.js" crossorigin="anonymous"></script>

<script>
    $(function() {
        $('#write').on('click', function(e) {
            location.href = 'write.jsp';
        });
    });
    function check() {
        var keyword = document.getElementById("keyword");
        if (keyword.value == "") {
            alert('검색어를 입력하세요.');
            keyword.focus();
            return;
        }
        document.searchFrm.submit();
    }
</script>
</body>
</html>
