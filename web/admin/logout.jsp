<%-- 
    Document   : signOut
    Created on : 7 Mar, 2020, 12:01:32 PM
    Author     : AKSHAY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <%
     session.removeAttribute("admin");
     response.sendRedirect("../newsLogin.jsp");
 %>