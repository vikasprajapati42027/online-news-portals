<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="#">GIST NEWS :</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
       <ul class="navbar-nav ml-auto">
             
                <input type="text" id="keyword" class="form-control" placeholder="Enter keyword here">
                <i class="fa fa-search btn btn-primary" id="search"></i>
 
        </ul>
      <div class="collapse navbar-collapse" id="navbarResponsive">
           
        <ul class="navbar-nav ml-auto">
            <li class="nav-item <%if(request.getRequestURI().contains("home.jsp")) out.println("active");%>">
            <a class="nav-link" href="home.jsp"><i class="fa fa-bars" aria-hidden="true"></i> Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item <%if(request.getRequestURI().contains("about.jsp")) out.println("active");%>">
            <a class="nav-link" href="about.jsp"><i class="fa fa-pencil" aria-hidden="true"></i></i> About</a>
          </li>
          <li class="nav-item <%if(request.getRequestURI().contains("services.jsp")) out.println("active");%>">
            <a class="nav-link" href="services.jsp"><i class="fa fa-wrench" aria-hidden="true"></i> Services</a>
          </li>
          <li class="nav-item <%if(request.getRequestURI().contains("contactUs.jsp")) out.println("active");%>">
              <a class="nav-link" href="contactUs.jsp"><i class="fa fa-mobile" aria-hidden="true"></i> Contact</a>
          </li>
          <li class="nav-item <%if(request.getRequestURI().contains("newsLogin.jsp")) out.println("active");%>">
              <a class="nav-link" href="newsLogin.jsp"><i class="fa fa-user" aria-hidden="true"></i> Login</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
