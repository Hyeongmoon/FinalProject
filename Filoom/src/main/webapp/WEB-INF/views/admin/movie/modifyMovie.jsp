<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 수정:: Filoom</title>
    <link rel="stylesheet" href="resources/css/admin.css" />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- jQuery 연동 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        #admin_right * {
            font-family: "Poppins", sans-serif;
            font-size:25px;
        }

        #admin_title_content {
            display:flex;
            justify-content: space-between;
            color:#493628;
        }

        
        #goBack:hover {
            cursor:pointer;
        }

        #admin_page {
            display:flex;            
        }

        #admin_page div {
            display:inline-block;
        }

        #innerAdmin {
            width:90%;
            margin: 5px 5%;
        }
        #innerAdmin>* {
            margin: 0px 20px;
        }

        /* #admin_page * {
            border:1px solid green;
        } */

        /* 가로를 무조건 480px로 맞추고 세로가 726px보다 짧아질 경우 마진으로  */
        #admin_page img {
            /* width:480px; */
            width:100%;
            /* height:640px; */
            height:100%;
            /* object-fit: cover; */
        }

        #newPoster {
            width:480px;
            height:100%;
            background-color: azure;
            /* margin: 44px 0px; */
        }

        #basicInfo {
            height:100%;
            /* border:1px solid red; */
        }

        th {text-align:left;}

        input/*:not(#runtime)*/, textarea {
            width:100%;
            box-sizing:border-box;
            /* background-color: #f3f3f3; */
            /* 배경색은 보류 - 이러면 입력란이 움푹 들어간 느낌이 생김 */
            color:#493628;
        }
        textarea {max-height:300px;}
        
        #basicInfo .filmrate {
            width:60px; height:60px;
        }
        
        .screentype {
			display:none;
		}
		
		.screentype+label {
		    display:inline-block;
	        width:120px;
	        height:80px;
	        margin: 0px 30px;
	        filter:contrast(0%);
	    }
	    .screentype:checked+label {
	        filter:contrast(100%);
	    }
	    .screentype#imax+label {
	        background: no-repeat;
	        background-image:url('resources/images/icons/IMAX_small.svg');
	    }
	    .screentype#fdx+label {
	        background: no-repeat;
	        background-image:url('resources/images/icons/4DX_small.svg');
	    }
	    .screentype#screenx+label {
	        background: no-repeat;
	        background-image:url('resources/images/icons/SCREENX_small.svg');
	    }

        /* 나중에 admin.css 손볼 때 #movie_submit로 변경 예정 */
        #button_sample {
            position:fixed;
            bottom:30px;
            right:30px;
            width:150px;
            font-size:20px;
            margin: 0px 35px;
        }
    </style>
</head>
<body>
    <div id = "admin_content">
        <jsp:include page="../../common/adminHeader.jsp" />
        
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 여기가 관리자 상단 회원번호, 회원아이디 이런거 적는 곳
                    구상은 각자 알아서~ 
                -->
                <div id = "admin_title_content">
                    <p id="fnName" style="padding-left:33px; font-weight:bold;">영화 수정</p>
                    <p id="goBack" style="padding-right:33px;"
                        onclick="location.href='movielist_ad.mo';">
                        ← 목록으로 돌아가기
                    </p>
                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 여기 안이 관리자 컨텐츠 영역이에요~-->
                <div id ="admin_page" align="center">
                    <!-- align = "center" ?-->
                    <input type="hidden" id="serial" value="1">
                    <div id="innerAdmin">
                        <div id="newPoster">
                            <img id="posterDisplay" src="${pageContext.request.contextPath}/resources/images/posters/${requestScope.target.fileCodename}">
                            <input type="hidden" id="prevpath" value="${requestScope.target.imagePath}">
                            <input type="file" id="posterInput" style="display:none;" onchange="loadImg(this);">
                        </div>



                        <div id="basicInfo">
                            <table>
                            	<tr style='display:none;'>
                            		<td colspan="5"><input type="hidden" id="mno" value="${requestScope.target.movieNo}"></td>
                            	</tr>
                                <tr>
                                    <th>영화 제목</th>
                                    <td colspan="4"><input type="text" id="title" value="${requestScope.target.movieTitle}"></td>
                                </tr>
                                
                                <tr style="display:none;">
                                    <th>확인용</th>
                                    <td><input type="radio" name="filmrate" value="3"  id="rate3"
                                    	<c:if test="${requestScope.target.filmRate eq 3}">checked</c:if>
                                    	></td>
                                    <td><input type="radio" name="filmrate" value="12" id="rate12"
                                    	<c:if test="${requestScope.target.filmRate eq 12}">checked</c:if>
                                    	></td>
                                    <td><input type="radio" name="filmrate" value="15" id="rate15"
                                    	<c:if test="${requestScope.target.filmRate eq 15}">checked</c:if>
                                    	></td>
                                    <td><input type="radio" name="filmrate" value="19" id="rate19"
                                    	<c:if test="${requestScope.target.filmRate eq 19}">checked</c:if>
                                    	></td>
                                </tr>
                                <tr>
                                    <th>상영 등급</th>
                                    <td colspan="4" width=540>
                                    	<div style="display:flex; justify-content: space-between;">
	                                    	<label for="rate3"><img class="filmrate" src="resources/images/posters/3.svg" onclick="rateFilm(3);" alt="ALL"></label>
	                                    	<label for="rate12"><img class="filmrate" src="resources/images/posters/12.svg" onclick="rateFilm(12);" alt="12"></label>
	                                    	<label for="rate15"><img class="filmrate" src="resources/images/posters/15.svg" onclick="rateFilm(15);" alt="15"></label>
	                                    	<label for="rate19"><img class="filmrate" src="resources/images/posters/19.svg" onclick="rateFilm(19);" alt="19"></label>
                                    	</div>
                                    </td>
                                </tr>

                                <tr>
                                    <th>감독</th>
                                    <td colspan="4"><input type="text" id="director" value="${requestScope.target.director}"></td>
                                </tr>
                                <tr>
                                    <th>주요 배우</th>
                                    <td colspan="4"><input type="text" id="cast" value="${requestScope.target.starring}"></td>
                                </tr>
                                <tr>
                                    <th>장르</th>
                                    <td colspan="4"><input type="text" id="genre" value="${requestScope.target.genre}"></td>
                                </tr>
                                
                                <!-- 이미 개봉한 경우 개봉일자를 변경할 수 없음 -->
                                <!-- ↓ 년월일까지 표기라 'date'가 맞음 -->
                                <tr>
                                    <th>개봉일자</th>
                                    <td colspan="4"><input type="date" id="open_date" value="${requestScope.target.openDate}"></td>
                                </tr>
                                <tr>
                                    <th>상영시간</th>
                                    <td><input type="number" id="runtime" value="${requestScope.target.runtime}"></td>
                                    <td colspan="3">분</td>
                                </tr>
                                
                                <!-- 로고별 이미지가 외관상 정렬이 안 되어 있는데 내부적으로는 정렬한 거 맞음
                                	원본 이미지들의 width만 120px로 통일한 거고 원본의 비율 차이 때문에 이건 어쩔 수 없음 -->
                                <tr>
                                    <th>추가 상영 타입</th>
                                    <td colspan="4"><div id="screentype">
                                    	<input type="checkbox" class="screentype" id="imax" value="IMAX">
								        <label for="imax" value="IMAX"></label>
									<input type="checkbox" class="screentype" id="fdx" value="4DX">
								        <label for="fdx"></label>
									<input type="checkbox" class="screentype" id="screenx" value="SCREENX">
								        <label for="screenx"></label>
                                   	</div></td>
                                </tr>
                                
                                <tr>
                                    <th>트레일러 링크</th>
                                    <td colspan="4"><input type="url" id="trailer_link"
                                    	value="${requestScope.target.trailer}"></td>
                                </tr>
                                <tr>
                                    <th>시놉시스</th>
                                    <td colspan="4"><textarea name="" 
                                        rows="3" id="synopsis">${requestScope.target.description}</textarea></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!-- <button>1234</button> -->

                    <input type="button" id ="button_sample"
                     name="movie_submit" value="수정 완료" onclick="submitMovie();">
					<!-- console.log($(':radio:checked').val());
						OR console.log($('input[name=filmrate]:checked').val()); -->
                </div>

            </div>
        </div>
    </div>


    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const navItems = document.querySelectorAll("#nav > ul > li");
    
        navItems.forEach(item => {
            item.addEventListener("click", function () {
                // 모든 항목에서 selected 클래스 제거
                navItems.forEach(nav => nav.classList.remove("selected"));
    
                // 클릭된 항목에 selected 클래스 추가
                this.classList.add("selected");
            });
        });
    });

    // 이미지 첨부시, #posterDisplay 칸이 이미지 미리보기로 바뀜
    $(function() {
    	// 지금 filmRate를 target.getFilmRate()로 받을 거 아냐
//     	let filmRate = target.getFilmRate();
//     	console.log(filmRate);
//     	$("#rate"+filmRate).attr("checked","true");
    	// $("input[name=filmrate][value="+filmRate+"]").attr("checked","true");
        $("#posterDisplay").click(function() {
            $("#posterInput").click();
        });
    });

    function loadImg(inputFile) {

        // if file is selected
        if(inputFile.files.length == 1) {
            console.log("ON");
            let reader = new FileReader();
            reader.readAsDataURL(inputFile.files[0]);

            // 미리보기 띄우기
            reader.onload = function(e) {
                // 'e' : 현재 발생한 event의 정보를 담고 있는 '이벤트 객체'
                // 만들어진 URL 주소가 담기는 곳 = e.target.result

                $("#posterDisplay").attr("src",e.target.result);
                var photo = document.getElementById("posterDisplay").innerHTML;
                //console.log(e.target.result);
            };
        }
        // if not
        else {
            console.log("OFF");
            $("#posterDisplay").attr("src","https://placehold.co/480x716");
        }
    }
    
    function rateFilm(num) {
        // console.log(num);
        let target = $("label[for$="+num+"]");
        $("label *").removeAttr("border");
        // screenType도 label을 쓰긴 하는데 얘네는 border를 안 쓰니까 괜찮음
        target.children().first().attr({
            "border":"3px solid red"
        });
        // 현재 border-style과 border-color가 적용되지 않는 이슈 있음
        // 즉, 현재 버튼 선택시 3px만 적용됨
    }
    
    
    function submitMovie() {
		// 이미지 변경 없을 때는 확인만 함
		console.log($("#posterInput").val());
		
    	/* ↓ 이걸 해야 form 태그없이도 current request is not a multipart request
		안 띄우고 이미지를 넣을 수 있다고 함 */
		let formData = new FormData();
		
		// adding checkbox selection of 'screenType'
		let screenType = [];
		$(".screentype").each(function() {
			if($(this).is(":checked")) {
				screenType.push($(this).val());
			}
		});
		
		let mno = $("#mno").val();
		formData.append("movieNo", mno);
		formData.append("movieTitle", $("#title").val());
		formData.append("filmRate", parseInt($("input[name=filmrate]:checked").val(), 10));
		// 10진수로 parseInt
		formData.append("director", $("#director").val());
		formData.append("starring", $("#cast").val());
		formData.append("genre", $("#genre").val());
		formData.append("openDate", $("#open_date").val());
		formData.append("screenType", screenType.join(","));
		formData.append("runtime", $("#runtime").val());
		// ↑ number로 받고 있어서 굳이 parseInt 안 해도 됨
		formData.append("trailer", $("#trailer_link").val());
		formData.append("description",$("#synopsis").val());
		
		// 포스터를 첨부하지 않은 경우
    	if($("#posterInput").val() === '') {
    		// 혹시나 삭제 과정에서 포스터만 지워지고 영화 정보는 남았는데 거기서 수정을 누를 경우를 대비하여..
    		if($("#prevpath").val() === '') {
    			alert('포스터가 없습니다.');
    			return false;
    		}
    		
    		// confirm : 확인 누르면 true, 취소 누르면 false
    		else if(!confirm("포스터가 변경되지 않았습니다. 그래도 변경하시겠습니까?")) {
    			console.log(false);
    			return false;
    		}
    	} else {
    		// 기존 이미지 경로 추가
			formData.append("prevpath", $("#prevpath").val());
	    	
    		// 이미지 추가
	    	formData.append("img", $("#posterInput")[0].files[0]);
	    	let prevpath = $("#prevpath").val();
	   	}
		
    	$.ajax({
    		url:"admin.updatemovie.mo",
    		type:"post",
    		data: formData,
    		// illegal invocation 오류 방지
    		contentType:false,
    		processData:false,

    		success: function(result) {
    			if (result == "success") {
    				alert('수정되었습니다.');
    				
    				location.href = 'admin.managemovie.mo?movieNo='+mno;
    			} else if (result == "half_success") {
    				alert('영화 정보만 수정되었습니다.');
    				location.href = 'admin.managemovie.mo?movieNo='+mno;
    			} else {
    				// if result == "failure"
    				alert('영화 정보가 수정되지 않았습니다.');
    			}
    		},
    		error: function(result) {
    			alert('DAMN!');
    		}	
    	});
	
    }
    
    </script>
    
</body>
</html>