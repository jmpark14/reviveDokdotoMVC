<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="VO.rvdkdBoard" %>
<%
    rvdkdBoard b = (rvdkdBoard)session.getAttribute("b");
    // rvdkdBoard의 b에 view에서 저장한 session
    // (view.jsp의 상단 try - catch문 내의 session.setAttribute("b", b); // 세션에다 attribute를 저장)을 불러와서 저장

    String brdno = b.getBrdno();
    String title = b.getTitle();
    String contents = b.getContents();
    String tags = "";

    if (b.getTags() == null) {
    tags = "";
    }
    else {
    tags = b.getTags();
    }
%>
​
<!DOCTYPE html>
<html>
<head lang="ko">
    <title>독도의 역사 독도의 진실</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
</head>
<body>
<%@include file="head.jsp"%>

<div class="container">
    <div id="main" style=" margin: 20px 0">
        <div style="color: white">
            <i class="fas fa-edit fa-2x"> <strong>독도 게시판 - </strong><small>수정하기</small></i>
        </div>
        <hr>
        <div class="col-11 text-right" style="margin-left: 15px">
            <button type="button" class="btn btn-outline-light" id="listbtn">
                <i class="fa fa-list"></i> 목록으로
            </button>
        </div>
        <div class="row" style="margin: 30px 0px">
            <div class="col-1"></div>
            <form style="background: #E5E5E5; color: #E5E5E5; border-radius: 10px" class="card card-body bg-dark col-10" name="brdfrm" action="${pageContext.request.contextPath}/modifyServlet" method="post">
                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="listtitle"><strong>글 제목</strong></label>
                    <input style="background: #E5E5E5" type="text" id="listtitle" name="listtitle" class="form-control col-9" placeholder="글 제목을 입력하세요(*필수)" value="<%=title%>">
                </div>
                ​
                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="contents"><strong>본문내용</strong></label>
                    <textarea style="background: #E5E5E5" rows="15" id="contents" name="contents" class="form-control col-9" placeholder="본문 내용을 입력하세요(*필수)"><%=contents%></textarea>
                </div>
                ​
                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="tags"><strong>태그</strong></label>
                    <input style="background: #E5E5E5" type="text" id="tags" name="tags" class="form-control col-9" value="<%=tags%>">
                </div>
                <input value="<%=brdno%>" type="hidden" name="brdno" id="brdno">
                <div class="row">
                    <div class="col-12 text-center" style="border-top: 2px double darkgrey; margin-top: 35px; padding-top: 25px;">
                        <button type="submit" id="newbtn" class="btn btn-outline-primary">
                            <i class="fas fa-check"></i> 입력완료
                        </button>
                        <button type="button" id="goTolist" class="btn btn-outline-warning">
                            <i class="fas fa-times"></i> 그만두기
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
</body>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script src="https://kit.fontawesome.com/3197007a76.js" crossorigin="anonymous"></script>
<script type="text/javascript">
    //글쓰기 버튼을 클릭할 시
    $(function () {
        $('#newbtn').on('click',function (e) {
            var listtitle = document.getElementById("listtitle");
            var contents = document.getElementById("contents");
            if (listtitle.value == "" || listtitle.value == null) {
                alert('제목이 비어 있습니다.');
                listtitle.focus();
                return false;
            } else if (contents.value == "") {
                alert('내용이 비어 있습니다.');
                contents.focus();
                return false;
            }
            else {
                return true;
            }
        })
    });
    //취소 버튼을 클릭할 시
    $(function() {
        $('#goTolist').on('click', function(e) {
            location.href = 'list.jsp';
        });
    });
​
    //목록으로 버튼을 클릭시
    $(function () {
        $('#listbtn').on('click', function (e) {
            location.href = 'list.jsp';
        });
    });
</script>
</html>