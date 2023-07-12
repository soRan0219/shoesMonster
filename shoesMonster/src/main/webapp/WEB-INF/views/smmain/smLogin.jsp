<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<link rel="icon" href="../resources/images/favicon-32x32.png">

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
    font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> Shoes Monster! | </title>

    <!-- Bootstrap -->
    <link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../resources/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="../resources/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../resources/build/css/custom.min.css" rel="stylesheet">
  </head>
  
  
  

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form" style="text-align-last:center;">
          <section class="login_content">
            <form action="" method="post">
              <h1> ShoesMonster Login </h1>
              <div>
                <input type="text" id="ID" name="emp_id" class="form-control" placeholder="Username" required="" />
              </div>
              <div>
                <input type="password" id="password" name="emp_pw" class="form-control" placeholder="Password" required="" />
              </div>
              <div>
                <input type="submit" id="submit" class="btn btn-default submit" value="Log in"
                	style="color: #73879C;">
              </div>
              <div class="clearfix"></div>
              <div class="separator">
              	<div>
              		<a href="/smmain/smLogin"><img src="/resources/images/shoes1.png" height="230" width="230" style="margin-left: 5%;"></a>
              	</div>
                <div class="clearfix"></div>
                <div>
                  <h1><i class="fa fa-paw"></i> Shoes Monster!!</h1>
                  <p>Shoes Monster Co., Ltd. CEO: Park Eon-hyo Address: Samhan Golden Gate 7th floor, 109 Dongcheon-ro, Bujeon-dong, Busanjin-gu, Busan</p>
                </div>
              </div>
            </form>
          </section>
        </div>

      </div>
    </div>
  </body>
</html>
