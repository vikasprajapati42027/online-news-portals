package utility;

import java.io.File;
import beans.Reporter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUploader {

   public static String getUploadedPath(ServletContext context,String parentDirectory,HttpServletRequest request)
   {
       String photo="";
       String imagePath="";
       try{
              System.out.println("Multipart data found.......");    
                    //HttpSession session = request.getSession();
                     FileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    List items = null;
                 //   System.out.println("req:"+request);
                    items = upload.parseRequest(request);
                System.out.println("multi op="+items); 
                    Iterator itr = items.iterator();
                    while (itr.hasNext()) {
                        FileItem item = (FileItem) itr.next();
                        if (!item.isFormField()) {
                            photo = item.getName();
                            System.out.println("photo : "+ photo);
                            
                            imagePath = parentDirectory + "/" + photo;
                            File savedFile = new File(context.getRealPath("/") + imagePath);
                            item.write(savedFile);
           
                             
                            }                                          
                        }
                  }catch(Exception e)
                  {
                      System.out.println("Error : "+e.getMessage());
                  }
       return imagePath;
               
   }  
    
    
}
