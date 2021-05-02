package daos;
import beans.Query;
import jdbc.ConnectionPool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;

public class QueryDao {

    public boolean add(Query query) {
        boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "Insert into query(name,contact,email,message)values(?,?,?,?)";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, query.getName());
                smt.setString(2, query.getContact());
                 smt.setString(3, query.getEmail());
                smt.setString(4, query.getMessage());
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
                String sql = "Delete from query where id=?";
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

    public Query getById(int id) {
        Query query = null;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from query where id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, id);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    query = new Query();
                    query.setId(rs.getInt("id"));
                    query.setName(rs.getString("name"));
                    query.setContact(rs.getString("contact")); 
                    query.setMessage(rs.getString("message"));
                    query.setEmail(rs.getString("email"));
                     }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return query;
    }

    public ArrayList<Query> getAllRecords() {

        ArrayList<Query> queryList = new ArrayList();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from query";
                PreparedStatement smt = con.prepareStatement(sql);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Query query = new Query();
                    query.setId(rs.getInt("id"));
                    query.setName(rs.getString("name"));
                    query.setContact(rs.getString("contact")); 
                    query.setMessage(rs.getString("message"));
                    query.setEmail(rs.getString("email"));
                      
                   queryList.add(query);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return queryList;
    }

    public ArrayList<Query> getRecordByLimit(int start, int end) {
        ArrayList<Query> queryList = new ArrayList();
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select * from query limit ?,?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, start);
                smt.setInt(2, end);     
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    Query query = new Query();
                   query.setId(rs.getInt("id"));
                    query.setName(rs.getString("name"));
                    query.setContact(rs.getString("contact")); 
                    query.setMessage(rs.getString("message"));
                    query.setEmail(rs.getString("email"));
                      
                   queryList.add(query);
                }
                smt.close();
                cp.releaseConnection(con);
            } catch (Exception e) {
                System.out.println("Error :" + e.getMessage());
            }
        }

        return queryList; 
    }

    public int getRecordsCount() {

        int total = 0;
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                String sql = "select count(*) from query";
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

         
    
    
}