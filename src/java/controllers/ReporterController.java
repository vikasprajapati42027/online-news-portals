package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import beans.Reporter;
import daos.ReporterDao;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletContext;
import utility.EmailSender;
import utility.FileUploader;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class ReporterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String op = request.getParameter("op");
        System.out.println("op:" + op);

        if (op != null && op.equalsIgnoreCase("sendotp")) {
            String email = request.getParameter("email");
            System.out.println("email:" + email);
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

            ReporterDao rd = new ReporterDao();

            //String mailTo = request.getParameter("email");
            String recipients = email;
            String otp = String.valueOf(ThreadLocalRandom.current().nextInt(100000, 999999));

            String message = "your OTP to change password is : " + otp;
            String subject = "OTP to change password";

            try {
                EmailSender.sendEmail(host, port, user, pass, recipients, subject, message);
                String resultMessage = "The e-mail was sent successfully";
                out.println(otp);

//    response.sendRedirect("admin/query.jsp");
            } catch (Exception ex) {
                ex.printStackTrace();
                String resultMessage = "There were an error: " + ex.getMessage();
            }

        }

        if (op != null && op.equalsIgnoreCase("check_userid")) {
            String userid = request.getParameter("userid");
            ReporterDao rd = new ReporterDao();
            if (userid == null || userid.equals("")) {
                out.println("<font size='4'>Plase provide Userid</font>");
                return;
            }
            if (rd.isUserIdExist(userid)) {
                out.println("<font color='red' size='4'>Sorry This Userid already Exist!</font>");
            } else {
                out.println("<font color='blue' size='4'>Congrats! this userid is available!!</font>");
            }

        }

        if (op != null && op.equalsIgnoreCase("check_email")) {
            String email = request.getParameter("email");
            ReporterDao rd = new ReporterDao();
            if (email == null || email.equals("")) {
                out.println("<font size='4'>Plase provide Userid</font>");
                return;
            }
            if (rd.isEmailExist(email)) {
                out.println("<font color='red' size='4'>Sorry This email already Exist!</font>");
            } else {
                out.println("<font color='blue' size='4'>Congrats! this email is available!!</font>");
            }
        }

        if (op != null && op.equalsIgnoreCase("check_contact")) {
            String contact = request.getParameter("contact");
            ReporterDao rd = new ReporterDao();
            if (contact == null || contact.equals("")) {
                out.println("<font size='4'>Plase provide contact no.</font>");
                return;
            }
            if (rd.isContactExist(contact)) {
                out.println("<font color='red' size='4'>Sorry This contact already Exist!</font>");
            } else {
                out.println("<font color='blue' size='4'>Congrats! this contact is available!!</font>");
            }
        }

        /*  if(op!=null && op.equalsIgnoreCase("check_age"))
         {
             String dob = request.getParameter("dob");
            // String x[] = dob.split(" ");
             //System.out.println("dob:"+dob);
             Date date1=null;
        
              ReporterDao rd = new ReporterDao();
             if(dob==null || dob.equals("") )
             {
                 out.println("<font size='4'>Plase provide dob</font>");
                return;
             }
             try{
        date1=new SimpleDateFormat("dd/MM/yyyy").parse(dob);  }
        catch(Exception e){}
        System.out.println(dob+"\t"+date1);
        String d = new SimpleDateFormat("yyyy-MM-dd").format(date1);
        System.out.println(d);
    
             if(rd.ageCalcuater(d))
                 out.println("<font color='red' size='4'>Sorry, Your age is above 25!</font>");
            else
               out.println("<font color='blue' size='4'>Congrats!!</font>");
         }*/
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String op = request.getParameter("op");

        if (op != null && op.equalsIgnoreCase("add")) {
            HttpSession session = request.getSession();
            Reporter reporter = (Reporter) session.getAttribute("reporter");
            System.out.println("reporter name:"+reporter.getName());
            ReporterDao rd = new ReporterDao();

            String ImagePath = "";
            System.out.println("request : "+request);
            ImagePath = FileUploader.getUploadedPath(getServletContext(), "media/reporter", request);
            reporter.setImage(ImagePath);
            
            String pWord = reporter.getPassword();
            String encodedPassword = Base64.getEncoder().encodeToString(pWord.getBytes("UTF-8"));
            reporter.setPassword(encodedPassword);

            if (rd.add(reporter)) {
                session.removeAttribute("reporter");
                out.println("Reproter Added Successfully !");
                response.sendRedirect("admin/dashboard.jsp");
            }
        }

        if (op != null && op.equalsIgnoreCase("update")) {
            HttpSession session = request.getSession();
            Reporter reporter = (Reporter) session.getAttribute("reporter");
            ReporterDao rd = new ReporterDao();

            String imagePath = "";
            imagePath = FileUploader.getUploadedPath(getServletContext(), "media/reporter", request);
            if (imagePath.equals("media/reporter/")) {
                reporter.setImage(reporter.getImage());
            } else {
                reporter.setImage(imagePath);
            }

            if (rd.update(reporter)) {
                session.removeAttribute("reporter");
                out.println("Reproter Added Successfully !");
                response.sendRedirect("admin/dashboard.jsp");
            }
        }
        
        if(op!=null && op.equalsIgnoreCase("Change_Password")){
             String password = request.getParameter("password");
             String userid = request.getParameter("userid");
              ReporterDao rd = new ReporterDao();
             if(rd.setNewPassword(password, userid)){
                 System.out.println("password has been set successfully!");
                 response.sendRedirect("reporter/dashboard.jsp");
             }else{
                 System.out.println("password not set!");
             }
             
        }
    }

}
