<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 10:51:51 AM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="daos.ReporterDao,beans.Reporter"%>


<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Jekyll v3.8.6">
        <title>Update Reporter's profile </title>

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
            <script>
                function readURL(input) {
                       // alert('hello');
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();

                        reader.onload = function (e) {
                            preview.src = e.target.result;
                        };

                        reader.readAsDataURL(input.files[0]);
                    }
                }
            </script>
            <!-- Custom styles for this template -->

        </head>
        <body>

        <%
            if (session.getAttribute("reporter") == null) {
                response.sendRedirect("../newsLogin.jsp");
                return;
            }
        %>

        <jsp:include page="navbar.jsp"></jsp:include>


            <div class="container-fluid">
                <div class="row">
                <jsp:include page="sidebar.jsp"></jsp:include>

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                               

                                     <div class="col">
                                    <jsp:useBean id="reporter" class="beans.Reporter" scope="session"></jsp:useBean>

                                    <%
                                        reporter = (Reporter) session.getAttribute("reporter");
                                        ReporterDao rd = new ReporterDao();
                                        reporter = rd.getById(reporter.getId());
                                        session.setAttribute("reporter", reporter);
                                    %>

                                    <center>
                                        <br><br><h1>Edit Details </h1>
                                        <form method="post" class="form-control">
                                             <table width="800" class="table">
                                                <tr>
                                                    <td>Enter name</td>
                                                    <td><input type="text" name="name" required="reqiured" value="${reporter.name}" class="form-control"></td>
                                                </tr>
                                                <tr>
                                                    <td>Enter DOB</td>
                                                    <td><input type="date" name="dob" value="${reporter.dob}" class="form-control"></td>
                                                </tr>
                                                <tr>
                                                    <td>Enter Email</td>
                                                    <td><input type="text" name="email" value="${reporter.email}" class="form-control"></td>
                                                </tr>
                                                <tr>
                                                    <td>Enter gender</td>
                                                    <td><input type="radio" name="gender"  value="male" ${reporter.gender eq "Male" ? "checked":""}>Male
                                                        <input type="radio" name="gender"  value="female" ${reporter.gender eq "Female" ? "checked":""}>Female</td>
                                                </tr>

                                                <tr>
                                                    <td>Enter contact</td>
                                                    <td><input type="text" name="contact" maxlength="10" value="${reporter.contact}" class="form-control"></td>
                                                </tr>

                                            </table>
                                                <input type="submit" name="submit" value="Click here to Check Profile Image" class="form-control btn btn-primary ">
                                        </form>

                                        <%
                                             if (request.getParameter("submit") != null) {%> 
                                        <jsp:setProperty name="reporter" property="*"></jsp:setProperty>

                                            <form action="../ReporterController?op=update" method="post"  enctype="multipart/form-data" class="form-control"> 
                                                <img src="../${reporter.image}" class="img img-thumbnail" width="20%" height="20%" id="preview"/> <br/>
                                            <input type="file" name="photo"   onchange="readURL(this);"/><br/><br>
                                            <input type="submit" value="Update" class="btn btn-primary form-control"/>
                                        </form>  

                                        <%
                                            }
                                        %>
                                    </center>
                                 
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>
