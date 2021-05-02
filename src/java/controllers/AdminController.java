 package controllers;
import beans.Admin;
 import daos.adminDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utility.FileUploader;
 
public class AdminController extends HttpServlet {
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     }
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
         if(op!=null && op.equalsIgnoreCase("update_profile")){
            System.out.println(op);
              Admin admin = new Admin();
              HttpSession session = request.getSession();
             admin = (Admin)session.getAttribute("admin");
          
              
        String imagePath="";
        imagePath = FileUploader.getUploadedPath(getServletContext(), "media/admin", request);
        System.out.println(imagePath);
        if(!imagePath.equals("media/admin/")){
            admin.setImage(imagePath);
        System.out.println(admin.getImage());
        adminDao ad = new adminDao();
             System.out.println(admin.getName());
        if(ad.updateProfile(imagePath, admin.getName())){
            System.out.println("profile updated !");
            response.sendRedirect("admin/dashboard.jsp");
        }
        
        }
     }
 
         if(op!=null && op.equalsIgnoreCase("Change_Password")){
             String password = request.getParameter("password");
             String userid = request.getParameter("userid");
              adminDao ad = new adminDao();
             if(ad.setNewPassword(password, userid)){
                 System.out.println("password has been set successfully!");
                 response.sendRedirect("newsLogin.jsp");
             }else{
                 System.out.println("password not set!");
             }
             
        }
         
    }}
