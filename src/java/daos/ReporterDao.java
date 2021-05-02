package daos;

import beans.Reporter;
import jdbc.ConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpSession;

public class ReporterDao {

    public boolean add(Reporter reporter) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "Insert into reporter(name,dob,gender,contact,email,image,userid,password, status)values(?,?,?,?,?,?,?,?,?)";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, reporter.getName());
                smt.setString(2, reporter.getDob());
                smt.setString(3, reporter.getGender());
                smt.setString(4, reporter.getContact());
                smt.setString(5, reporter.getEmail());
                smt.setString(6, reporter.getImage());
                smt.setString(7, reporter.getUserid());
                smt.setString(8, reporter.getPassword());
                smt.setString(9, reporter.getStatus());
                if (smt.executeUpdate() > 0) {
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Database Error :" + e.getMessage());
            }
        }

        return status;
    }

    public boolean remove(int id) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "Delete from reporter where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, id);

                if (smt.executeUpdate() > 0) {
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return status;
    }

    public Reporter getById(int id) {
        Reporter reporter = null;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, id);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    reporter = new Reporter();
                    reporter.setId(rs.getInt("id"));
                    reporter.setName(rs.getString("name"));
                    reporter.setDob(rs.getString("dob"));
                    reporter.setGender(rs.getString("gender"));
                    reporter.setUserid(rs.getString("userid"));
                    reporter.setPassword(rs.getString("password"));
                    reporter.setImage(rs.getString("image"));
                    reporter.setContact(rs.getString("contact"));
                    reporter.setEmail(rs.getString("email"));
                    reporter.setStatus(rs.getString("status"));
               }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return reporter;
    }

    public ArrayList<Reporter> getAllRecords() {

        ArrayList<Reporter> reporters = new ArrayList<Reporter>();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter";
                PreparedStatement smt = con.prepareStatement(sql);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Reporter reporter = new Reporter();
                    reporter.setId(rs.getInt("id"));
                    reporter.setName(rs.getString("name"));
                    reporter.setDob(rs.getString("dob"));
                    reporter.setGender(rs.getString("gender"));
                    reporter.setUserid(rs.getString("userid"));
                    reporter.setPassword(rs.getString("password"));
                    reporter.setImage(rs.getString("image"));
                    reporter.setContact(rs.getString("contact"));
                    reporter.setEmail(rs.getString("email"));
                    reporter.setStatus(rs.getString("status"));
                   reporters.add(reporter);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return reporters;
    }

     public ArrayList<Reporter> getAllRecords(String op) {
         System.out.println("op:"+op);
        ArrayList<Reporter> reporters = new ArrayList<Reporter>();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where status=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1,op);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Reporter reporter = new Reporter();
                    reporter.setId(rs.getInt("id"));
                    reporter.setName(rs.getString("name"));
                    reporter.setDob(rs.getString("dob"));
                    reporter.setGender(rs.getString("gender"));
                    reporter.setUserid(rs.getString("userid"));
                    reporter.setPassword(rs.getString("password"));
                    reporter.setImage(rs.getString("image"));
                    reporter.setContact(rs.getString("contact"));
                    reporter.setEmail(rs.getString("email"));
                    reporter.setStatus(rs.getString("status"));
                   reporters.add(reporter);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return reporters;
    }
    
    public ArrayList<Reporter> getRecordByLimit(int start, int end) {

        ArrayList<Reporter> reporters = new ArrayList<Reporter>();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter limit ?,?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, start);
                smt.setInt(2, end);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Reporter reporter = new Reporter();
                    reporter.setId(rs.getInt("id"));
                    reporter.setName(rs.getString("name"));
                    reporter.setDob(rs.getString("dob"));
                    reporter.setGender(rs.getString("gender"));
                    reporter.setUserid(rs.getString("userid"));
                    reporter.setPassword(rs.getString("password"));
                    reporter.setImage(rs.getString("image"));
                    reporter.setContact(rs.getString("contact"));
                    reporter.setEmail(rs.getString("email"));
                    reporter.setStatus(rs.getString("status"));
                   reporters.add(reporter);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return reporters;
    }

    public int getRecordsCount() {

        int total = 0;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select count(*) from reporter";
                PreparedStatement smt = con.prepareStatement(sql);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return total;
    }

    public boolean update(Reporter reporter) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "update Reporter set name=?,dob=?,gender=?,contact=?,email=?,image=?  where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, reporter.getName());
                smt.setString(2, reporter.getDob());
                smt.setString(3, reporter.getGender());
                smt.setString(4, reporter.getContact());
                smt.setString(5, reporter.getEmail());
                 smt.setString(6, reporter.getImage());
                smt.setInt(7, reporter.getId());
                if (smt.executeUpdate() > 0) {
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

    public boolean isUserIdExist(String userid) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where userid=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, userid);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return status;
    }

    public boolean isContactExist(String contact) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where contact=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, contact);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return status;
    }

    public boolean isEmailExist(String email) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where email=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, email);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    status = true;
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return status;
    }
    
    public boolean ageCalcuater(String dob)
    {
        boolean status = false;
    /* Date date1=null;
        try{
        date1=new SimpleDateFormat("dd/MM/yyyy").parse(dob);  }
        catch(Exception e){}
        System.out.println(dob+"\t"+date1);
        String d = new SimpleDateFormat("yyyy-MM-dd").format(date1);
        System.out.println(d);
      */  
        String[] date = dob.split("-");
         int year = Integer.parseInt(date[0]);
         int month = Integer.parseInt(date[1]);
          int day = Integer.parseInt(date[2]);
         
        LocalDate l = LocalDate.of( year, month , day ); //specify year, month, date directly
        LocalDate now = LocalDate.now(); //gets localDate
        Period diff = Period.between(l, now); //difference between the dates is calculated
        System.out.println(diff.getYears() + "years" + diff.getMonths() + "months" + diff.getDays() + "days");


        if(diff.getYears()<=25)
            status=true;  
        
        return status;
    }

    public int isValid(String userid, String password) {
        int status = -1;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from reporter where userid=? and password=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, userid);
                smt.setString(2, password);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    status = rs.getInt("id");
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("DBError :" + e.getMessage());
            }
        }
        //System.out.println("id:"+status);
        return status;
    }
    
        public boolean setNewPassword(String password,String userid) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
            
        if (con != null) {
            try {
                String sql = "update Reporter set password=? where userid=?";
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
        public boolean updateStatus(String ids[],String statuses[]){
            boolean sts=false;
            ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                con.setAutoCommit(false);
                for(int i=0; i<ids.length && i<statuses.length; i++){
                String sql = "update Reporter set status=? where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, statuses[i]);
                smt.setString(2, ids[i]);
                smt.executeUpdate();
                }
                con.commit();
                cp.releaseConnection(con);
            } catch (Exception ex) {
                try{con.rollback();}catch(Exception e){System.out.println("Commit Error "+e);}
                System.out.println("DBError :" + ex.getMessage());
            }
        }

            
            return sts;
        }

   /* public static void main(String[] args) {
        ReporterDao rd = new ReporterDao();
        rd.ageCalcuater("08/01/1996");
    }*/
}
