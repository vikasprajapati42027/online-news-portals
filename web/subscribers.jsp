<%-- 
    Document   : subscribers
    Created on : 24 Feb, 2020, 4:18:27 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,beans.Subscribers,daos.SubscribersDao"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="base.jsp"></jsp:include>
    </head>
    <body>
        <h3>subscribers page</h3><br>
        <div class="container">
            <div class="row">
                <div class="col col-md-6">
                     <form method="post" class="form-control">
                        <input type="text" name="name" placeholder="enter your name here" class="form-control"><br>
                        <input type="email" name="email" required="required" placeholder="enter you email here"  class="form-control"><br>
                        <input type="submit" name="submit" value="subscribe">
                        
                    </form>
                </div>
            </div>
            </div>
        
        
        <%
          //  System.out.println("submit:"+request.getParameter("submit"));
             if(request.getParameter("submit")!=null)
            {%>
                
            <jsp:useBean id="subscribers" class="beans.Subscribers"></jsp:useBean>
              
                <%
                    SubscribersDao sd = new SubscribersDao();
                    Subscribers subscriber = (Subscribers)session.getAttribute("subscribers");
              %>
                <jsp:setProperty name="subscribers" property="*"></jsp:setProperty>
            
              <%      System.out.println(subscriber);
                    if (sd.add(subscriber)){
                        out.println("<script>alert('subscriber added successfully!')</script>");
                    }
            }
        %>
    </body>
</html>
