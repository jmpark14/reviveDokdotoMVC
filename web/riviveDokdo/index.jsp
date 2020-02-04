<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
    <div class="row" style="margin-top: 3%;">
        <div id="carouselExampleIndicators" class="carousel slide col-md" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <iframe class="col-md" height="625px" src="https://www.youtube.com/embed/r3_d0pE6WlQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                </div>
                <div class="carousel-item">
                    <iframe  class="col-md" height="625px" src="https://player.vimeo.com/video/116558062" frameborder="0" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    <div class="row" style="margin-top: 2%;">
        <div class="col-md" style="height: 300px; border: 1px dashed white">
        </div>
    </div>
    <div class="row" style="margin-top: 2%;">
        <div class="col-md" style="height: 300px; border: 1px dashed white">
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script src="https://kit.fontawesome.com/3197007a76.js" crossorigin="anonymous"></script>
</body>
</html>
