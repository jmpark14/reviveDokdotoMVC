<%@ page import="VO.rvdkdBoard" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="mgr" class="Service.rvdkdMgr"/>
<!-- rvdkdMgr의 mgr을 가져오겠다는 의미, id는 rvdkdMgr의 변수명, class는 rvdkdMgr의 위치를 의미 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="jdbc.jsp"%>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    // view 는 servlet을 거치지 않고 바로 mgr로 들어감, 왜냐하면 view는 get, post 방식이 아니기 때문
    // 그렇기 때문에 위에서 usebean을 사용하여 mgr을 가져옴

    // list에서 brdno값을 가져옴
    int brdno = Integer.parseInt(request.getParameter("brdno"));
    // request.getParameter("brdno") - 스트링값을 불러옴

    // 게시글 변수 - 주석을 달아 변수가 무엇인지 명시하는 것이 좋음
    String title = null; // 글 제목
    String userid = null; // 작성자
    String regDate = null; // 등록일
    String view = null; // 조회수
    String contents = null; // 본문
    String tags = null; // 태그
    String thumbs = null; // 추천

    List<rvdkdBoard> list = null; // 위의 변수들을 담아서 view의 jsp코드에 뿌려줌

    // 게시글 가져오기
    try { // DB연결을 위해 try catch 사용
        list = mgr.viewList(brdno);
        // viewList : db 연결할 함수, viewList라는 함수에 brdno를 보냄
    } catch(Exception ex) {
        ex.printStackTrace();
    }

    for(rvdkdBoard b : list) {
        title = b.getTitle();
        userid = b.getUserid();
        regDate = b.getRegdate();
        view = b.getViews();
        contents = b.getContents();
        tags = b.getTags();
        thumbs = b.getThumbs();
        session.setAttribute("b", b); // 세션에다 attribute를 저장, "b"는 변수 b는 "b"에 들어갈 값
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
                        <h3><%=title%></h3>
                        <%-- 위의 jsp코드 중 mgr에서 가져온 title 변수를 사용, 이하동일 --%>
                    </th>
                </tr>
                <tr style="color: white">
                    <td><%=userid%></td>
                    <td class="text-right"><small><%=regDate.substring(0,10)%> / <%=view%></small></td>
                </tr>
                <tr style="color: white">
                    <td colspan="2">

                        <p><%=contents.replace("\n\r","<br>")%></p>
                        <%-- ~~().replace("\n\r","<br>") : 줄바꿈 기능이 먹히게끔 함--%>
                    </td>
                </tr>
                <tr style="color: white">
                    <td colspan="2" style="border-bottom: 2px solid; color: white">
                        <%
                            if (tags == null) {
                                out.print("<a>TAG : <a>");
                            } else {
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
                    <i class="fas fa-thumbs-up" style="padding-bottom: 5px"> 추천 <%=thumbs%></i>
                </button>
            </div>
        </form>
        <div class="row" style="margin: 10px 30px 20px 30px">

            <form class="col-6" action="${pageContext.request.contextPath}/mdServlet" method="post">
                <%-- action=/mdServlet에서 alt+enter하여 prefix추가 => ${pageContext.request.contextPath} 생성 --%>
                <button type="button" class="btn btn-outline-warning" id="updatebtn">
                    <i class="fa fa-pencil"> 수정하기</i>
                </button>
                <button type="button" class="btn btn-outline-danger" id="deletebtn">
                    <i class="fa fa-trash-o"> 삭제하기</i>
                </button>
                <input value="<%=brdno%>" type="hidden" name="brdno">
                <%-- type="hidden"으로 지정하면 웹페이지에서 해당 태그는 보이지 않음 --%>
                <input value="" type="hidden" id="mdselect" name="mdselect" >
                <%-- mdselect는 수정 및 삭제 버튼 클릭 시 변하는 값으로서, 이 값을 통해서 mgr의 경로가 바뀜 --%>

            </form>
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

    // 삭제 버튼 클릭 시
    $(function () {
        $('#deletebtn').on('click',function (e) {
            var select = document.getElementById("mdselect");
            // 위에서 아이디 값을 받아옴...
            select.value = "delete"; // 받아온 값이 delete라면
            if (confirm('이 글을 삭제하시겠습니까?')) {
                // confirm : 경고창 뜨면서 예, 아니오 선택하게 하는 함수
                alert("글을 삭제했습니다!"); // 알람
                return true; // 만약 true가 뜨면 서블릿에 있는 것을 그대로 수행
            } else {
                return false; // 만약 false(아니오)라면 서블릿에 있는 것을 수행하지 않고 삭제 처리 안함
            }

        });

    });

    // 수정 버튼 클릭 시
    $(function () {
        $('#updatebtn').on('click', function (e) {
            var select = document.getElementById("mdselect");
            select.value = "modify"; // 위와 비슷
       });
    });

</script>
</body>
</html>
