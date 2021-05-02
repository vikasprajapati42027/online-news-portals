 
<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,daos.NewsDao,beans.*,java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>admin dashboard</title>

  <script>

                function submitForm() {
                    document.getElementById("f1").submit();
                }

            </script>

  <!-- Custom fonts for this template-->
  
  <!-- Custom styles for this template-->
  <jsp:include page="base.jsp"></jsp:include>
</head>

<body id="page-top">

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
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          </div>

          <!-- Content Row -->
          <div class="row">

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
                            <a href="detailNews.jsp?id=<%=news.getId()%>" class="btn btn-primary">view more</a>
                            <a href="../NewsController?id=<%=news.getId()%>&op=delete" class="btn btn-outline-danger">Delete</a>
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








