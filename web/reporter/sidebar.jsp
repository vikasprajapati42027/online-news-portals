 <nav class="col-md-2 d-none d-md-block bg-light sidebar">
      <div class="sidebar-sticky">
        <ul class="nav flex-column">
          <li class="nav-item">
              <a class="nav-link active" href="dashboard.jsp">
                    <img src="../${reporter.image}" style="width: 64px;height: 64px;border-radius: 50%;border-style: solid; "><br><br>
              <span data-feather="home"></span>
              Dashboard <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="addNews.jsp">
              <span data-feather="file"></span>
              <i class="fa fa-plus-square"></i> Add News
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="viewNews.jsp">
              <span data-feather="shopping-cart"></span>
              <i class="fa fa-pencil"></i> Update News
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="editProfile.jsp">
              <span data-feather="users"></span>
             <i class="fa fa-user-md"></i>   Update Profile
            </a>
          </li>
          <li class="nav-item">
              <a class="nav-link" href="ForgetPassword.jsp">
              <span data-feather="bar-chart-2"></span>
              <i class="fa fa-key"></i>  Change Password
            </a>
          </li>
        </ul>

        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
          <span>reports</span>
          <a class="d-flex align-items-center text-muted" href="#" aria-label="Add a new report">
            <span data-feather="plus-circle"></span>
          </a>
        </h6>
        <ul class="nav flex-column mb-2">
          <li class="nav-item">
            <a class="nav-link" href="viewPendingNews.jsp">
              <span data-feather="file-text"></span>
               <i class="fa fa-adjust"></i> Pending News
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="viewApprovedNews.jsp">
              <span data-feather="file-text"></span>
               <i class="fa fa-check-square-o"></i> Approved news
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="viewRejectedNews.jsp">
              <span data-feather="file-text"></span>
                <i class="fa fa-times-rectangle"></i> Rejected News
            </a>
          </li>
           
        </ul>
      </div>
    </nav>
