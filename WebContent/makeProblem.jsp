<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.BbsDAO" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name = "viewport" content = "width = device-width", initial-scale = "1">
		<link rel = "stylesheet" href = "css/bootstrap.css">
		<link rel = "stylesheet" href = "css/customized.css">
		<title>ReMoCoN Beta</title>
	</head>
	<body>
		<style type = "text/css">

		</style>
	
		<%
			String userID = null;
			String userLevel = null;
			String userName = null;
		
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
				userLevel = (String) session.getAttribute("userLevel");
				userName = (String) session.getAttribute("userName");
			}
		%>
		
		<%	if ("T".equals(userLevel) == false) { %>
			<script>
				alert("교사만 접근 가능한 페이지입니다.");
				history.back();
			</script>
		<% } %>
		
		<nav class = "navbar navbar-default">
			<div class = "navbar-header">
				<button type = "button" class = "navbar-toggle collapsed"
					data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
					aria-expanded = "false">
						<span class = "icon-bar"></span>
						<span class = "icon-bar"></span>
						<span class = "icon-bar"></span>
				</button>
				
				<a class = "navbar-brand" href="main.jsp"> ReMoCo<b>N</b> </a>
			</div>		
			
			<div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
				<ul class = "nav navbar-nav">
					<li><a href = "main.jsp">메인</a></li>
					<li ><a href = "bbs.jsp">게시판</a></li>
					<% if ("T".equals(userLevel)) { %>
						<li><a href = "manageClass.jsp">내 클래스 관리하기</a></li>
						<li class = "active"><a href = "makeProblem.jsp">문제 출제하기</a></li>
						<li><a href = "listProblem.jsp">과제 부여하기</a><li>
						<li><a href = "evaluate.jsp">평가하기</a></li>
					<% } %>
				</ul>
				
				<ul class = "nav navbar-nav navbar-right">
					<li class = "dropdown">
				<% if (userID == null) { %>
							<a href = "#" class = "dropdown-toggle"
	    	                 data-toggle = "dropdown" role = "button" aria-haspopup = "true"
	        	             aria-expanded = "false">접속하기<span class="caret"></span></a>
								
							<ul class = "dropdown-menu">
								<li><a href = "login.jsp">로그인</a></li>
								<li><a href = "join.jsp">회원가입</a></li>
							</ul>
				<% } else { %>	
							<a href = "#" class = "dropdown-toggle"
	    	                 data-toggle = "dropdown" role = "button" aria-haspopup = "true"
	        	             aria-expanded = "false">회원관리<span class="caret"></span></a>
								
							<ul class = "dropdown-menu">
								<li><a href = "logoutAction.jsp">로그아웃</a></li>
							</ul>
				<% } %>
					</li>
				</ul>
				
				<ul class = "nav navbar-nav navbar-right" style = "margin : 0 auto;">
					<li class = "dropdown">
						<a href = "#" class = "dropdown-toggle"
						data-toggle = "dropdown" role = "button" aria-haspopup = "false"
						aria-expanded = "false">
						<% if (userID != null) { %>
							<b>${userName}</b>(${userID})
							<% if ("T".equals(userLevel)) out.print("선생님, 환영합니다.");
							else if ("S".equals(userLevel)) out.print("학생님, 환영합니다.");
							else out.print("님, 환영합니다" + userLevel + "[오류발생]");} %></a>
					</li>
				</ul>
				
			</div>
		</nav>

		<div class = "container">
			<div class = "row">
			
			<form method = "post" action = "makeProblemAction.jsp" enctype = "multiport/form-data">
				<table class = "table table-striped" style = "text-align : center ; border : 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan = "2" style = "background-color : #eeeeee ; text-align : center;">문제 출제하기</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td colspan = "2"><input type = "text" class = "form-control" placeholder = "문제 제목" name = "proTitle" maxlength = "60"></td>
						</tr>
						<tr>
							<td colspan = "2"><textarea class = "form-control" placeholder = "내용" name = "proContent" maxlength = "8192" style = "height : 400px;"></textarea></td>
						</tr>
						<tr>
							<td colspan = "2">
								<span class = "btn btn-default btn-file" style = "text-align : center;">
									<p>문제와 관련된 이미지가 있을 경우 업로드하세요. 
									<p><input type = "file" name = "proImage">
								</span>
						</tr>

						<tr>
							<td colspan = "2"><p>Relay 시 분배할 함수 설정<br>
								<table class = "table table-striped" style = "text-align : center ; border : 1px solid #dddddd">
									<thead>
										<th style = "background-color : #eeeeee ; text-align : center;">No.</th>
										<th style = "background-color : #eeeeee ; width : 1000px; text-align : center;">함수 역할</th>
										<th style = "background-color : #eeeeee ; text-align : center;">2인 기준 함수 grouping</th>
										<th style = "background-color : #eeeeee ; text-align : center;">3인 기준 함수 grouping</th>
									</thead>
									
									<tbody>
										<% for (int i = 1 ; i <= 10 ; i ++) { %>
										<tr>
											<td><%= i %></td>
											<td><input type = "text" class = "form-control" placeholder = "<%= i %>번째 함수 역할 입력" name = "proFunc<%= i %>" maxlength = "80"></td>
											<td><select name = "divFunc2_<%= i %>" class = "form-control">
													<option value="none">없음</option>
													<option value="A">A</option>
													<option value="B">B</option>
												</select></td>
											<td><select name = "divFunc3_<%= i %>" class = "form-control">
													<option value="none">없음</option>
													<option value="A">A</option>
													<option value="B">B</option>
													<option value="C">C</option>
												</select></td></td>
										</tr>
										<% } %>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan = "2"><p>Online-judge 채점용 답안 작성<br>
								<div style = "text-align : left;">
									<ol>
										<li>Online-judge 방식에 맞추어 input()으로 입력을 받은 것에 대해 출력한다는 전제로 답안을 작성해주시기 바랍니다.</li>
										<li>다만 입력이 불요한 경우 인자 값을 비우시고, 실행 결과만 작성하시면 됩니다.</li>
										<li>Case 별로 각 입력 인자 값은 빈 칸으로 구분해주시기 바랍니다.</li>
										<li>정확도를 위해 '실행 결과'란은 가급적이면 직접 타이핑하는 것보다 교사가 작성한 프로그램의 실행 결과를 drag하여 복사/붙여넣기해주시기 바랍니다.</li>
										<li>채점 정확도를 위해 가급적 5가지 case를 모두 채워주시기 바랍니다.</li>
									</ol>
								</div>
								<table class = "table table-striped" style = "text-align : center ; border : 1px solid #dddddd">
									<thead>
										<th style = "background-color : #eeeeee ; text-align : center;">Case No.</th>
										<th style = "background-color : #eeeeee ; text-align : center;">인자 값</th>
										<th style = "background-color : #eeeeee ; width : 700px; text-align : center;">실행 결과</th>
									</thead>
									
									<tbody>
										<% for (int i = 1 ; i <= 5 ; i ++) { %>
										<tr>
											<td><%= i %></td>
											<td><input type = "text" class = "form-control" placeholder = "<%= i %>번째 case일 때 입력 매개변수" name = "case<%= i %>" maxlength = "80"></td>
											<td><textarea class = "form-control" placeholder = "내용" name = "answerCase<%= i %>" maxlength = "1000" style = "height : 100px;"></textarea></td>
										</tr>
										<% } %>
									</tbody>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan = "2">난이도 선택<br><br>
										<select name = "proLevel" class = "form-control">
											<option value="5">★★★★★ (최상)</option>
											<option value="4">★★★★☆ (상)</option>
											<option value="3">★★★☆☆ (중)</option>
											<option value="2">★★☆☆☆ (하)</option>
											<option value="1">★☆☆☆☆ (최하)</option>
										</select>
							</td>
						</tr>
						
						<tr>
							<td colspan = "2">유형 선택 (2015 개정 중등 정보 교과서 "문제 해결과 프로그래밍" 영역 기반)<br><br>
									<select name = "" class = "form-control">
										<option value="else">알고리즘 대표 유형</option>
										<% String[] arr = {"선택", "버블", "삽입", "셀", "합병", "퀵", "힙", "계수", "기수"}; 
										   for(int i = 0 ; i < arr.length ; i++) { %>
											<option value="a<%= i+1 %>">정렬 - <%= arr[i] %></option>
										<% } %>
										
										<% String[] arr2 = {"순차", "이진"}; 
										   for(int i = 0 ; i < arr2.length ; i++) { %>
											<option value="a<%= arr.length + i+1 %>">탐색 - <%= arr2[i] %></option>
										<% } %>
									</select>  
									<select name = "" class = "form-control">
										<option value="else">자료구조 대표 유형</option>
										<% String[] arr3 = {"순차 리스트(배열 기반)", "연결 리스트", "스택", "큐", "덱"}; 
										   for(int i = 0 ; i < arr3.length ; i++) { %>
											<option value="d<%= i+1 %>">선형구조 - <%= arr3[i] %></option>
										<% } %>
										
										<% String[] arr4 = {"트리", "그래프"}; 
										   for(int i = 0 ; i < arr4.length ; i++) { %>
											<option value="d<%= arr3.length + i+1 %>">비선형구조 - <%= arr4[i] %></option>
										<% } %>
									</select>  
									
									<select name = "" class = "form-control">
										<option value="else">Python3 문법 대표 유형</option>
										<% String[] arr5 = {"선택문(if)","반복문(for/while)", "함수(def)", "재귀함수", "클래스(class)"}; 
										   for(int i = 0 ; i < arr5.length ; i++) { %>
											<option value="s<%= i+1 %>">선형구조 - <%= arr5[i] %></option>
										<% } %>
									</select>  
									
									<br><b>★ 교사가 새 유형을 만들 수 있는 기능을 곧 지원할 예정입니다. ★</b>
							</td>
						</tr>
						
						<tr>
							<td>
								다른 교사와 공유 여부<br><br>
								
								<div class = "btn-group" data-toggle = "buttons">
									<label class = "btn btn-primary ">
											<input type = "radio" name = "isShared" autocomplete = "off" value = "Y">네
									</label>
									
									<label class = "btn btn-primary active">
											<input type = "radio" name = "isShared" autocomplete = "off" value = "N" checked>아니오
									</label>
								</div>
								
							</td>
						</tr>
						
					</tbody>
				</table>
				
				<input type = "submit" class = "btn btn-primary pull-right" value = "저장">
				<br>
				<br>
			</form>
				
				
			</div>
		</div>

		<script src = "https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">		</script>
		<script src = "js/bootstrap.js">		</script>
		
	</body>
</html>