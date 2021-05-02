 
package daos;
import java.sql.*;
import java.util.ArrayList;
import beans.NewsCategory;
import jdbc.ConnectionPool;

 
public class CategoryDao {
     public boolean  add(NewsCategory category){
       boolean status=false;
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "Insert into news_cat(name) values(?)";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setString(1, category.getName());
           
            if(smt.executeUpdate()>0)
                status=true;
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("DBError :"+e.getMessage());
        }
       }
       
    return status;
   }
   
   
   
   public boolean  remove(int id){
       boolean status=false;
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "Delete from news_cat where id=?";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setInt(1, id);
            
            if(smt.executeUpdate()>0)
                status=true;
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("DBError :"+e.getMessage());
        }
       }
       
    return status;
   }
   
   public NewsCategory  getById(int id){
      NewsCategory category=null;
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "select * from news_cat where id=?";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setInt(1, id);
            ResultSet rs= smt.executeQuery();
            if(rs.next()){
                category =new NewsCategory();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                 
            }
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("DBError :"+e.getMessage());
        }
       }
       
    return category;
   }
   
   public ArrayList<NewsCategory>  getAllRecords(){
    
       ArrayList<NewsCategory> categorys =new ArrayList<NewsCategory>();
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "select * from news_cat";
            PreparedStatement smt = con.prepareStatement(sql);
            ResultSet rs= smt.executeQuery();
            while(rs.next()){
                NewsCategory category=new NewsCategory();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categorys.add(category);
            }
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("DBError :"+e.getMessage());
        }
       }
       
    return categorys;
   }
   
   
   
   public ArrayList<NewsCategory>  getRecordByLimit(int start, int end){
    
       ArrayList<NewsCategory> categorys =new ArrayList<NewsCategory>();
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "select * from news_cat limit ?,?";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setInt(1, start);
            smt.setInt(2, end);
            ResultSet rs= smt.executeQuery();
            while(rs.next()){
                NewsCategory category=new NewsCategory();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                
                categorys.add(category);
            }
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("Error :"+e.getMessage());
        }
       }
       
    return categorys;
   }
   
  
   public int  getRecordsCount(){
    
       int total=0;
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "select count(*) from news_cat";
            PreparedStatement smt = con.prepareStatement(sql);
            ResultSet rs= smt.executeQuery();
            if(rs.next()){
                total = rs.getInt(1);
            }
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("Error :"+e.getMessage());
        }
       }
       
    return total;
   }
   
   public boolean  update(NewsCategory category){
       boolean status=false;
       ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "update news_cat set name=? where id=?";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setString(1, category.getName());
            smt.setInt(2, category.getId());
            if(smt.executeUpdate()>0)
                status=true;
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("DBError :"+e.getMessage());
        }
       }
       
    return status;
   }
   
   public boolean  isCategoryExist(String catname){
       boolean status = false;
        ConnectionPool cp = ConnectionPool.getInstance();
       cp.initialize();
       Connection con = cp.getConnection();
       if(con!=null){
        try{
            String sql = "select * from news_cat where name=?";
            PreparedStatement smt = con.prepareStatement(sql);
            smt.setString(1, catname);
            ResultSet rs= smt.executeQuery();
            if(rs.next()){
                status=true;
            }
            smt.close();
            cp.releaseConnection(con);
        }   catch(Exception e){
            System.out.println("Error :"+e.getMessage());
        }
       }
       
       return status;
   }
   
    
}