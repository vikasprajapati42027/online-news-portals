<%-- 
    Document   : SetNewPassword
    Created on : 19 Mar, 2020, 12:11:45 AM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="beans.Reporter"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>
            $(document).ready(function () {
                $("#f1").submit(function (e) {
                    x = $("#password").val();
                    y = $("#cpassword").val();
                    alert(x,y)
                    if (x === y)
                        return true;
                    else
                    {
                        alert('password not matched !');
                        e.preventDefault();
                    }
                });
            });
        </script>
    </head>
    <body>
        <%
         String uid = request.getParameter("userid");
        System.out.println("userid:"+uid);
        %>
        <h1>Set New Password</h1>
        <form  id="f1" action="../ReporterController?op=Change_Password" method="post"> 
            <input type="hidden" name="userid" value="<%=uid%>">
           <input type="password" placeholder="enter new password" pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" name="password" id="password" class="form-control"/>
             password must contains atleast one lower and 8 char and one special char
           <br> <input type="password" placeholder="confirm password" name="cpassword" id="cpassword" class="form-control"  />
  
    <br><input type="submit" name="submit" class="btn btn-primary">

</form>

</body>
</html>
