<%-- 
    Document   : home
    Created on : 19 Feb, 2020, 11:53:49 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,beans.Query"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Contact Us</title>
        <link rel="icon" type="image/ico" href="assets/images/contact.ico"> 

        <!-- Bootstrap core CSS -->
        <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="assets/css/shop-homepage.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/animate.min.css">

        <jsp:include page="base.jsp"></jsp:include>
        <style>
            body{
    background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}
.contact-form{
    background: #fff;
    margin-top: 10%;
    margin-bottom: 5%;
    width: 70%;
}
.contact-form .form-control{
    border-radius:1rem;
}
.contact-image{
    text-align: center;
}
.contact-image img{
    border-radius: 6rem;
    width: 11%;
    margin-top: -3%;
    transform: rotate(29deg);
}
.contact-form form{
    padding: 14%;
}
.contact-form form .row{
    margin-bottom: -7%;
}
.contact-form h3{
    margin-bottom: 8%;
    margin-top: -10%;
    text-align: center;
    color: #0062cc;
}
.contact-form .btnContact {
    width: 50%;
    border: none;
    border-radius: 1rem;
    padding: 1.5%;
    background: #dc3545;
    font-weight: 600;
    color: #fff;
    cursor: pointer;
}
.btnContactSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    color: #fff;
    background-color: #0062cc;
    border: none;
    cursor: pointer;
}
        </style>
        </head>

        <body>

            <!-- Navigation -->
        <jsp:include page="navbar.jsp"></jsp:include>
            <!-- Page Content -->
            <div class="container contact-form">
            <div class="contact-image">
                <img src="assets/images/rocket.png" alt="rocket_contact"/>
            </div>
            <form method="post">
                <h3>Drop Us a Message</h3>
               <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <input type="text" name="name" class="form-control" placeholder="Your Name *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="text" name="email" class="form-control" placeholder="Your Email *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="text" name="contact" class="form-control" placeholder="Your Phone Number *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="submit" name="submit" class="btnContact" value="Send Message" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <textarea name="message" class="form-control" placeholder="Your Message *" style="width: 100%; height: 150px;"></textarea>
                        </div>
                    </div>
                </div>
            </form>
</div>
             
        <!-- /.container -->
        
        <!-- Footer -->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- Bootstrap core JavaScript -->
        <script src="assets/jquery/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>

    </body>
    
    
    <%
        if(request.getParameter("submit")!=null)
        {
            Connection con=null;
            PreparedStatement ps = null;
        
    %>
    
    <jsp:useBean id="query" class="beans.Query" scope="page"></jsp:useBean>
    <jsp:setProperty name="query" property="*"></jsp:setProperty>
    
    <%
     try{
            Class.forName("com.mysql.jdbc.Driver");
             con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gist","root","axay");
             ps = con.prepareStatement("insert into query (name,contact,email,message)values(?,?,?,?)");
           ps.setString(1,query.getName());
           ps.setString(2,query.getContact());
           ps.setString(3,query.getEmail());
           ps.setString(4,query.getMessage());
           
            int n =ps.executeUpdate();
            con.close();
            ps.close();
            if (n>0)
                out.println("<script> alert('We will Soon give you update ');</script>");
        
     }catch(Exception e)
     {
         System.out.println("Error : "+e.getMessage());
     }
     }
    %>
     

</html>
