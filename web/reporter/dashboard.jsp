 

<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 10:51:51 AM
    Author     : AKSHAY
--%>
<%@page import="daos.ReporterDao"%>
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


    <link rel="canonical" href="https://getbootstrap.com/docs/4.4/examples/dashboard/">

    <!-- Bootstrap core CSS -->
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

  </head>
  <body>
      
      <%
          if(session.getAttribute("reporter")==null){
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
         
        
       
            <form id="f1" method="get">
                <div class="container"><br><br>
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
                         Reporter reporter = (Reporter)session.getAttribute("reporter");
                        String cat_id = request.getParameter("cat_id");
                        if (cat_id == null || cat_id.equals("")) {
                            rows = ndo.getNewsByLimit(start, end, reporter.getId());
                        } else {
                            rows = ndo.getNewsByCategory(cat_id,reporter.getId());
                        }

                        //  System.out.println("rows:"+rows);
                        for (News news : rows) {%>
                    <div class="card col col-md-4">
                        <img src="../<%=news.getImage()%>" class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title"><%=news.getTitle()%></h5>
                            <%
                                String description = news.getDescription().trim();
                                if (description.length() > 100) {
                                    description = description.substring(0, 100);
                                }
                            %>
                            <p class="card-text"><%=description%></p>
                            <a href="../detailNews.jsp?id=<%=news.getId()%>" class="btn btn-primary">view more</a>
                            <a href="../NewsController?id=<%=news.getId()%>&op=delete" class="btn btn-outline-danger">Delete</a>
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
           
        </form>
          
      </div>

      
    </main>
  </div>
</div>
   </body>
</html>
