
 		$(document).ready(function (){
			$("#past2").on("click", function () {
				 $("#title_date span:first").empty(); 
				 $("#title_date span:eq(1)").empty(); 
			     $("#time").empty();
			});
		});
		
		$(document).ready(function () {
			const titleElement = $("#selectMovie_title a");
		    const movieTitle = titleElement.text();
		    if (movieTitle.length > 10) {
		        titleElement.css("font-size", "25px");
		    } else {
		        titleElement.css("font-size", "44px"); // 기본 크기
		    }
		});
		
		$(document).ready(function () {
		    // 검색 버튼 클릭 이벤트
		    $("#searchButton").on("click", function () {
		    	const searchMovieKeyword = $("#searchMovieKeyword").val();
		    	console.log(searchMovieKeyword);
		    });
		});
		
		$(document).ready(function () {
		    $(".movie_selection").on("click", function () {
		        const movieNo = $(this).data("movie-no"); 
		        if (movieNo) {
		            fetchMovieDetails(movieNo);
		        } else {
		            console.error("에러");
		        }
		    });
		});
		
		var contextPath = "${pageContext.request.contextPath}";
	
		function fetchMovieDetails(movieNo) {
		    $.ajax({
		        url: "movie.de",
		        type: "GET",           
		        data: { movieNo: movieNo }, 
		        success: function (data) {
		            let mainMovie = data[0];
		            // 1. 메인 이미지 출력 (fileLevel = 1)
		            let mainImage = data.find(item => item.fileLevel === 1);
		            if (mainImage) {
		            	let mainImagePath = contextPath + "/resources/images/posters/" + mainImage.fileCodename;
		                document.getElementById("thumbnail_img").innerHTML =
		                    "<img src='" + mainImagePath + "' alt='메인 이미지'>";
	                }
		            // 2. 영화 타이틀, 설명, movieNo 출력
		            const titleElement = $("#selectMovie_title a");
				    // 영화 제목 업데이트
				    // 텍스트 길이에 따라 font-size 조정
				    if (mainMovie.movieTitle.length > 10) {
				        titleElement.css("font-size", "25px");
				    } else {
				        titleElement.css("font-size", "44px"); // 기본 크기로 설정 (필요 시 크기 지정)
				    }
				    titleElement.text(mainMovie.movieTitle);
		            $("#selectMovie_summary a").text(mainMovie.description);
		            $("input[name='movieDetailNo']").val(mainMovie.movieNo);
		            const movieNo = mainMovie.movieNo;
		            if (movieNo) {
		            	$("#detailViewButton").attr("onClick", "location.href='detail.mo?movieno=" + movieNo + "'");
		            }
		            
		            // 3. 서브 이미지 출력 (fileLevel = 2)
		            const subImgContainer = document.getElementById("selectMovie_subImg");
	        		subImgContainer.innerHTML = "";
		            let subImages = data.filter(item => item.fileLevel === 2);
		            if (subImages.length > 0) {
		            	const subImgContainer = document.getElementById("selectMovie_subImg");
		                subImages.forEach(function (img, index) {
		                    let subImagePath = contextPath + "/resources/images/posters/" + img.fileCodename;
		                    //console.log(subImagePath);
		                    // 새로운 div 생성
		                    let imgDiv = document.createElement("div");
		                    imgDiv.classList.add("subImg");
	
		                    // 이미지 태그 생성
		                    let image = document.createElement("img");
		                    image.src = subImagePath;
		                    image.alt = "서브 이미지";
	
		                    // 이미지 태그를 div에 추가
		                    imgDiv.appendChild(image);
	
		                    // 부모 컨테이너에 div 추가
		                    subImgContainer.appendChild(imgDiv);
		                });
		            } else {
		                document.getElementById("selectMovie_subImg").innerHTML = "";
		            }
		        },
		        error: function () {
		            console.error("AJAX Error");
		        }
		    });
		}
			