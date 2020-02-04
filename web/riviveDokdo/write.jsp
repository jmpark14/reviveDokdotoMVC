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
    <div id="main" style=" margin: 20px 0">
        <div style="color: white">
            <i class="fas fa-edit fa-2x"> <strong>게시판 - </strong><small>새글쓰기</small></i>
        </div>
        <hr color="white">
        <div class="col-11 text-right" style="margin-left: 15px">
            <button type="button" class="btn btn-outline-light" id="listbtn">
                <i class="fa fa-list"></i> 목록으로
            </button>
        </div>
        <div class="row" style="margin: 30px 0px">
            <div class="col-1">
            </div>
            <form style="color: #E5E5E5; border-radius: 10px" class="card card-body bg-dark col-10" name="brdfrm" action="writeok.jsp" method="post">
                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="title"><strong>글 제목</strong></label>
                    <input style="background: #E5E5E5" type="text" id="title" name="title" class="form-control col-9" placeholder="글 제목을 입력하세요(*필수)">
                </div>

                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="contents"><strong>본문내용</strong></label>
                    <textarea style="background: #E5E5E5" rows="15" id="contents" name="contents" class="form-control col-9" placeholder="본문 내용을 입력하세요(*필수)"></textarea>
                </div>

                <div class="form-group row">
                    <label class="col-form-label col-2 text-right" for="tags"><strong>태그</strong></label>
                    <input style="background: #E5E5E5" type="text" id="tags" name="tags" class="form-control col-9">
                </div>

                <div class="form-group row">
                    <label class="col-form-label0 col-2 text-right" ><strong>첨부파일</strong></label>
                    <input class="custom-control-input" type="file" id="file" accept=".zip, .jpeg, .gif, .png, .txt, .docx, .hwp" onchange="checkUploadFile(this)">
                    <label for="file" class="btn btn-outline-light">
                        <span>파일 선택</span>
                    </label>
                    <label style="color: white; background: #343a40; border: none" class="form-control col-8" id="fileName" name="fileName"></label>
                    <label class="col-form-label col-9" style="padding-left:150px">
                        <small>압축파일(zip), 이미지파일(jpeg, png, gif), 문서파일(hwp, docx, txt) 만 업로드 가능합니다.<br>
                            최대 10MB까지 업로드가 가능합니다.</small>
                    </label>
                </div>

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
<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../js/bootstrap.js"></script>
<script src="https://kit.fontawesome.com/3197007a76.js" crossorigin="anonymous"></script>
<script type="text/javascript">
    //글쓰기 버튼을 클릭할 시
    $(function () {
        $('#newbtn').on('click',function (e) {
            var title = document.getElementById("title");
            var contents = document.getElementById("contents");
            if (title.value == "") {
                alert('제목이 비어 있습니다.');
                title.focus();
            } else if (contents.value == "") {
                alert('내용이 비어 있습니다.');
                contents.focus();
            }
        })
    });

    //파일 업로드 예외처리
    function checkUploadFile(objFile) {
        var nMaxSize = 10 * 1024 * 1024; //10MB
        var nFileSize = objFile.files[0].size;
        var strFilePath = objFile.value;
        var RegExtFilter = /\.(zip|jpeg|png|gif|hwp|docx|txt)$/i;
        var file = document.getElementById("file");
        var resultFile = file.value.substring(file.value.lastIndexOf("\\") + 1);
        var fileName = document.getElementById("fileName");

        if (nFileSize > nMaxSize) {
            alert("업로드 하신 파일은 10MB를 초과합니다.")
            objFile.outerHTML = objFile.outerHTML; //초기화
        }else if (strFilePath.match(RegExtFilter) == null) {
            alert('해당 파일은 업로드가 불가능합니다.')
            objFile.outerHTML = objFile.outerHTML; //초기화
        } else {
            fileName.innerHTML = resultFile;
        }
    }
    //취소 버튼을 클릭할 시
    $(function() {
        $('#goTolist').on('click', function(e) {
            location.href = 'list.jsp';
        });
    });

    //목록으로 버튼을 클릭시
    $(function () {
        $('#listbtn').on('click', function (e) {
            location.href = 'list.jsp';
        });
    });

</script>
</body>
</html>
