 package utility;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
 import java.net.URL;
import java.util.concurrent.ThreadLocalRandom;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
 
 public class SmsSender extends HttpServlet {
     
      static String url = "https://www.sms4india.com";
     public static String sendCampaign(String apiKey,String secretKey,String useType, String phone, String message, String senderId){
      try{
          // construct data
        JSONObject urlParameters = new JSONObject();
        urlParameters.put("apikey",apiKey);
        urlParameters.put("secret",secretKey);
        urlParameters.put("usetype",useType);
        urlParameters.put("phone", phone);
        urlParameters.put("message", URLEncoder.encode(message,"UTF-8"));
        urlParameters.put("senderid", senderId);
        URL obj = new URL(url + "/api/v1/sendCampaign");
          // send data
        HttpURLConnection httpConnection = (HttpURLConnection) obj.openConnection();
        httpConnection.setDoOutput(true);
        httpConnection.setRequestMethod("POST");
        DataOutputStream wr = new DataOutputStream(httpConnection.getOutputStream());
        wr.write(urlParameters.toString().getBytes());
        // get the response  
        BufferedReader bufferedReader = null;
        if (httpConnection.getResponseCode() == 200) {
            bufferedReader = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
        } else {
            bufferedReader = new BufferedReader(new InputStreamReader(httpConnection.getErrorStream()));
        }
        StringBuilder content = new StringBuilder();
        String line;
        while ((line = bufferedReader.readLine()) != null) {
            content.append(line).append("\n");
        }
        bufferedReader.close();
        return content.toString();
      }catch(Exception ex){
        System.out.println("Exception at:"+ex.getMessage());
        return "{'status':500,'message':'Internal Server Error'}";
      }
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String op = request.getParameter("op");
        System.out.println("op="+op);
     
        if(op!=null && op.equalsIgnoreCase("sendotp"))
        {
            String mobile = request.getParameter("mobile");
        System.out.println("mobile="+mobile);
            String otp = String.valueOf(ThreadLocalRandom.current().nextInt(100000,999999));
            System.out.println("otp="+otp);
            String output = sendCampaign("8E5N8E2W2VFCCEYU1GE1JDVNMBYNZ3EE","LV24GH7CFWNY2GU9","stage", mobile, otp, "Akshay");
             if (output.contains("200"))
                {
                     out.println("<font color='blue'>OTP Sent !</font>,"+otp);
                     HttpSession session = request.getSession();
                     session.setAttribute("otp", otp);
                }
                else 
                    out.println("<font color='red'> Problem in Sending OTP </font>");
            
            }
        }
    
    }
