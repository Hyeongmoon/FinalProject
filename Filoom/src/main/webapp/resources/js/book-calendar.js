
		function renderCalendar() {
        	showCalendar(currentYear, currentMonth);
        }
         
        let movieData = [];
          
        function formatDateTime(date) {
			let yyyy = date.getFullYear();
			let mm = String(date.getMonth() + 1).padStart(2, '0');
			let dd = String(date.getDate()).padStart(2, '0');
			let hh = String(date.getHours()).padStart(2, '0');
			let mi = String(date.getMinutes()).padStart(2, '0');
			let ss = String(date.getSeconds()).padStart(2, '0');
			return yyyy + "-" + mm + "-" + dd + " " + hh + ":" + mi + ":" + ss;
		  }
      
       	$(document).on("click", ".movie_selection", function () {
            selectedMovieNo = $(this).data("movie-no"); 
            console.log("movieNo:", selectedMovieNo);
            $(".movie_selection").removeClass("selected"); 
            $(this).addClass("selected"); 
        });

        $(document).on("click", ".booking-btn", function () {
            if (!selectedMovieNo) {
                alert("영화를 먼저 선택해주세요!"); // 선택되지 않았을 경우 경고
                return;
			}
			$.ajax({
	        	url: "book.ca",
	           	type: "GET",
	            data: { movieNum: selectedMovieNo },
	            success: function (result) {
		            movieData.length = 0;	
		            //console.log(result[0].movieTitle);
		            let newMovies = result.map(item => ({
		            	playingNo: item.playingNo,
		            	playTime: formatDateTime(new Date(item.playTime)),
		            	movieNo: item.movieNo,
		            	screenNo: item.screenNo,
			            status: item.status,
		    	        runTime: item.runtime,
		        	    seatCount: item.occupiedSeats,
		            	totalCount: item.screenCapacity,
		            	title : item.movieTitle
					}));
	
					movieData.push(...newMovies);
	
					//console.log("movieData:", movieData);
		            // 여기 출력 문구 playTime "2024-12-25 13:00:00"
		               
		            renderCalendar();
				},
		        error: function () {
		        	//console.error("AJAX Error");
				},
		        complete: function () {
		        	//console.log("AJAX 연결 완료");
				}
			});
		});

          
		$(function(){
         	//화면이 로드된후 캘린더 보여주기
         	showCalendar(currentYear,currentMonth);
        });
         
        //현재날짜
        const today = new Date();
        //console.log(today);
         
        //현재년월
        let currentYear = today.getFullYear();
        let currentMonth = today.getMonth() ; 
         
        //월 배열
        const months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]; // months[현재월인덱스] =>
         
		//년-월을 나타낼 div요소
		let yearAndMonthDiv = $("#yearAndMonth");
         
		//영화를 선택한경우, 현재 달의 상영정보를 변수에 저장
		//상영정보 클래스에  (RUNTIME + 예약된 좌석수 + 전체좌석수) 추가하면 좋을듯
     
        //영화를 선택했을때 해당하는 달의 영화정보를 json객체 형식으로 변수에 담기
        //달력만들어주기
		function showCalendar(year,month){
			let firstDay = new Date(year, month, 1).getDay(); //요일 일:0~토:6
			let tbody = $("#calendar_body");
			tbody.html("");
            
			//상단에 년,월
			yearAndMonthDiv.text(year+" - "+ (month + 1 ));
			let date = 1;
			let totalDays = daysInMonth(year,month);
			for(let i=0;i<6; i++){
				// let row = document.createElement("tr");
				let row = $("<tr></tr>");
				for(let j=0;j<7;j++){
					//let cell = document.createElement("td");
					let cell = $("<td></td>");
					if(( (i==0) && (j<firstDay) )|| (date>totalDays)) {
						row.append(cell);
					}else{
						cell.text(date);
                     	if( date==today.getDate() && year == today.getFullYear() && month === today.getMonth()){
                     		cell.css("color","red");  //오늘날짜인경우
                     	}
                     	let fullDate = formatDate(new Date(year, month, date));
                     	if(movieData.some(movie=>movie.playTime.startsWith(fullDate))){   
                     		cell.addClass('has_movie');  //클래스속성추가 (달력에 영화가 있는날 표시)
                     	}else{
                     		cell.addClass('no_movie');  //클래스속성추가 (달력에 영화가 있는날 표시)
                     	}
                     	let currentDate = date;
						let cellYear = year;
						let cellMonth = month;
						cell.on('click',function(){
							let selectDate = new Date(cellYear,cellMonth,currentDate);
							showMovieInfo(selectDate);
						});
						row.append(cell);
                         
						date++;
                         
					}
				}
				$("#calendar_body").append(row);
				if(date>totalDays){
                 	break;
				}
			}
		}
		// 선택한 월이 총 몇일인지 구하는 메소드
		function daysInMonth(year,month){
           
			return new Date(year,month+1,0).getDate(); // 0-> 전월의 마지막 일
         
         }
         // Date 를 yyyy-mm-dd 형식으로 변환
         
         function formatDate(date){
             
         	let yyyy = date.getFullYear();
             let mm = String(date.getMonth()+1).padStart(2,'0');
             let dd = String(date.getDate()).padStart(2,'0');
            
             return yyyy+"-"+mm+"-"+dd;
         
         }
         
         //날짜를 클릭했을경우 상영정보 띄어주는 메소드
         function showMovieInfo(date) {
    
			$("#time").html(""); // 기존 내용을 초기화
			const selectDate = formatDate(date);
		    //console.log("Selected Date:", selectDate);
		    //console.log("Movie Data:", movieData);
			let movieInfo = "";
			let movieTitle = ""; // 영화 제목을 저장할 변수

			for (let i = 0; i < movieData.length; i++) {
    			if (movieData[i].playTime.includes(selectDate)) { // 해당 날짜에 상영되는 영화가 있다면
            		let startEndTime = calculationTime(movieData[i].playTime, movieData[i].runTime);
		            // 첫 번째 상영되는 영화의 제목을 가져옴
		            if (!movieTitle) {
		            	movieTitle = movieData[i].title; // 영화 제목 저장
		            }
					let playingNo = movieData[i].playingNo;

					movieInfo += "<div onclick='movieInfoClick()'>" +
								 	"<label for='input" + i + "'>" + startEndTime[0] + " ~ " + startEndTime[1] + 
	 							 		" " + movieData[i].screenNo + "관 " + 
								 		String(movieData[i].seatCount).padStart(2, '0') + "/" + movieData[i].totalCount + 
							 		"</label>" +
								 	"<input type='radio' id='input" + i + "' name='playingNo' value='" + playingNo + "' hidden>" +
								 "</div>";
				}
   			}

			// time 영역에 상영정보 추가
			$("#time").append(movieInfo);

			// 날짜와 영화 제목 업데이트
			$("#movie_date").text(selectDate); // 날짜 표시
			$("#title_date span:first").text(movieTitle); // 영화 제목 업데이트
		}
         
        //상영시간 + 러닝타임 계산해주는 메소드 (24시간형식)
        function calculationTime (playTime ,runTime){
			let startTime = playTime.substring(11,16);
			let [hours, minutes] = startTime.split(":").map(Number);
			minutes += runTime;
			hours += Math.floor(minutes/60);
			minutes %= 60;
			hours %= 24;
 			let endTime = String(hours).padStart(2,'0')+":"+String(minutes).padStart(2,'0');
			return [startTime,endTime];
		}
         
         //상영시간을 클릭했을때 실행할 메소드 : 영화상영번호 넘기기~
         function clickTime(playingNo){
         	alert("클릭됨! 영화상영번호"+playingNo);
			//$(this) 로 div 요소 선택해서 #selectTime 아이디값 부여하고 싶은데 안되네 (선택된 상영정보만 선택,나머지는 해제)
         }
         
         //다음달
         function next(){
         	currentYear=currentMonth===11?currentYear + 1:currentYear;
			currentMonth=(currentMonth+1)%12;
			showCalendar(currentYear,currentMonth);
		}
         
		//이전달
		function previous(){
			//현재달보다 이전달은 넘어갈수 없게 하기
			currentYear=currentMonth===0?currentYear -1:currentYear;
			currentMonth=currentMonth===0? 11 : currentMonth-1;
			showCalendar(currentYear,currentMonth);
		}
		function movieInfoClick(){
			let input = $("#time>div>input");
         	input.each(function(){
				if($(this).prop("checked")){
					$(this).parent().attr("id","selectTime");
				}else{
					$(this).parent().attr("id","");
				}
			});
		}
     
       
      