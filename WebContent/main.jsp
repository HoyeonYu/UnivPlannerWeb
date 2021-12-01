<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>메인화면</title>
<style TYPE="text/css">

             body {
             scrollbar-face-color: darkgray;
             scrollbar-highlight-color: darkgray;
             scrollbar-3dlight-color: #FFFFFF;
             scrollbar-shadow-color: darkgray;
             scrollbar-darkshadow-color: darkgray;
             scrollbar-track-color: #FFFFFF;
             scrollbar-arrow-color: darkgray;
             width: 1000px;  
             margin: 0 auto;
             }

             tr {margin:0px auto; width:20px; }
             td {margin:0px auto;font-family: "돋움"; font-size: 14pt; color:#000000; background-color:#FFFFFF;}
             th {margin:0px auto;font-family: "돋움"; font-size: 9pt; color:#000000;}
             select {font-family: "돋움"; font-size: 9pt; color:#595959;}
             #userdiv{background-color:rgba(102,153,255,0.2); width:118px;border-radius: 5px;margin-bottom:-12px;}
             #user{font-size: 13pt;}
			 #num_schedule{display:none;}
             .divDotText {

             overflow:hidden;
             text-overflow:ellipsis;

             }
             #year_month{ display: inline-block; margin-top:0px; }
             .div{
                margin-bottom: 10px;                 
                width:200px;
				height:50px;
                display: inline-block;
                text-align:center;
				display:table-cell;
				vertical-align:middle;
            }
            .div_today{
                margin-bottom: 10px;                 
                width:200px;
				height:50px;
                display: inline-block;
                text-align:center;
				display:table-cell;
				vertical-align:middle;
				border-style:solid;
            }

           .divscroll{
            overflow:auto;         
            padding: 5px;
            width:130px;
            height:140px;
            font-size:15px;
           }
           .divscroll::-webkit-scrollbar {
             width: 1px;
              
           }
           .divscroll::-webkit-scrollbar-thumb {
             background-color: white;
             border-radius: 10px;
           }
          .divscroll::-webkit-scrollbar-track {
             background-color: white;
               border-radius: 10px;
             box-shadow: inset 0px 0px 5px white;
           }
 
       </style>
</head>
<%

Calendar cal = Calendar.getInstance();
String strYear = request.getParameter("year");
String strMonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);
String today = Integer.toString(year) + "-" + Integer.toString(month) + "-" + Integer.toString(date);
//System.out.print(today);
if(strYear != null)

{
  year = Integer.parseInt(strYear);
  month = Integer.parseInt(strMonth);
}else{
}

//년도/월 셋팅

cal.set(year, month, 1);

int startDay = cal.getMinimum(java.util.Calendar.DATE);
int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;

 
//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();

SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

%>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">제대로 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="lmsLogin.jsp">LMS 로그인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="https://lms.sungshin.ac.kr/ilos/main/main_form.acl">교육시스템</a></li>
				<li><a href="https://portal.sungshin.ac.kr/sso/login.jsp?destination=/portal/ssu/stuMain">포탈시스템</a></li>
			</ul>
			<%
				// 로그인 하지 않았을 때 보여지는 화면
				if(userID == null){
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
    	</div>
    </nav>       
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<form name="calendarFrm" id="calendarFrm" action="" method="post">

<DIV id="content" style="width:712px;">

<!--날짜 네비게이션  -->

<table width="500" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="WHITE" style="border:1px solid WHITE">

<tr>

<td height="60">

       <table width="500" border="0" cellspacing="0" cellpadding="0">

       <tr>
             <td height="10">
             </td>
       </tr>

       <tr>
             <td align="center">
                    <a href="<c:url value='/main.jsp' />?year=<%=year-1%>&amp;month=<%=month%>" target="_self">
                           <b>&lt;&lt;</b><!-- 이전해 -->
                    </a>

                    <%if(month > 0 ){ %>

                    <a href="<c:url value='/main.jsp' />?year=<%=year%>&amp;month=<%=month-1%>" target="_self">
                           <b>&lt;</b><!-- 이전달 -->
                    </a>

                    <%} else {%>
                           <b>&lt;</b>
                    <%} %>

                    &nbsp;&nbsp;
					<div id='year_month'>
                    <%=year%>년

                    <%=month+1%>월</div>

                    &nbsp;&nbsp;

                    <%if(month < 11 ){ %>

                    <a href="<c:url value='/main.jsp' />?year=<%=year%>&amp;month=<%=month+1%>" target="_self">

                           <!-- 다음달 --><b>&gt;</b>

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="<c:url value='/main.jsp' />?year=<%=year+1%>&amp;month=<%=month%>" target="_self">

                           <!-- 다음해 --><b>&gt;&gt;</b>

                    </a>

             </td>

       </tr>

       </table>

</td>
</tr>
</table>

<br>

<table width="500" border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">

<THEAD>
<TR bgcolor="#CECECE">
       <TD>
       <DIV align="center" class="div"><font color="red">일</font></DIV>
       </TD>

       <TD>
       <DIV align="center" class="div">월</DIV>
       </TD>

       <TD>
       <DIV align="center" class="div">화</DIV>
       </TD>

       <TD>
       <DIV align="center" class="div">수</DIV>
       </TD>

       <TD>
       <DIV align="center" class="div">목</DIV>
       </TD>

       <TD>
       <DIV align="center" class="div">금</DIV>
       </TD>

       <TD>
       <DIV align="center" class="div"><font color="BLUE">토</font></DIV>
       </TD>
</TR>
</THEAD>
<TBODY>
<TR>

<%

//처음 빈공란 표시

for(int index = 1; index < start ; index++ )
{
  out.println("<TD >&nbsp;</TD>");
  newLine++;
}


for(int index = 1; index <= endDay; index++)
{
       String color = "";

       if(newLine == 0){          color = "RED";
       }else if(newLine == 6){    color = "BLUE";
       }else{                     color = "BLACK"; };

 

       String sUse =  Integer.toString(year);
       String sUseDate = Integer.toString(year);
       
       sUse+="-";

       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
       
       sUse += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
       sUse += "-";

       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

       sUse += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
       
       //System.out.print(sUse+"  ");

       int iUseDate = Integer.parseInt(sUseDate);


       String backColor = "WHITE";

       if(iUseDate == intToday ) {

            backColor = "rgba(204,204,204,0.2)";

       }

       out.println("<TD valign='top' align='left' height='40px' bgcolor='"+backColor+"' nowrap>");
     
       %>

       <font color='<%=color%>'>
       <%  
       if(sUse.equals(today))
    	   out.println("<DIV align='center' class='div_today'>");
       else
           out.println("<DIV align='center' class='div'>");
       %>
	 
            	 <%= index %>
		</DIV>
       </font>
 

       <%
       out.println("<BR>");
       /*
       out.println("<DIV class='divscroll'>");
             
       
       UserDAO userDAO = new UserDAO();
       ArrayList<Schedule> list = userDAO.findSchedule(sUse);
       for(int i = 0; i<list.size();i++){
    	    	 String a = "a";
    	    	 System.out.println("num_schedule : " + list.get(i).getnum_schedule());
    	    	 System.out.println("name_schedule : " + list.get(i).getName_schedule());
    	   out.println("<a id='user' href='addschedule.jsp?update=update&num_schedule="+list.get(i).getnum_schedule()+"'><div id='userdiv'>"+list.get(i).getName_schedule()+"</div></a><br>");
       } 
       
       out.println("<BR>");
       out.println("</DIV>");*/

       out.println("</TD>");

       newLine++;

       if(newLine == 7)

       {

         out.println("</TR>");

         if(index <= endDay)

         {

           out.println("<TR>");

         }

         newLine=0;

       }

}

//마지막 공란 LOOP

while(newLine > 0 && newLine < 7)

{

  out.println("<TD>&nbsp;</TD>");

  newLine++;

}

%>

</TR>
</TBODY>
</TABLE>
</DIV>
</form>
</body>
</html>