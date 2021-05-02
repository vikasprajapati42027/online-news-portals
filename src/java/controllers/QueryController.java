 
package controllers;

import utility.EmailSender;
import java.io.IOException;
import daos.QueryDao;
import beans.Query;
 import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;

 public class QueryController extends HttpServlet {
      
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     }
    
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("id:"+id);
        
         
            String host;
            String port;
            String user;
            String pass;
            //reads SMTP server setting from web.xml file 
            ServletContext context = getServletContext();
            host = context.getInitParameter("host");
            port = context.getInitParameter("port");
            user = context.getInitParameter("user");
            pass = context.getInitParameter("pass");
            
            QueryDao q = new QueryDao();
            
            //String mailTo = request.getParameter("email");
            String recipients= q.getById(id).getEmail();   
             String message = request.getParameter("msg");
             String subject = "Reply by admin";
             
          try {
           EmailSender.sendEmail(host, port, user, pass,recipients, subject,message);
            String resultMessage = "The e-mail was sent successfully";
            response.sendRedirect("admin/query.jsp");
              }
          catch (Exception ex) {
            ex.printStackTrace();
           String resultMessage = "There were an error: " + ex.getMessage();
        }  
            
 }
  
}
