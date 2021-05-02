<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

 <%@page contentType="text/html" pageEncoding="UTF-8"  %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>forget password</title>

  <!-- Custom fonts for this template-->
  
  <!-- Custom styles for this template-->
  <jsp:include page="base.jsp"></jsp:include>
   <script>
                function cmpPassword(x, y)
                {
                    if (x === y)
                        return true;
                    else {
                        alert('password not matched..!');
                        return false;
                    }
                }

                /* $("#sendEmail").blur(function () {
                 $("#s1").load("../EmailSender?op=sendEmail&email=" + $(this).val());
                 });*/

                function sendOtp(x, y)
                {
                     ajax = new XMLHttpRequest();
                    ajax.open("GET", "../ReporterController?op=sendotp&email=" + x, true);
                    //alert(x);
                    ajax.send();

                    ajax.onreadystatechange = function ()
                    {
                        if (this.readyState == 4 && this.status == 200)
                        {

                            output = this.responseText;
                            //alert('output:'+output);
                            y.innerHTML = output;
                            document.getElementById("otp1").innerHTML = output;
                            //alert(output);
                             div1.style.display = 'block';

                        }
                    };
                }
                function validateOtp(x,y) {
                    x=x.trim();
                    y=y.trim();
                    
                    if (x===y)
                    {
                       // window.location.assign("SetNewPassword.jsp");
                       alert("matched!");
                    } else {
                        alert("Invalid Otp");
                        return false;
                    }
                }

            </script>

</head>

<body id="page-top">
    <%
         
                          String userid = request.getParameter("userid");
                         System.out.println(userid);
                     
     %>
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
     <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
         <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Change Password</h1>
             </div>

          <!-- Content Row -->
             <div>
                 <span id="otp1" style="visibility: hidden"></span><br/> 
                    <%
                    String uid = request.getParameter("userid");
                    System.out.println("userid:"+uid);
                    %>
                    <form class="form" action="SetNewPassword.jsp">
                        
                        <input type="hidden" name="userid" value="<%=uid%>"><br>
                        <input type="text" name="email" id="email" required="required"/> <br/><br>
                        <input type="button" value="Send OTP" name="otpbtn" class="btn btn-primary" onclick="sendOtp(email.value,s1);"/><br>
                        <span id="s1"> </span><br/>

                        <div id="div1" style="display: none">
                            Type OTP Here <input type="text" name="otp" id="otp"/> <br/>
                            <input type="submit" value="submit" name="validate" class="btn btn-primary" onsubmit="validateOtp(otp.value,otp1.innerHTML);"/>
                        </div>
                         
                    </form>
               
            <!-- Earnings (Monthly) Card Example -->
             </div><!-- Earnings (Monthly) Card Example -->
            
            <!-- Pending Requests Card Example -->
             
          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
                 <!-- Card Body -->
              
            <!-- Pie Chart -->
                 <!-- Card Body -->
              
          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-6 mb-4">

              <!-- Project Card Example -->
             
              <!-- Color System -->
               <!-- Illustrations -->
               
              <!-- Approach -->
               
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
         
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  
  
</body>

</html>
