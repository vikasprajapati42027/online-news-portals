 
<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="beans.Reporter"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding Reporter</title>
        <jsp:include page="base.jsp"></jsp:include>

            <script type="text/javascript">

                function readURL(input, preview) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function (e) {
                            preview.src = e.target.result;
                        };

                        reader.readAsDataURL(input.files[0]);
                    }
                }

                $(document).ready(function () {
                    $("#form1").submit(function (e) {
                        x = $("#password").val();
                        y = $("#cpassword").val();
                        if (x === y)
                            return true;
                        else
                        {
                            alert('password not matched !');
                            e.preventDefault();
                        }
                    });

                    $("#userid").blur(function () {
                        $("#s1").load("../ReporterController?op=check_userid&userid=" + $(this).val());
                    });

                    $("#email").blur(function () {
                        $("#s2").load("../ReporterController?op=check_email&email=" + $(this).val());
                    });

                    $("#contact").blur(function () {
                        $("#s3").load("../ReporterController?op=check_contact&contact=" + $(this).val());
                    });

                    $("#dob").blur(function () {
                        var dateString = $(this).val().toString();
                        //alert(dateString);
                        str = dateString.split("-");
                        var yy = str[0]; //year
                        var mm = str[1]; //month
                        var dd = str[2]; //days
                         // Current date calculation
                        var d = new Date();
                        var ds = d.getDate();
                        var ms = d.getMonth();
                        var ys = d.getFullYear();
                        //convert  days from current date as 25 years 
                        var days = ((25 * 12) * 30) + (ms * 30) + ds;
                         // convert days from input value
                        var age = (((ys - yy) * 12) * 30) + ((12 - mm) * 30) + parseInt(30 - dd);
                         if ((days - age) <= '0') {
                            console.log((days - age));
                            document.getElementById('s4').innerHTML = 'Valid';
                            // or return your own script
                        } else {
                            console.log((days - age));
                            document.getElementById('s4').innerHTML = 'age should be greater than or equal to 25';
                            // or return your own script
                        }

                    });


                });

                function checkAccept(x,y)
                {
                    if (x.checked === true)
                        y.disabled = false;
                    else
                        y.disabled = true;
                }


                /*  function ageCal(dob, x)
                 {
                 ajax = new XMLHttpRequest();
                 ajax.open("GET", "../ReporterController?op=check_age&dob=" + dob, true);
                 ajax.send();
                 
                 ajax.onreadystatechange = function () {
                 if (this.readyState == 4 && this.status == 200)
                 x.innerHTML = this.responseText;
                 };
                 } */

            </script>


        </head>

        <body id="page-top">
        <%
            if (session.getAttribute("admin") == null) {
                response.sendRedirect("../newsLogin.jsp");
                return;
            }
        %>
        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp"></jsp:include>
                <!-- End of Sidebar -->

                <!-- Content Wrapper -->
                <div id="content-wrapper" class="d-flex flex-column">

                    <!-- Main Content -->
                    <div id="content">

                        <!-- Topbar -->
                    <jsp:include page="navbar.jsp"></jsp:include>
                        <!-- End of Topbar -->

                        <!-- Begin Page Content -->
                        <div class="container-fluid">

                            <!-- Page Heading -->
                            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                <h1 class="h3 mb-0 text-gray-800">Fill the Reporter Details Here </h1>
                                <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
                            </div>

                            <!-- Content Row -->
                            <div class="row">

                            <jsp:useBean id="reporter" class="beans.Reporter" scope="session"></jsp:useBean>
                                <div class="container">
                                    <div class="row">

                                        <div class="col col-md-3" style="position: fixed;right: 0px;">
                                        <% if (request.getParameter("submit") != null) {%>
                                        <jsp:setProperty name="reporter" property="*"></jsp:setProperty>
                                            <form action="../ReporterController?op=add" method="post" enctype="multipart/form-data">
                                                <img src="../${reporter.image}" style="width:200px;height: 200px" border="2" id="preview" class="form-control"/><br/>
                                            <input type="file" class="btn btn-success form-control" name="image" onchange="readURL(this, preview);"/>
                                            <br/>
                                            <input type="checkbox" name="accept" id="accept" onchange="checkAccept(this, submit1);"/>I accept all term and condition
                                            <input type="submit" value="Add to Database" id="submit1" class="btn btn-primary" disabled="disabled" name="submit"/>
                                        </form>
                                        <%
                                            }%>
                                    </div>



                                    <div class="col col-md-9">
                                        <form method="post" id="form1" class="form">
                                            <table class="table">

                                                <tr>
                                                    <td>Enter Reporter Name </td>
                                                    <td><input type="text" name="name" required="required" value="${reporter.name}" class="form-control" /></td>
                                                </tr> 
                                                <tr>
                                                    <td>Enter Reporter DOB </td>
                                                    <td><input type="date" name="dob" id="dob" value="${reporter.dob}" class="form-control" onblur="ageCal(this.value, sp4)"/>
                                                        <span id="s4"></span>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>Select Gender  </td>
                                                    <td><input type="radio" name="gender" value="Male ${reporter.gender eq "Male" ? "checked":""}" /> Male 
                                                        <input type="radio" name="gender" value="Female ${reporter.gender eq "Female" ? "checked":""}"/> Female 
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>Enter Reporter's Contact </td>
                                                    <td><input type="text" name="contact" value="${reporter.contact}" maxlength="10" id="contact" class="form-control"  />
                                                        <span id="s3"></span>
                                                    </td>
                                                </tr> 

                                                <tr>
                                                    <td>Enter Reporter's Email </td>
                                                    <td><input type="email" name="email"id="email" value="${reporter.email}" class="form-control"  />
                                                        <span id="s2"></span>
                                                    </td>
                                                </tr> 

                                                <tr>
                                                    <td>Enter Reporter's Userid </td>
                                                    <td><input type="text" name="userid" id="userid" class="form-control" value="${reporter.userid}"/>
                                                        <span id="s1"></span>
                                                    </td>
                                                </tr> 

                                                <tr>
                                                    <td>Enter Reporter's Password </td>
                                                    <td><input type="password" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" name="password" id="password" value="${reporter.password}" class="form-control"  />
                                                      </br>  password must contains atleast one lower and 8 char and one special char</td>
                                                </tr> 

                                                <tr>
                                                    <td>Confirm Password </td>
                                                    <td><input type="password" name="cpassword" value="${reporter.password}" id="cpassword" class="form-control"  /></td>
                                                </tr> 

                                                <input type="hidden" name="status" value="approved"/>
                                            </table>
                                            <input type="submit" value="save and Next" name="submit" id ="submit" class="form-control btn btn-primary"/>
                                        </form>                
                                    </div>


                                </div>
                            </div>
                            <!-- Earnings (Monthly) Card Example -->
                            <!-- Earnings (Monthly) Card Example -->

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
                        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                        <a class="btn btn-primary" href="login.html">Logout</a>
                                    </div>
                                </div>
                            </div>
                        </div>


                        </body>

                        </html>
