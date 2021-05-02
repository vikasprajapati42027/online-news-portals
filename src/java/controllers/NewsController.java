package controllers;

import beans.*;
import daos.*;
import utility.FileUploader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


 
public class NewsController extends HttpServlet {
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        
        String op = request.getParameter("op");
        if(op!=null && op.equalsIgnoreCase("delete"))
        {
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("id:"+id);
            NewsDao ndo = new NewsDao();
            if(ndo.removeById(id))
            {
                response.sendRedirect("reporter/viewNews.jsp");
            }
        }
        
     }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String op = request.getParameter("op");
          PrintWriter out = response.getWriter();
        response.setContentType("text/html");
       
        if(op!=null && op.equalsIgnoreCase("add")){
            HttpSession session = request.getSession();
            News news = (News)session.getAttribute("news");
            String catids = (String) session.getAttribute("catids");
            NewsDao nd = new NewsDao();
            String imagePath ="";
            imagePath = FileUploader.getUploadedPath(getServletContext(), "media/news", request);
            news.setImage(imagePath);
            if(nd.add(news, catids)){
                session.removeAttribute("news");
                session.removeAttribute("catids");
                out.println("News added Successfully !!");
                response.sendRedirect("reporter/dashboard.jsp");
            }
        }
        
        if(op!=null && op.equalsIgnoreCase("setPassword")){
            String password = request.getParameter("password");
            System.out.println("password:"+password);
            HttpSession session = request.getSession();
            Admin admin = (Admin)session.getAttribute("admin");
            adminDao ad = new adminDao();
             
        }
        
           if(op!=null && op.equalsIgnoreCase("update")){
            HttpSession session = request.getSession();
            News news = (News)session.getAttribute("news");
            //int id = Integer.parseInt(request.getParameter("id"));
               //System.out.println("id:"+id);
            String catids = (String) session.getAttribute("catids");
             System.out.println("catids:"+catids);
            NewsDao nd = new NewsDao();
              String imagePath ="";
            imagePath = FileUploader.getUploadedPath(getServletContext(), "media/news", request);
               System.out.println("imagepath:"+imagePath);
            if(imagePath.equals("media/news/"))
                news.setImage(news.getImage());
            else
                news.setImage(imagePath);
                
            if(nd.update(news, catids)){
                 session.removeAttribute("news");
                session.removeAttribute("catids");
                out.println("News updated Successfully !!");
                response.sendRedirect("reporter/dashboard.jsp");
            }
        }
     }
 
}
