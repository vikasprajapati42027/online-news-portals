
        <%@page import="daos.QueryDao"%>
<%@page import="beans.Query"%>
<%@page import="beans.News"%>
<%@page import="daos.NewsDao"%>
        <%@page import="java.util.ArrayList"%>
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Topbar Search -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
            <div class="input-group">
              <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
              <div class="input-group-append">
                <button class="btn btn-primary" type="button">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
            <li class="nav-item dropdown no-arrow d-sm-none">
              <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-search fa-fw"></i>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
                <form class="form-inline mr-auto w-100 navbar-search">
                  <div class="input-group">
                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                      <button class="btn btn-primary" type="button">
                        <i class="fas fa-search fa-sm"></i>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </li>

            <!-- Nav Item - Alerts -->
            <%
                     QueryDao qd = new QueryDao();
                     int totalQuery = qd.getRecordsCount();
            %>
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-bell fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter"><%=totalQuery%></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Query Box
                </h6>
                   <%
                          ArrayList<Query> queryList = qd.getAllRecords();
                          for(Query query : queryList){%>
                  <a class="dropdown-item d-flex align-items-center" href="ReplyToQuery.jsp?id=<%=query.getId()%>">
                      <div class="small text-gray-500"><%=query.getName()%></div>
                                        
                    <span class="font-weight-bold">:-<%=query.getMessage()%></span>
                    <%}
                      %>
                  
                    
                </a>
                    
                 <a class="dropdown-item text-center small text-gray-500" href="query.jsp">Show All Alerts</a>
              </div>
            </li>
                     
                 
            <!-- Nav Item - Messages -->
            <%
                NewsDao ndo = new NewsDao();
                int totalNews = ndo.getRecordCount();
            %>
            
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Alerts -->
                <span class="badge badge-danger badge-counter"><%=totalNews%></span>
              </a>
              <!-- Dropdown - Alerts -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
                <h6 class="dropdown-header">
                  Pending News
                </h6>
                   <%
                          ArrayList<News> newsList = ndo.getAllNews();
                          for(News news : newsList){%>
                  <a class="dropdown-item d-flex align-items-center" href="#">
                      <div class="small text-gray-500"><%=news.getTitle()%></div>
                                        
                     <%}
                      %>
                  
                    
                </a>
                    
                 <a class="dropdown-item text-center small text-gray-500" href="pendingNews.jsp">Show All Alerts</a>
              </div>
            </li>
                     
            
            
        <%--    <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fas fa-envelope fa-fw"></i>
                <!-- Counter - Messages -->
                <span class="badge badge-danger badge-counter"><%=totalNews%></span>
              </a>
              <!-- Dropdown - Messages -->
              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="messagesDropdown">
                <h6 class="dropdown-header">
                  Pending News
                </h6>
                  <%
                      ArrayList<News> newslist = ndo.getAllNews("pending");
    for(News news : newslist){%>
                          
                   
                <a class="dropdown-item d-flex align-items-center" href="AllNews.jsp">
                  <div class="dropdown-list-image mr-3">
                      
                      <img class="rounded-circle" src="../<%=news.getImage()%>" alt="">
                      </div>
                  <div class="font-weight-bold">
                    <div class="text-truncate"><%=news.getTitle()%></div>
                        <%}
                  %>
                  </div>
                </a>
                 <a class="dropdown-item text-center small text-gray-500" href="pendingNews.jsp">Read More Messages</a>
              </div>
            </li>  --%>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${admin.name}</span>
             
                <img class="img-profile rounded-circle" src="../${admin.image}">
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="ChangeProfile.jsp">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Profile
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                  Settings
                </a>
                <a class="dropdown-item" href="#">
                  <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                  Activity Log
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

              <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">?</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="logout.jsp">Logout</a>
        </div>
      </div>
    </div>
  </div>

        </nav>