 <%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 10:51:51 AM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="daos.NewsDao,beans.News,daos.ReporterDao,beans.Reporter,java.util.ArrayList"%>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v3.8.6">
    <title>Pending News</title>

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

  </head>
  <body>
      
      <%
          if(session.getAttribute("reporter")==null){
              response.sendRedirect("../newsLogin.jsp");
              return;
          }
      %>
     
        
      
<div class="container-fluid">
  <div class="row table-responsive">
  <jsp:include page="sidebar.jsp"></jsp:include>
  
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
         <table class="table">
            <tr>
                <th>Title</th><th>status</th>
            </tr>
            <%
                Reporter reporter = (Reporter)session.getAttribute("reporter");
                 NewsDao ndo = new NewsDao();
                ArrayList<News> newsList = new ArrayList();
                newsList = ndo.getNewsByReporterId(reporter.getId(),"approved");
                for(News news:newsList){%>
                <tr>
                    <td><%=news.getTitle()%></td>
                    <td><%=news.getStatus()%></td>
                </tr>
                <%}
            %>
        </table>
        
        
      </div>
    </main>
  </div>
</div>
   </body>
</html>
