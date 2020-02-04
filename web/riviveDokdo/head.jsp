<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>

<header class="container">
    <div class="row"><%--상단--%>
        <div class="col-md">
            <h1>韓國之獨島</h1>
        </div>
        <div class="col-md text-right" style="margin:10px 0">
            <button class="btn btn-danger" type="button" data-toggle="modal" data-target="#loginmodal">로그인</button>
            <button class="btn btn-primary" type="button" id="joinbtn">회원가입</button>
        </div>
    </div>
    <nav class="nav navbar-expand-md navbar-dark bg-success" style="margin-top: 25%"><%--목록--%>
        <ul class="nav navbar-nav nav-pills nav-fill w-100">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-home"> HOME</i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link"> ABOUT</a>
            </li>
            <li class="nav-item">
                <a class="nav-link">독도의 역사 1</a>
            </li>
            <li class="nav-item">
                <a class="nav-link">독도의 역사 2</a>
            </li>
            <li class="nav-item">
                <a class="nav-link">갤러리</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="list.jsp">게시판</a>
            </li>
            <li class="nav-item">
                <a class="nav-link">소개 </a>
            </li>
        </ul>
    </nav>
</header>

