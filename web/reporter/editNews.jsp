 
<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 10:51:51 AM
    Author     : AKSHAY
--%>

<%@page import="daos.NewsDao"%>
<%@page import="daos.CategoryDao"%>
<%@page import="beans.NewsCategory"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="beans.News,java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding News</title>
        <jsp:include page="base.jsp"></jsp:include>

            <script>

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

                        <jsp:useBean class="beans.News" id="news" scope="session"></jsp:useBean>
                            <center>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-3" style="position: fixed;right:0px;">
                                        <%
                                            if (request.getParameter("submit") != null) {
                                                String cat_ids[] = request.getParameterValues("category");
                                                String cats = "";
                                                for (String c : cat_ids) {
                                                    cats += c + ",";
                                                }
                                                System.out.println("cat:" + cats);
                                                session.setAttribute("catids", cats);
                                            }

                                            String cat = "";
                                            int id = Integer.parseInt(request.getParameter("id"));
                                            NewsDao ndo = new NewsDao();
                                            news = ndo.getById(id);
                                            session.setAttribute("news", news);

                                            ArrayList<NewsCategory> catids = new ArrayList();
                                            catids = ndo.getNewsCategoryById(id);
                                            for (NewsCategory c : catids) {
                                                cat += c.getName() + ",";
                                            }

                                            System.out.println(cat);
                                        %>
                                        <jsp:setProperty name="news" property="*"></jsp:setProperty>
                                            <form action="../NewsController?op=update" method="post" enctype="multipart/form-data" class="form-control">
                                                <img src="../${news.image}" style="width:200px; height: 200px;" id="preview" class="form-control"/> <br/>
                                            <input type="file" name="image" onchange="readURL(this, preview);" class="form-control btn btn-success"/> <br/>
                                            <input type="submit" value="Update " class="btn btn-primary" name="submit"/>
                                        </form>

                                    </div>



                                    <div class="col col-md-9">
                                        <form method="post" class="form-control">
                                            <table class="table">
                                                <br>   <tr><th> <colspan="2"><center><h2>Edit News Here </h2></center></th></tr>
                                                    <tr>
                                                        <td>Enter News Title </td>
                                                        <td><input type="text" name="title" class="form-control" value="${news.title}"/></td>
                                                    </tr> 
                                                    <tr>
                                                        <td>Enter Description </td>
                                                        <td><textarea name="description" rows="10" cols="20" class="form-control">
                                                                ${news.description}
                                                            </textarea> 
                                                        </td>
                                                    <tr>
                                                        <td>Select Categories </td>
                                                        <td>
                                                            <%
                                                                CategoryDao cd = new CategoryDao();
                                                                ArrayList<NewsCategory> categories = new ArrayList();
                                                                categories = cd.getAllRecords();
                                                            for (NewsCategory cate : categories) {%>
                                                            <input type="checkbox" name="category" value="<%=cate.getId()%>" 
                                                                   <%if (cat.contains(cate.getName())) {
                                                       out.println("checked");
                                                   }%>
                                                                   /> <%=cate.getName()%> 
                                                            <%}%>
                                                        </td>
                                                    </tr>

                                            </table>
                                            <input type="submit" value="save and Next" name="submit" id ="submit" class="form-control btn btn-primary"/>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </center>    
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>
