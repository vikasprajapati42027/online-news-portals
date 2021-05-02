 

<%@page import="daos.QueryDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,daos.adminDao,beans.Admin"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>admin dashboard</title>

        <!-- Custom fonts for this template-->

        <!-- Custom styles for this template-->
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
                            <h2>Change Your Profile</h2> 
                            <!-- Page Heading -->
                            <!-- Content Row -->
                        <jsp:useBean id="admin" class="beans.Admin" scope="session"></jsp:useBean>

                            <div class="row" >

                                <div class="col col-md-3" style="position: fixed;left: 270px;">
                                <jsp:setProperty name="admin" property="*"></jsp:setProperty>
                                    <form action="../AdminController?op=update_profile" method="post" enctype="multipart/form-data">
                                        <input type="hidden" value="${admin.name}" name="name"><br>
                                        <img src="../${admin.image}" style="width:200px;height: 200px" border="2" id="preview" class="form-control"/><br/>
                                    <input type="file" class="btn btn-success form-control" name="image" onchange="readURL(this, preview);"/>
                                    <br/>

                                    <br>  <input type="submit" value="Add to Database" id="submit1" class="btn btn-primary"  name="submit"/>
                                </form>

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


                        </body>

                        </html>
