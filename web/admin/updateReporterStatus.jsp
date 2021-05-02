<%-- 
    Document   : dashboard
    Created on : 7 Mar, 2020, 4:00:23 PM
    Author     : AKSHAY
--%>

<%@page import="daos.QueryDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.ArrayList,daos.NewsDao,daos.SubscribersDao,beans.Subscribers,beans.News,beans.Reporter,daos.ReporterDao"%>
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
                
              <%
                                    String op = request.getParameter("op");
                                    System.out.println("op:"+op);
                                    if(op==null || op.equals("")){
                                        
                                            if(request.getParameter("submit")!=null){
                                              ReporterDao rd=new ReporterDao();
                                                String check_ids[] = request.getParameterValues("check");
                                                String status[] = new String[check_ids.length];
                                                int index=0;
                                                for(String s : check_ids){
                                                    status[index++] = request.getParameter("status"+s);
                                                }
                                            if(rd.updateStatus(check_ids, status)){
                                                response.sendRedirect("dashboard.jsp");
                                                return;
                                            }
                                                
                                            }
                             

                                %>
                                        <form method="post">
                                        <table class="table">
                                            <tr>
                                                <td>Name</td><td>current status</td><td>Action</td>
                                            </tr>
                                       <% ReporterDao rd = new ReporterDao();
                                        ArrayList<Reporter> repo = rd.getAllRecords();
                                        for(Reporter r : repo){
                                            %>
                                            <tr>
                                            <input type="hidden" name="ids"id="ids"/>
                                                <td><%=r.getName()%></td>
                                                <td><%=r.getStatus()%></td>
                                                <td><input type="radio" name="status<%=r.getId()%>" id="s1" value="reject">reject
                                                    <input type="radio" name="status<%=r.getId()%>" id="s2" value="block">block</td>
                                                <td><input type="checkbox" name="check" value="<%=r.getId()%>"></td>
                                
                                            </tr>   
                                <%}%>
                                        </table>
                                    <input type="submit" name="submit" value="submit">
                                        </form>
                                        
                                     
                                  
                                <%}     
                                %>
                                  
                                    
                              
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
