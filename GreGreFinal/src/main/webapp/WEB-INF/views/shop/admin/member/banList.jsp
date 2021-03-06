<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- taglib는 매 jsp 마다 필요함 -->

<!-- 한글깨질때. -->
<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>아이그레</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/bootstrap.min.css" rel="stylesheet" type="text/css" />    
    <!-- FontAwesome 4.3.0 -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />    
    <!-- Theme style -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/blue.css" rel="stylesheet" type="text/css" />
    <!-- Morris chart -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/morris.css" rel="stylesheet" type="text/css" />
    <!-- jvectormap -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
    <!-- Date Picker -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/datepicker3.css" rel="stylesheet" type="text/css" />
    <!-- Daterange picker -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link href="${pageContext.request.contextPath}/resources/css/admin/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/37.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script>

</script>

  </head>
  <body class="skin-blue">
    <div class="wrapper">
      
      <header class="main-header">
        <!-- Logo -->
        <a href="index2.html" class="logo" style="background-repeat: no-repeat; background-image: url('../images/admin/logo.png'); background-size:contain" ></a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
            
             
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <span class="hidden-xs">쇼핑몰관리자님 안녕하세요</span>
                </a>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left info">
              <p>판매관리자</p>

              <a href="#"><i class="fa fa-circle text-success"></i> 로그인</a>
            </div>
          </div>
          <!-- search form -->
          <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search..."/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>
            </div>
          </form>
          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header">메뉴</li>
            <li class="treeview">
                <a href="#">
                  <i class="fa fa-user"></i>
                  <span>주문관리</span>
                  <i class="fa fa-angle-left pull-right"></i>	
                  <!-- <span class="label label-primary pull-right">4</span> -->
                </a>
                <ul class="treeview-menu">
                  <li><a href="${pageContext.request.contextPath}/shopadmin/admin.do"><i class="fa fa-circle-o"></i>상품 등록/삭제</a></li>
                  <li><a href="orderList.html"><i class="fa fa-circle-o"></i> 주문 현황</a></li>
                  
                </ul>
              </li>
            <li class="treeview">
                <a href="#">
                  <i class="fa fa-user"></i>
                  <span>매출</span>
                  <i class="fa fa-angle-left pull-right"></i>
                  <!-- <span class="label label-primary pull-right">4</span> -->
                </a>
                <ul class="treeview-menu">
                  <li><a href="${pageContext.request.contextPath}/shopadmin/account.do"><i class="fa fa-circle-o"></i>매출조회</a></li>
                </ul>
              </li>
            <li class="treeview">
              <a href="#">
                <i class="fa fa-user"></i>
                <span>회원관리</span>
                <i class="fa fa-angle-left pull-right"></i>
                <!-- <span class="label label-primary pull-right">4</span> -->
              </a>
              <ul class="treeview-menu">
                <li><a href="${pageContext.request.contextPath}/shopadmin/list.do"><i class="fa fa-circle-o"></i> 회원 목록</a></li>
                <li><a href="${pageContext.request.contextPath}/shopadmin/ban.do"><i class="fa fa-circle-o"></i> 회원 탈퇴</a></li>
                <li><a href="${pageContext.request.contextPath}/shopadmin/withdrawll.do"><i class="fa fa-circle-o"></i> 탈퇴 회원 관리</a></li>
              </ul>
            </li>
            <li>
              <a href="">
                <i class="fa fa-bell"></i> <span>신고</span> 
                <i class="fa fa-angle-left pull-right"></i>
                <!-- <small class="label pull-right bg-green">new</small> -->
              </a>
              <ul class="treeview-menu">
                <li><a href="declaration.html"><i class="fa fa-circle-o"></i> 신고 내역</a></li>
              </ul>
            </li>
            <li class="treeview">
              <a href="#">
                <i class="fa fa-edit"></i> <span>게시판</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="${pageContext.request.contextPath }/shopadmin/board.do"><i class="fa fa-circle-o"></i> 게시판 목록</a></li>
              </ul>
            </li>
             <li class="treeview">
              <a href="#">
                <i class="fa fa-share"></i> <span>단체안내</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="mailbox.html"><i class="fa fa-circle-o"></i>단체 이메일</a></li>
                <li><a href="message.html"><i class="fa fa-circle-o"></i> 단체 문자</a></li>
              </ul>
            </li>
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>


        <!-- Right side column. Contains the navbar and content of the page -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
              <h1>
                회원관리
                <small>회원목록</small>
              </h1>
              <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li><a href="#">회원관리</a></li>
                <li class="active">회원목록</li>
              </ol>
            </section>
    
            <!-- Main content -->
            <section class="content">
              <div class="row">
                <div class="col-xs-12">
                  <div class="box">
                    <div class="box-header">
                      <h3 class="box-title">회원 목록</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body">
                      <table id="example2" class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>닉네임</th>
                            <th>생년월일</th>
                            <th>전화번호</th>
                            <th>주소</th>
                            <th>이메일</th>
                            <th>성별</th>
                            <th>나이</th>
                            <th>가입일</th>
                            <th>탈퇴</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                          <tr>
                            <td>test</td>
                            <td>테스트</td>
                            <td>테스트이지롱~</td>
                            <td>1999.05.03</td>
                            <td>010-1234-1234</td>
                            <td>서울시 강남구 역삼동</td>
                            <td>test@naver.com</td>
                            <td>남</td>
                            <td>50</td>
                            <td>2020.03.01</td>
                            <td><input type="button" value="탈퇴"></td>
                          </tr>
                        </tbody>
                        <tfoot>
                        </tfoot>
                      </table>
                    </div><!-- /.box-body -->
                  </div><!-- /.box -->
                </div><!-- /.col -->
              </div><!-- /.row -->
            </section><!-- /.content -->
          </div><!-- /.content-wrapper -->

          <footer class="main-footer">
            <p class="">서울특별시 그래구 그레로 123 </p>
            <p class="">TEL : 육아종합지원센터 02-123-1234 &nbsp;&nbsp;|&nbsp;&nbsp; FAX : 02-456-4567 &nbsp;&nbsp;|&nbsp;&nbsp;Mail : i_gre@gmail.com</p>
            <p>Copyright(c) 2020 아이그레. All rights reserved.</p>
          </footer>
        </div><!-- ./wrapper -->
        <!-- jQuery 2.1.3 -->
        <script src="${pageContext.request.contextPath}/resources/js/admin/jQuery-2.1.3.min.js"></script>
        
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>  
        <!-- jQuery Knob Chart -->
        <script src="${pageContext.request.contextPath}/resources/js/admin/jquery.knob.js" type="text/javascript"></script>
        <!-- Slimscroll -->
        <script src="${pageContext.request.contextPath}/resources/js/admin/jquery.slimscroll.min.js" type="text/javascript"></script>
        <!-- FastClick -->
        <script src='${pageContext.request.contextPath}/resources/js/admin/fastclick.min.js'></script>
        <!-- AdminLTE App -->
        <script src="${pageContext.request.contextPath}/resources/js/admin/app.min.js" type="text/javascript"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="${pageContext.request.contextPath}/resources/js/admin/demo.js" type="text/javascript"></script>
   <!-- page script -->
   <script type="text/javascript">
    $(function () {
      $("#example1").dataTable();
      $('#example2').dataTable({
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bSort": true,
        "bInfo": true,
        "bAutoWidth": false
      });
    });
  </script>
  </body>
</html>