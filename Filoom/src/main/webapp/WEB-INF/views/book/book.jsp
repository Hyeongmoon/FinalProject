<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <!-- css 구문 -->
	<link rel = "stylesheet" href="resources/css/aaa.css"/>
    <link rel = "stylesheet" href="resources/css/cinema_list.css"/>
    <link rel = "stylesheet" href="resources/css/caa.css"/>
    
    <!-- Js구문 -->
    <script src="resources/js/book-calendar.js"></script>
    <script src="resources/js/book-movie.js"></script>
    
    <style>
        #detail_1, #detail_2, #detail_3,#seat_1, #date, #seat_2,#buttonArea_1, #buttonArea_2, #buttonArea_3 {
            display: none;
        }
        /* 활성화된 요소만 보이도록 설정 */
        .active {
            display: block;
        }
        /* 초기 화면 보이기 (첫 단계) */
        #detail_1, #seat_1, #buttonArea_1 {
            display: block;
        }
        .step {
            display: flex; /* Flexbox 활성화 */
            align-items: center; /* 수직 정렬 */
            justify-content: center; /* 수평 정렬 */
            width: 120px; /* 단계 박스 너비 */
            height: 60px; /* 단계 박스 높이 */
            border-radius: 5px; 
            background-color: #696969;
            font-size: 16px; /* 텍스트 크기 */
            text-align: center; /* 텍스트 중앙 정렬 */
            transition: all 0.3s ease; /* 부드러운 전환 */
        }
        .step.active {
            background-color: #493628; /* 활성화된 단계 배경 */
            color: #D9D9D9; /* 활성화된 단계 텍스트 색 */
        }
        .step.completed {
            background-color: #999999; /* 완료된 단계 배경 */
            color: #313131; /* 완료된 단계 텍스트 색 */
        }
        .step a {
            text-decoration: none; /* 밑줄 제거 */
            color: inherit; /* 부모 색상 따라감 */
            display: block; /* 중앙 정렬을 위해 block으로 설정 */
            cursor: default;
            font-weight : border;
        }
        .transition {
            opacity: 0; /* 투명 상태 */
            transform: translateX(100%); /* 오른쪽으로 이동 */
            position: absolute; /* 위치 고정 */
            width: 100%; /* 화면 너비 */
            transition: opacity 0.5s ease, transform 0.5s ease; /* 전환 효과 */
        }
        /* 활성화 상태 (표시 상태) */
        .transition.active {
            opacity: 1; /* 투명하지 않음 */
            transform: translateX(0); /* 제자리 */
        }
        #selection_detail>a>img{
        	width:20px;
        	height:20px;
        }
        #detailViewButton{
        	width:100px; 
        	height:40px; 
        	background-color: transparent;
        	color:#D9D9D9;
        	font-size : 25px;
        	font-weight:600;
        }
        #detailViewButton>button{
        	background-color: none;
        }
        #searchMovieKeyword{
        	background-color:#313131;
        	border:none;
        	color:white;
        }
        #searchMovieKeyword:focus{
        	border-color: blue;
		  	outline: none;
        }
        #searchButton{
        	font-size:15px;
        }
        #searchButton:hover{
        	background-color:#151515;
        	color:white;
        }
    </style>
</head>
<body>
	<script>
	    $(document).ready(function () {
	        // 현재 URL로 초기 상태를 저장
	        if (!history.state) {
	            history.replaceState({ step: 1 }, "", window.location.href);
	            console.log("초기 상태 설정 완료");
	        }
	
	        // 다음 버튼 클릭 시 단계 이동 처리
	        $("#nextButton").on("click", function () {
	            const currentStep = history.state?.step || 1; // 현재 단계 가져오기
	            const nextStep = currentStep + 1;
	
	            // 히스토리에 새로운 상태 추가
	            history.pushState({ step: nextStep }, "", "/step" + nextStep);
	            console.log("현재 단계:", nextStep);
	        });
	
	        // 뒤로가기 이벤트 처리
	        $(window).on("popstate", function (event) {
	            if (event.originalEvent.state) {
	                console.log("뒤로가기 감지 - 현재 단계:", event.originalEvent.state.step);
	            } else {
	                console.log("초기 상태로 돌아왔습니다.");
	            }
	        });
	    });
	</script>

	<jsp:include page="../common/header.jsp" />	

    <div id = "third_page">
        <!-- 좌석 배치도 들어갈 영역 -->
        <div id = "contents">
            
            
            <div id = "flow">
                <div id = "movieSelect" class="step active">
                    <a>영화 선택</a>
                </div>

                <div id = "dateSelect" class="step">
                    <a>날짜 선택</a>
                </div>
                   
                <div id = "seatSelect" class="step">
                    <a>좌석 선택</a>
                </div>
            </div>

            <div style ="height: 10px;"></div>

			<c:if test="${not empty requestScope.firstMovie}">
    			<div id="seat_1">
        		<!-- 메인 이미지 출력 -->
        			<div id="thumbnail_img">
         			   <c:forEach var="movie" items="${requestScope.firstMovie}">
			                <c:if test="${movie.fileLevel == 1}">
			                    <img src="${pageContext.request.contextPath}/resources/images/posters/${movie.fileCodename}" alt="메인 이미지">
			                </c:if>
					    </c:forEach>
		    	    </div>
		
			        <!-- 영화 상세 정보 출력 -->
					<div id="selectMovie">
						<div id="selectMovie_detail">
							<div id="selectMovie_a">
			                    <!-- 영화 제목 -->
			                    <div id="selectMovie_title">
			                        <a>${requestScope.firstMovie[0].movieTitle}</a>
			                        <div style="float:right;">
			                        	<button id="detailViewButton" onClick="location.href='detail.mo?movieNo=${requestScope.firstMovie[0].movieNo}'">
			                        		상세보기
			                        	</button>
			                        </div>
			                    </div>
			                    <br>
								<!-- 영화 설명 -->
								<div id="selectMovie_summary">
			                        <a>${requestScope.firstMovie[0].description}</a>
			                    </div>
								<input type="hidden" name="movieDetailNo" value="${requestScope.firstMovie[0].movieNo}">
							</div>
						</div>
		
		            <!-- 서브 이미지 출력 -->
		            	<div id="selectMovie_subImg">
			                <c:forEach var="movie" items="${requestScope.firstMovie}">
			                    <c:if test="${movie.fileLevel == 2}">
			                        <div class="subImg">
			                            <img src="${pageContext.request.contextPath}/resources/images/posters/${movie.fileCodename}" alt="서브 이미지">
			                        </div>
			                    </c:if>
			                </c:forEach>
			            </div>
					</div>
				</div>
			</c:if>
            <div id = "seat_2">
    
                <div id ="seat1">
                    <div id = "screen"></div>
                    <div id = "real_seat">
                        <div id="left_seat">
                            <table id="left_table"></table>
                        </div>
                        <div id="middle_seat">
                            <table id="middle_table"></table>
                        </div>
                        <div id="right_seat">
                            <table id="right_table" ></table>
                        </div>
                    </div>
                    <div id ="seat1_blank"></div>
                </div>
            </div>

            <div id = "date" style="display: none;"> 
                <div id="date_area"> 
                    <!-- 월 선택 --> 
                    <div id="month_area">
                        <div onclick="previous()"> < </div>
                        <div id="yearAndMonth"></div>
                        <div onclick="next()">  > </div>
                    </div>

                    <!-- 달력 -->
                    <div id="calendar_area">
                        <table id="date_table"> 
                            <thead>
                                <tr>
                                    <th>Sun</th>
                                    <th>Mon</th>
                                    <th>Tue</th>
                                    <th>Wed</th>
                                    <th>Thr</th>
                                    <th>Fri</th>
                                    <th>Sat</th>
                                </tr>
                            </thead>
                            <tbody id="calendar_body"></tbody>
                        </table>
                    </div>
                </div>     
            </div>
        </div>
     
        <!-- 예매 정보 확인 영역 -->
        <div id = "contents2">
            <div id = "detail_1">
                <div id = "searchMovie" style="width:500px; height:30px; margin:auto;" >
	                <form action="movie.sea" method="get">
				        <input type="text" id="searchMovieKeyword" autocomplete='off' name="searchMovieKeyword" style="width:400px; height:30px; margin:auto; margin-left:10px">
				        <button type="submit" id="searchButton" style="width:75px; height:30px">검색</button>
				    </form>
                </div>
                <div id = "detail_content">
                <c:forEach var="b" items="${ requestScope.list }">
				    <div id="movie_selection_${b.movieNo}" class="movie_selection" data-movie-no="${b.movieNo}">
			            <input type="hidden" name="movieNo" value="${b.movieNo}">
			            <div id="selection_img">
			                <img src="${pageContext.request.contextPath}/resources/images/posters/${b.fileCodename}" alt="메인이미지">
			            </div>
			            <div id="selection_detail">
			            	<br>
			                <a><img src="resources/images/posters/${b.filmRate}.svg"></a>
			                <a>${b.movieTitle}<a><br>
			                <a>${b.openDate} 개봉</a><br>
			                <a>러닝타임 : ${b.runtime} 분</a>
			            </div>
				   </div>
				</c:forEach>
				
			</div>

		</div>				

	<!-- 영화 정보 스크립트-->                   
	<script>	</script>


            
		<div id = "buttonArea_1">

			<button id = "booking_1" class="booking-btn" data-movie-no="${b.movieNo}">영화 선택</button> <br>
               
		</div>
            
            
            
	<!-- 달력 스크립트 -->            
	<script>	</script>
      
  		<div id = "detail_2">
              
            
			<div id="movie_time">
			    <div id="title_date">
			        <span></span> 
			        <span id="movie_date" style="font-size:30px"></span>
		        </div>
		        <div id="time"></div>
		    </div>
		</div>
         
		<div id = "buttonArea_2">
		    <button id = "booking_2">시간 선택</button> <br>
		    <button id = "past2" class="past">이전</button>
		</div>
		
		
		
	<!-- 좌석 상택 -->		
	<script>
       	// 임시 예약 상태: 예약된 좌석
  		const reservedSeats = {
		// left: ["L1-1", "L2-2"],
		// middle: ["M3-3", "M4-5"],
 		    // right: ["R5-1"]    		
  		};
	
  		// 좌석 생성 함수
  		function generateSeats(tableId, rows, cols, prefix, reserved) {
  		    const table = document.getElementById(tableId);
  		    for (let i = 1; i <= rows; i++) {
  		        const row = document.createElement("tr");
  		        for (let j = 1; j <= cols; j++) {
  		            const seatId = prefix + i + '-' + j;
  		            const cell = document.createElement("td");
  		            const button = document.createElement("button");
  		            button.textContent = seatId;
  		            button.dataset.id = seatId;
  		
  		            // 예약 상태 적용
  		            if (reserved.includes(seatId)) {
  		                button.classList.add("reserved");
  		                button.disabled = true;
  		            }
  		
  		            // 클릭 이벤트 추가
  		            button.onclick = function() {
  		                handleSeatClick(button);
  		            };
  		            cell.appendChild(button);
  		            row.appendChild(cell);
  		        }
  		        table.appendChild(row);
  		    }
  		}
  		
  		function updateReservedSeats(seatData) {
  		    seatData.forEach(function (seat) {
  		        const seatNo = seat.seatNo;

  		        // 좌석 번호에 따라 해당 영역에 추가
  		        if (seatNo.startsWith("L")) {
  		            if (!reservedSeats.left.includes(seatNo)) {
  		                reservedSeats.left.push(seatNo);
  		            }
  		        } else if (seatNo.startsWith("M")) {
  		            if (!reservedSeats.middle.includes(seatNo)) {
  		                reservedSeats.middle.push(seatNo);
  		            }
  		        } else if (seatNo.startsWith("R")) {
  		            if (!reservedSeats.right.includes(seatNo)) {
  		                reservedSeats.right.push(seatNo);
  		            }
  		        }
  		    });

  		    console.log("Updated reservedSeats:", reservedSeats);
  		}
	    		
   		// 좌석 클릭 이벤트 처리 함수
   		/*
   		
   		
   		function handleSeatClick(button) {
   		    const inputField = document.getElementById("movieSeat");
   		    const seatId = button.dataset.id;
   		
   		    if (button.classList.contains("selected")) {
   		        // 선택 해제
   		        button.classList.remove("selected");
   		        inputField.value = inputField.value
   		            .split(", ")
   		            .filter(function(id) {
   		                return id !== seatId;
   		            })
   		            .join(", ");
   		    } else {
   		        // 선택
   		        button.classList.add("selected");
   		        inputField.value = inputField.value
   		            ? inputField.value + ", " + seatId
   		            : seatId;
   		    }
   		}
   		*/
	    		
   		function handleSeatClick(button) {
   		    const inputField = document.getElementById("movieSeat");
   		    const seatId = button.dataset.id;
   		    
   		    let selectedValue = $("#time input[name='playingNo']:checked").val();
   		    
   		    if (button.classList.contains("selected")) {
   		        
   		        button.classList.remove("selected");
   		        inputField.value = inputField.value
   		            .split(", ")
   		            .filter(function (id) {
   		                return id !== seatId;
   		            })
   		            .join(", ");
   		        $.ajax({
     	                url: "book.fd",         
     	                type: "GET",            
     	                data: { 
     	                	seatId: seatId,
     	                	playingNo: selectedValue
     	                
     	                }, 
     	                success: function (response) {
     	                	
     	                	alert("좌석 예약을 취소하셨습니다.");
     	                	
     	                },error:{
     	                	
     	                },complete:{
     	              
     	                }
     	                
   		        });
     	                
     	                
   		        
   		    } else {
   		        
   		        button.classList.add("selected");
   		        inputField.value = inputField.value
   		            ? inputField.value + ", " + seatId
   		            : seatId; 
   	
   		        $.ajax({
   		            url: "book.err", // 중복 확인 URL
   		            type: "GET",
   		            data: { seatId: seatId, playingNo: selectedValue },
   		            success: function (response) {
   		            	
   		            	console.log("성공시 response" + response);
   		            	
   		                if (response === "SUCCESS") {
   		                   
   		                	// 중복이 없으면
   		                    $.ajax({
   		                        url: "book.fb",
   		                        type: "GET",
   		                        data: { seatId: seatId, playingNo: selectedValue },
   		                        success: function (response) {
   		                            
   		                            console.log("좌석 예약 성공:", response);
   		                            alert("좌석 예약에 성공하셨습니다.");
   		                            
   		                        },
   		                        error: function (error) {
   		                            console.error("좌석 예약 오류:", error);
   		                        },complete: function(){
   		                        	
   		                        	console.log("book.fb 실행");	
   		                        }
   		                    });
   		                    
   		                    
   		                } else {
   		                   
   		                    alert(response); // "이미 값이 존재합니다! 다른 좌석을 선택해주세요!"
   		                    button.classList.remove("selected");
   		                }
   		            },
   		            error: function (error) {
   		                console.error("중복 확인 오류:", error);
   		            }
   		        });
    		        
    		        
   		    }

   		    // inputField의 value 업데이트
   		    inputField.setAttribute("value", inputField.value);
   		}
   		

  		
  		
  		function refreshSeats(a) {
  		    // 좌석 테이블 초기화
  		    document.getElementById("left_table").innerHTML = "";
  		    document.getElementById("middle_table").innerHTML = "";
  		    document.getElementById("right_table").innerHTML = "";

			if(a == 1){	    		    
	   		    
	   		    generateSeats("left_table", 5, 2, "L", reservedSeats.left);
	   		    generateSeats("middle_table", 5, 8, "M", reservedSeats.middle);
	   		    generateSeats("right_table", 5, 2, "R", reservedSeats.right);
			
			}
			if(a==2){
			
	   		    generateSeats("left_table", 4, 2, "L", reservedSeats.left);
	   		    generateSeats("middle_table", 4, 8, "M", reservedSeats.middle);
	   		    generateSeats("right_table", 4, 2, "R", reservedSeats.right);
			
			}
			
		}
        	
       	$(document).ready(function () {
       		
       	    $("#booking_2").click(function () {
       	        
       	        let selectedValue = $("#time input[name='playingNo']:checked").val();
       	     	
       	        const inputField2 = document.getElementById("movieTitle");
       	   		const inputField3 = document.getElementById("movieDate");
       	   		
       	   		inputField2.setAttribute("value", inputField2.value); 
       	        
       	   		if (selectedValue) {
       	            
       	            $.ajax({
       	                url: "book.se",         
       	                type: "GET",            
       	                data: { playingNo: selectedValue }, 
       	                success: function (response) {
       	                   
       	                	const movieTitle = response[0] && response[0].movieTitle ? response[0].movieTitle : "제목 없음";
       	                    inputField2.value = "제목 :" +movieTitle; // input value 설정
       	                    inputField2.setAttribute("value", movieTitle);

       	                    //formatDateTime(new Date(item.playTime))
       	                   
       	                    //console.log(movieTitle);
        	                    
       	                    const playTime = response[0] && response[0].playTime ? response[0].playTime : "00:00:00.0";
                             const runtime = response[0] && response[0].runtime ? response[0].runtime : 0;

                             const timePartMonth = playTime.split(",")[1].trim(); 
                             const timePartTime = playTime.split(",")[2].trim(); 
                             
                             // console.log("플타임 : " +playTime);
                             // console.log("런타임 : " + runtime);
                            	// console.log("타임파트1 : " + timePartMonth);
                            	// console.log("타임파트2 : " + timePartTime);
                             
                            	function convertTo24Hour(time) {
                            	    const parts = time.split(" "); // ["1:00:00", "PM"]
                            	    const timePart = parts[0]; // "1:00:00"
                            	    const meridiem = parts[1]; // "PM"
                            	    
                            	    let timeParts = timePart.split(":").map(Number); // [1, 0, 0]
                            	    let hours = timeParts[0];
                            	    const minutes = timeParts[1];
                            	    const seconds = timeParts[2];
                            	    
                            	    if (meridiem === "PM" && hours !== 12) {
                            	        hours += 12; // 오후(PM) 처리
                            	    } else if (meridiem === "AM" && hours === 12) {
                            	        hours = 0; // 자정(AM) 처리
                            	    }
                            	    
                            	    // 두 자리 숫자로 시간, 분, 초 포맷팅
                            	    const formattedHours = hours < 10 ? "0" + hours : hours.toString();
                            	    const formattedMinutes = minutes < 10 ? "0" + minutes : minutes.toString();
                            	    const formattedSeconds = seconds < 10 ? "0" + seconds : seconds.toString();
                            	    
                            	    return formattedHours + ":" + formattedMinutes + ":" + formattedSeconds;
                            	}

                            	// 변환된 시간
                            	const convertedTime = convertTo24Hour(timePartTime);
                            	//console.log("변환된 시간: " + convertedTime); // 출력: "HH:mm:ss"
                            	
                             
                             const startTime = convertedTime.substring(0, 5); // "HH:mm"
                             const startHours = parseInt(startTime.split(":")[0], 10);
                             const startMinutes = parseInt(startTime.split(":")[1], 10);
                           
                          //console.log("시작시간 : " +startTime);
                          //console.log("시작시 : " + startHours);
                          //console.log("시작분 : " + startMinutes);
                          
                          let endHours = startHours;
                          let endMinutes = startMinutes + runtime;

                          if (endMinutes >= 60) {
                              endHours += Math.floor(endMinutes / 60);
                              endMinutes = endMinutes % 60;
                          }
                          
                          //console.log(endHours);
                          //console.log(endMinutes);
                          
                          const endTime = (endHours < 10 ? "0" + endHours : endHours) + ":" + (endMinutes < 10 ? "0" + endMinutes : endMinutes);

                          // console.log("playTime:", playTime, "Type:", typeof playTime);
                          
                          // movieDate 설정 (20xx-xx-xx HH:mm~HH:mm 형식)
                          const movieDate = playTime.substring(0, 6) + " " + startTime + "~" + endTime;
                          inputField3.value = "시간 : " + movieDate; 
                          
                          // console.log("무비데이터" + movieDate);
                          
                          inputField3.setAttribute("value", movieDate);
       	                	
       	                    // 기존 reservedSeats 배열 초기화
       	                	reservedSeats.left = [];
       	                    reservedSeats.middle = [];
       	                    reservedSeats.right = [];

       	                    if (Array.isArray(response)) {
       	                        response.forEach(function (seat) {
       	                          	const seatNo = seat.seatNo;

       	                            if (seatNo) {
       	                                if (seatNo.startsWith("L")) {
       	                                    if (!reservedSeats.left.includes(seatNo)) {
       	                                        reservedSeats.left.push(seatNo);
       	                                    }
       	                                } else if (seatNo.startsWith("M")) {
       	                                    if (!reservedSeats.middle.includes(seatNo)) {
       	                                        reservedSeats.middle.push(seatNo);
       	                                    }
       	                                } else if (seatNo.startsWith("R")) {
       	                                    if (!reservedSeats.right.includes(seatNo)) {
       	                                        reservedSeats.right.push(seatNo);
       	                                    }
       	                                }
       	                            }
       	                        });
       	                    }

       	                    // 좌석 상태를 새로 렌더링
       	                    const screenNo = response[0]?.screenNo;
       	                     if (screenNo === 1) {
                        refreshSeats(1);
                  
       	                     } else if (screenNo === 2) {
                     
       	                    	refreshSeats(2);
                    	 } else {
                   
                   	 	console.error("Unknown screenNo:", screenNo);
                   
                    	 }  
       	                     
       	                   $("#movieSeat").val(""); // movieSeat 초기화
       	                     
       	               
       	                },
       	                error: function (xhr, status, error) {
       	                   
       	                    alert("예약 요청 실패: " + error);
       	                    window.location.reload();
       	                
       	                }
       	            });
       	        } else {
       	            alert("시간을 선택해주세요!");
       	          	window.location.reload();
       	        }
       	    });
       	});	
       	
       	

	</script>
            
            <div id = "detail_3" >
                
                <div id = "detail_content_3">
                
                    <input type ="text" id ="movieTitle" readonly><br>
                    <input type ="text" id ="movieDate" readonly><br>
                    <input type ="text" id ="movieSeat" readonly >

                </div>

            </div>

            
            <div id = "buttonArea_3">

                <button id = "booking_3" >결제 진행</button> <br>
                <button id = "past3" class="past">이전</button>
                
            </div>

			

			<script>
			    // 공통 AJAX 요청 함수
			    function sendAjaxForSeat(seatId, playingNo) {
			        if (seatId && playingNo) {
			            
			            $.ajax({
			                url: "book.re", 
			                type: "POST", 
			                data: {
			                    seatId: seatId,
			                    playingNo: playingNo
			                },
			                success: function (response) {
			                    console.log("book.re 호출 성공:", response);
			
			                },
			                error: function (xhr, status, error) {
			                    console.error("book.re 호출 실패:", error);
			                }
			            });
			        } else {
			            console.error("seatId 또는 playingNo 값이 유효하지 않습니다.");
			        }
			    }
			
			    // #past3 클릭 이벤트 처리
			    $("#past3").on("click", function (event) {
			        event.preventDefault(); // 기본 동작 방지
			        // console.log("이전 버튼 클릭");
			
			        const seatId = $("#movieSeat").val();
			        const playingNo = $("#time input[name='playingNo']:checked").val();
			
			        // console.log("seatId:", seatId);
			        // console.log("playingNo:", playingNo);
			
			        sendAjaxForSeat(seatId, playingNo);
			    });
			
			    // 화면 벗어남(페이지 종료 또는 탭 이동) 이벤트 처리
			    function handlePageExit() {
			        const seatId = $("#movieSeat").val();
			        const playingNo = $("#time input[name='playingNo']:checked").val();
			
			        // console.log("화면 벗어남 - seatId:", seatId, "playingNo:", playingNo);
			
			        sendAjaxForSeat(seatId, playingNo);
			    }
			
			    // beforeunload 이벤트
			    $(window).on("beforeunload", function () {
			        handlePageExit();
			    });
			
			    // visibilitychange 이벤트    
			    function handlePageVisibilityChange() {
			        if (document.visibilityState === "hidden") {
			            handlePageExit();
			        }
			    }
			    document.addEventListener("visibilitychange", handlePageVisibilityChange);
			    
			   
			    
			    $(document).ready(function () {
			        $("#booking_3").on("click", function () {
			        
			        	console.log("클릭");
			        	const seatId = $("#movieSeat").val();
					    const playingNo = $("#time input[name='playingNo']:checked").val();
			            
					     
			            if (!playingNo) {
			                alert("상영 시간을 선택해주세요.");
			                return;
			            }
			            if (!seatId) {
			                alert("좌석을 입력해주세요.");
			                return;
			            }

			            var seatIds = seatId.split(",");

			            
			            var form = document.createElement("form");
			            form.method = "POST";
			            form.action = "/filoom/paymentForm.pm";

			            // playingNo 값을 추가
			            var playingNoInput = document.createElement("input");
			            playingNoInput.type = "hidden";
			            playingNoInput.name = "playingNo";
			            playingNoInput.value = playingNo;
			            form.appendChild(playingNoInput);

			            // seatIds 값을 추가
			            seatIds.forEach(function (seat) {
			                var seatInput = document.createElement("input");
			                seatInput.type = "hidden";
			                seatInput.name = "seatNos"; // 동일한 이름으로 여러 값을 전달
			                seatInput.value = seat.trim();
			                form.appendChild(seatInput);
			            });
			            
			            //beforeUlnolad, visibilitychaange 이벤트 제거
			            $(window).off("beforeunload");
			            document.removeEventListener("visibilitychange", handlePageVisibilityChange);

			            // 동적으로 생성한 form을 body에 추가하고 제출
			            document.body.appendChild(form);
			            form.submit();
			        });
			    });
			    
			</script>

        </div>

    </div>

    <script>
    let currentStep = 0;

	// 단계별 매핑
	const steps = [
	    { detailId: "detail_1", seatId: "seat_1", buttonAreaId: "buttonArea_1", nextButtonId: "booking_1" },
	    { detailId: "detail_2", seatId: "date", buttonAreaId: "buttonArea_2", nextButtonId: "booking_2" },
	    { detailId: "detail_3", seatId: "seat_2", buttonAreaId: "buttonArea_3", nextButtonId: "booking_3" },
	];
	function updateStepIndicator() {
	    const steps = ["movieSelect", "dateSelect", "seatSelect"];
	    steps.forEach((stepId, index) => {
	        const stepElement = document.getElementById(stepId);
	        if (index === currentStep) {
	            stepElement.classList.add("active"); // 현재 단계
	            stepElement.classList.remove("completed");
	        } else if (index < currentStep) {
	            stepElement.classList.add("completed"); // 완료된 단계
	            stepElement.classList.remove("active");
	        } else {
	            stepElement.classList.remove("active", "completed"); // 나머지 단계
	        }
	    });
	}
	
	// 단계 초기화 시 호출
	function initializeSteps() {
	    steps.forEach((step, index) => {
	        document.getElementById(step.detailId).style.display = index === currentStep ? "block" : "none";
	        document.getElementById(step.seatId).style.display = index === currentStep ? "block" : "none";
	        document.getElementById(step.buttonAreaId).style.display = index === currentStep ? "block" : "none";
	    });
	    updateStepIndicator();
	}
	
	// 이전/다음 버튼 클릭 시 호출
	steps.forEach((step, index) => {
	    document.getElementById(step.nextButtonId).addEventListener("click", function () {
	        if (currentStep < steps.length - 1) {
	            document.getElementById(steps[currentStep].detailId).style.display = "none";
	            document.getElementById(steps[currentStep].seatId).style.display = "none";
	            document.getElementById(steps[currentStep].buttonAreaId).style.display = "none";
	
	            currentStep++;
	            document.getElementById(steps[currentStep].detailId).style.display = "block";
	            document.getElementById(steps[currentStep].seatId).style.display = "block";
	            document.getElementById(steps[currentStep].buttonAreaId).style.display = "block";
	            
	            updateStepIndicator(); // 단계 업데이트
	        }
	    });
	});
	
	document.querySelectorAll(".past").forEach((btn) => {
	    btn.addEventListener("click", function () {
	        if (currentStep > 0) {
	            document.getElementById(steps[currentStep].detailId).style.display = "none";
	            document.getElementById(steps[currentStep].seatId).style.display = "none";
	            document.getElementById(steps[currentStep].buttonAreaId).style.display = "none";
	
	            currentStep--;
	            document.getElementById(steps[currentStep].detailId).style.display = "block";
	            document.getElementById(steps[currentStep].seatId).style.display = "block";
	            document.getElementById(steps[currentStep].buttonAreaId).style.display = "block";
	            
	            
	            
	            updateStepIndicator(); // 단계 업데이트
	        }
	    });
	});
	/////////////////
	
      document.addEventListener("DOMContentLoaded", function () {
      
      	const movieSelections = document.querySelectorAll("#movie_selection");

       movieSelections.forEach((selection) => {
           selection.addEventListener("click", () => {
              
               movieSelections.forEach((s) => s.classList.remove("selected"));
              
               selection.classList.add("selected");
               
           });
       });
   });


	
	
	
	
	
	   


	


    

    </script>
    
    <jsp:include page="../common/footer.jsp" />	
</body>
</html>