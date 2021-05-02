<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.ArrayList,daos.NewsDao,beans.News,beans.Reporter,daos.ReporterDao"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>All News</title>

  <!-- Custom fonts for this template-->
  
  <!-- Custom styles for this template-->
  <jsp:include page="base.jsp"></jsp:include>
    <script>

                function submitForm() {
                    document.getElementById("f1").submit();
                }

            </script>

</head>

<body id="page-top">
    <%
        if(session.getAttribute("admin")==null)
        {
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
            <form id="f1">
          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">List of News</h1>
            <select onchange="submitForm();" name="filter" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" id="filter" >
                <option value="">select</option>
                <option value="">All</option>
                <option value="approved">Approved</option>
                <option value="rejected">Rejected</option>
                <option value="pending">Pending</option>
            </select>
          </div>

          <!-- Content Row -->
          <div class="row table-responsive">
              <table class="table">
                  <tr>
                      <td><b>Title</b></td><td><b>Uploaded by</b></td><td><b>current action</b></td><td><b>Action</b></td>
                      <%
                          NewsDao ndo = new NewsDao();
                          ArrayList<News> newsList =  new ArrayList();
                          ReporterDao rd = new ReporterDao();
                          String op = request.getParameter("filter");
                      System.out.println("op:"+op);
                       if ( op==null || op.equals("")) {
                             newsList = ndo.getAllNews();
                        } else if(op.equals("approved") || op.equals("rejected") || op.equals("pending")){
                            newsList = ndo.getAllNews(op);
                        }
                      %>
                  </tr>
                  <tr>
                        <%for(News news : newsList){%>
                        <td><%=news.getTitle()%></td> 
                        <td><%=rd.getById(news.getReporter_id()).getName()%></td>
                        <td><%=news.getStatus()%></td>
                        <td><a href="updateStatus.jsp?op=update_status&id=<%=news.getId()%>" class="btn btn-primary">View And Change Status</a></td>
                  </tr>
                        <%}
                        
                        %>
                       
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
                        </form>
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
