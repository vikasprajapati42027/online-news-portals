<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

<%@page import="daos.QueryDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,daos.NewsDao,daos.SubscribersDao,beans.Subscribers,beans.News,beans.Reporter,daos.ReporterDao"%>
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
</head>

<body id="page-top">
    <%
        if(session.getAttribute("admin")==null)
        {
            response.sendRedirect("../newsLogin.jsp");
            return;
        }
        
        NewsDao ndo = new NewsDao();
        int totalNews = ndo.getRecordCount();
        ReporterDao rd = new ReporterDao();
        int totalReporters = rd.getRecordsCount();
        SubscribersDao sd = new SubscribersDao();
        int totalSubscribers = sd.getRecordsCount();
        QueryDao qd = new QueryDao();
        int totalQuery = qd.getRecordsCount();
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
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          </div>

          <!-- Content Row -->
          <div class="row table-responsive" >
              <table class="table">
                  <tr>
                  <td><h2 class="h3 mb-0 text-gray-800">Total Number Of News :<%=totalNews%></h2></td>
                  </tr>
                  <tr>
                      <td><h2 class="h3 mb-0 text-gray-800">Total Number Of Reporters : <%=totalReporters%></h2></td>
                   </tr>
                   <tr>
                  <td><h2 class="h3 mb-0 text-gray-800">Total Number Of Subscribers : <%=totalSubscribers%></h2></td>
                   </tr>
                   <tr>
                  <td><h2 class="h3 mb-0 text-gray-800">Total Number Of Queries : <%=totalQuery%></h2></td>
                   </tr>
              </table>
               
            
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
