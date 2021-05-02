<%-- 
    Document   : viewNews
    Created on : 12 Feb, 2020, 9:54:35 AM
    Author     : AKSHAY bestial
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,daos.NewsDao,beans.*,java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="base.jsp"></jsp:include>      
            <script>

                function submitForm() {
                    document.getElementById("f1").submit();
                }

            </script>
        </head>
        <body>
            <form id="f1" method="get">
                <div class="container">
                    <div class="row">

                        <select onchange="submitForm();" name="cat_id" id="cat_id" class="dropdown dropdown-header form-control">
                            <option value="-1" >select news category</option>
                            <option value="">All News</option>
                        <%

                            NewsDao ndo = new NewsDao();
                            ArrayList<NewsCategory> category = new ArrayList();
                            category = ndo.getNewsCategory();
                            for (NewsCategory cat : category) {%>
                        <option value="<%=cat.getId()%>"><%=cat.getName()%><br/>

                        <%}


                        %>
                    </select>

                    <%                    
                        int start = request.getParameter("start") != null ? Integer.parseInt(request.getParameter("start")) : 0;
                        int end = 3;
                        int total = ndo.getRecordCount();
                        ArrayList<News> rows = new ArrayList();
                        String cat_id = request.getParameter("cat_id");
                        if (cat_id == null || cat_id.equals("")) {
                            rows = ndo.getNewsByLimit(start, end);
                        } else {
                            rows = ndo.getNewsByCategory(cat_id);
                        }

                        //  System.out.println("rows:"+rows);
                        for (News news : rows) {%>
                    <div class="card col col-md-4">
                        <img src="media/news/<%=news.getImage()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%=news.getTitle()%></h5>
                            <%
                                String description = news.getDescription().trim();
                                if (description.length() > 100) {
                                    description = description.substring(0, 100);
                                }
                            %>
                            <p class="card-text"><%=description%></p>
                            <a href="detailNews.jsp?id=<%=news.getId()%>" class="btn btn-primary">view more</a>
                            <a href="NewsController?id=<%=news.getId()%>&op=delete" class="btn btn-outline-danger">Delete</a>
                            <a href="editNews.jsp?id=<%=news.getId()%>" class="btn btn-outline-primary">update</a>
                        </div>
                    </div>

                    <% } %>

                </div>
            </div>


            <center>
                <%
                    int pages = total / end + (total % end == 0 ? 0 : 1);
                    for (int i = 0; i < pages; i++) {%>
                <span style="text-decoration: none; align-content: center;  <% if (Math.floor(start / end) == i) {
               out.println("background-color: orange");
           }%>" class="btn btn-dark"><a href="viewNews.jsp?start=<%=end * i%>">Page <%=i + 1%></a></span> 
                <%}
                %>
            </center>
            <span style="float:left"><a href="viewNews.jsp?start=<%=start - end%>" class="btn btn-primary <% if (start == 0) {
              out.println(" disabled");
          }%> ">PREVIOUS</a></span>

            <span style="float:right"><a href="viewNews.jsp?start=<%=start + end%>" class="btn btn-primary <% if (start + end >= total) {
                out.println(" disabled");
            }%> ">NEXT</a></span>
            <br><center> <a href="addNews.jsp" class="btn btn-outline-primary">Add News</a></center>

        </form>
    </body>
</html>
