    <%@page import="beans.Reporter"%>
<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 10:51:51 AM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Jekyll v3.8.6">
        <title>change password</title>

        <link rel="canonical" href="https://getbootstrap.com/docs/4.4/examples/dashboard/">

        <!-- Bootstrap core CSS -->
        <jsp:include page="base.jsp"></jsp:include>
            <!-- Favicons -->
            <link rel="apple-touch-icon" href="/docs/4.4/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
            <link rel="icon" href="/docs/4.4/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
            <link rel="icon" href="/docs/4.4/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
            <link rel="manifest" href="/docs/4.4/assets/img/favicons/manifest.json">
            <link rel="mask-icon" href="/docs/4.4/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
            <link rel="icon" href="/docs/4.4/assets/img/favicons/favicon.ico">
            <meta name="msapplication-config" content="/docs/4.4/assets/img/favicons/browserconfig.xml">
            <meta name="theme-color" content="#563d7c">


            <style>
                .bd-placeholder-img {
                    font-size: 1.125rem;
                    text-anchor: middle;
                    -webkit-user-select: none;
                    -moz-user-select: none;
                    -ms-user-select: none;
                    user-select: none;
                }

                @media (min-width: 768px) {
                    .bd-placeholder-img-lg {
                        font-size: 3.5rem;
                    }
                }
            </style>
            <!-- Custom styles for this template -->
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
        <body>

        <%
           /* if (session.getAttribute("reporter") == null) {
                response.sendRedirect("../newsLogin.jsp");
                return;
            }
        */%>

        <jsp:include page="navbar.jsp"></jsp:include>


            <div class="container-fluid">
                <div class="row">
                <jsp:include page="sidebar.jsp"></jsp:include>

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Dashboard</h1>

                        </div>

                    <%
                          String userid = request.getParameter("userid");
                         System.out.println(userid);
                    %>
                    <h2>Change Password</h2><br>
                    
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
                </main>
            </div>
        </div>
    </body>
</html>
