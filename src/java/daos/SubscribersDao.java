 package daos;

import beans.Subscribers;
import jdbc.ConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;

public class SubscribersDao {

    public boolean add(Subscribers subscriber) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "Insert into subscribe(name,email )values(?,?)";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, subscriber.getName());
                 smt.setString(2, subscriber.getEmail());
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
                String sql = "Delete from subscribe where id=?";
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

    public Subscribers getById(int id) {
        Subscribers subscriber = null;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from subscribe where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, id);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    subscriber = new Subscribers();
                    subscriber.setId(rs.getInt("id"));
                    subscriber.setName(rs.getString("name"));
                    subscriber.setEmail(rs.getString("email"));
                     }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return subscriber;
    }

    public ArrayList<Subscribers> getAllRecords() {

        ArrayList<Subscribers> subscriberList = new ArrayList();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from subscribe";
                PreparedStatement smt = con.prepareStatement(sql);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Subscribers subscriber = new Subscribers();
                    subscriber.setId(rs.getInt("id"));
                    subscriber.setName(rs.getString("name"));
                     subscriber.setEmail(rs.getString("email"));
                     
                   subscriberList.add(subscriber);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return subscriberList;
    }

    public ArrayList<Subscribers> getRecordByLimit(int start, int end) {

        ArrayList<Subscribers>subscriberList = new ArrayList();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from subscribe limit ?,?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, start);
                smt.setInt(2, end);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                   Subscribers subscriber = new Subscribers();
                    subscriber.setId(rs.getInt("id"));
                   subscriber.setName(rs.getString("name"));
                      subscriber.setEmail(rs.getString("email"));
                      subscriberList.add(subscriber);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return subscriberList;
    }

    public int getRecordsCount() {

        int total = 0;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select count(*) from subscribe";
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

         
    public boolean isEmailExist(String email) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from subscribe where email=?";
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
    
     
    
    public static void main(String[] args) {
        SubscribersDao sd = new SubscribersDao();
        System.out.println(sd.getRecordsCount());
         }
}
