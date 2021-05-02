<%-- 
    Document   : home
    Created on : 19 Feb, 2020, 11:53:49 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,beans.*,daos.NewsDao,java.util.ArrayList"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Home</title>
        <link rel="icon" type="image/ico" href="assets/images/c2.ico">

        <!-- Bootstrap core CSS -->
         
        <!-- Custom styles for this template -->
        <link href="assets/css/shop-homepage.css" rel="stylesheet">
        
        <jsp:include page="base.jsp"></jsp:include>
            <style>
                /* #grad
                 {
                     height: "100%";
                     background-color:#6633ff;
                     background-image: linear-gradient(purple,yellow);
                 }*/
            </style>
        </head>
        <body>
            <!-- Navigation -->

            <!-- Page Content -->
            <div class="container">
            <jsp:include page="navbar.jsp"></jsp:include>

                <div class="row">

                <jsp:include page="sidebar.jsp"></jsp:include>
                    <!-- /.col-lg-3 -->

                    <div class="col-lg-9">

                    <jsp:include page="crousel.jsp"></jsp:include>
                        <div class="row" id="livenews">

                        <%
                            NewsDao ndo = new NewsDao();
                            int start = request.getParameter("start") != null ? Integer.parseInt(request.getParameter("start")) : 0;
                            int end = 3;
                             int total = ndo.getRecordCount();
                            ArrayList<News> rows = new ArrayList();
                            String cat_id = request.getParameter("cat_id");
                            if (cat_id == null || cat_id.equals("")) {
                                rows = ndo.getNewsByLimit(start, end,"approved");
                            } else {
                                rows = ndo.getNewsByCategory(cat_id,"approved");
                                }
                                
                                for (News news : rows) {%>


                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card h-100">

                                <a href="#"><img class="card-img-top" src="<%=news.getImage()%>" alt=""></a>
                                <div class="card-body">
                                    <h4 class="card-title">
                                        <a href="#"><%=news.getTitle()%></a> 
                                    </h4>
                                </div>
                                <%
                                    String description = news.getDescription().trim();
                                    if (description.length() > 100) {
                                        description = description.substring(0, 100);
                                    }
                                    System.out.println("news id:"+news.getId());
                                %>

                                <p class="card-text"><%=description%></p>



                                <div class="card-footer">
                                    <small class="text-muted"> <a href="detailNews.jsp?id=<%=news.getId()%>" class="btn btn-primary"> View More </a>
                                    </small>
                                </div>

                            </div>
                        </div>

                        <%}%>           



                    </div>
                    <!-- /.row -->

                </div>
                <!-- /.col-lg-9 -->

            </div>
            <!-- /.row -->

        </div>
    <center>
        <%
            int pages = total / end + (total % end == 0 ? 0 : 1);
            for (int i = 0; i < pages; i++) {%>
        <span style="text-decoration: none; align-content: center;  <% if (Math.floor(start / end) == i) {
                out.println("background-color: orange");
            }%>" class="btn btn-dark"><a href="home.jsp?start=<%=end * i%>">Page <%=i + 1%></a></span> 
        <%}
        %>
    </center>
    <span style="float:left"><a href="home.jsp?start=<%=start - end%>" class="btn btn-primary <% if (start == 0) {
            out.println(" disabled");
        }%> ">PREVIOUS</a></span>

    <span style="float:right"><a href="home.jsp?start=<%=start + end%>" class="btn btn-primary <% if (start + end >= total) {
                    out.println(" disabled");
                }%> ">NEXT</a></span>
    <!-- /.container -->

    <!-- Footer -->
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- Bootstrap core JavaScript -->
     <script src="assets/js/bootstrap.bundle.min.js"></script>
    
      <script>
            
           $("#search").click(function (){
                $("#livenews").html("");
            $.get("http://newsapi.org/v2/everything?q="+$("#keyword").val() +"&from=2020-03-22&to=2020-03-23&sortBy=popularity&apiKey=d031a2a296bf47d19d674f0a51e8d02f",function (responseText){
                   news =  responseText;
                   articles = news.articles;
                  // alert(articles[0].title);
                   for(i=0;i<articles.length;i++)
                   {
                       
                        article = '<div class="col-lg-4 col-md-6 mb-4">\
                            <div class="card h-100">\
                                <div id="grad">\
                                <a href="#"><img class="card-img-top" src="'+articles[i].urlToImage +'" alt=""></a>'+
                               ' <div class="card-body">'+
                                   ' <h4 class="card-title">'+
                                       ' <a href="#">' + articles[i].title + '</a>'+ 
                                   ' </h4>'+
                                ' </div> '+
                                  '  <p class="card-text">' + articles[i].description+ ' </p>\
                                </div>\
                                <div id="grad">\
                                <div class="card-footer">\
                                    <small class="text-muted"> <a href="' + articles[i].url+ '" class="btn btn-primary"> View More </a>\
                                    </small>\
                                </div>\
                            </div>\
                            </div>\
                        </div>';
                            $("#livenews").append(article);
                        }
                });
           });
         
        </script>

</body>

</html>
    