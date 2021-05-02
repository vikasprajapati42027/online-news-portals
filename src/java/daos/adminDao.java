package daos;

import jdbc.ConnectionPool;
import beans.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class adminDao {

     public Admin getDetailsByLogin(String userid, String password) {
        Admin admin = null;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from admin where userid=? and password=?";
                PreparedStatement smt = con.prepareStatement(sql);
               smt.setString(1, userid);
               smt.setString(2,password);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    admin = new Admin();
                    admin.setImage(rs.getString("image"));
                    admin.setName(rs.getString("name"));
                  //  admin.setUserid(rs.getString("userid"));
                //   admin.setPassword(rs.getString("password"));
                }
                cp.releaseConnection(con);
                smt.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }

        return admin;
    }
     
     public boolean updateProfile(String image,String name){
         boolean status=false;
         ConnectionPool cp = new ConnectionPool().getInstance();
         cp.initialize();
         Connection con = cp.getConnection();
         System.out.println(name);
         System.out.println(image);
         try{
         PreparedStatement ps = con.prepareStatement("update admin set image=? where name=?");
         ps.setString(1, image);
         ps.setString(2,name);
         
         int n = ps.executeUpdate();
         if(n>0){
             status=true;
             System.out.println("successfully updated!");
         }        
         }catch(Exception e){}
         return status;
     }

      public boolean setNewPassword(String password,String userid) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
            
        if (con != null) {
            try {
                String sql = "update admin set password=? where userid=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, password);
                smt.setString(2, userid);
                if (smt.executeUpdate() > 0) {
                     System.out.println("updated!");
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("DBError :" + e.getMessage());
            }
        }

        return status;
    }
}
