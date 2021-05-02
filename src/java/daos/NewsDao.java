package daos;

import jdbc.ConnectionPool;
import beans.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.ws.rs.core.Response;

public class NewsDao {

    public boolean add(News news, String cat_ids) {
        boolean status = false;
        System.out.println("======="+cat_ids);
        String catids[] = cat_ids.split(",");
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        if (con != null) {
            try {
                con.setAutoCommit(false);
                String sql = "insert into news(title,description,image,reporter_id,status,status_text) values(?,?,?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, news.getTitle());
                ps.setString(2, news.getDescription());
                ps.setString(3, news.getImage());
                ps.setInt(4, news.getReporter_id());
                ps.setString(5, news.getStatus());
                ps.setString(6, news.getStatus_text());

                int n = ps.executeUpdate();

                sql = "select id from news order by id desc limit 1 ";
                ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                int news_id = -1;
                if (rs.next()) {
                    news_id = rs.getInt("id");
                    for (String cat_id : catids) {
                        ps = con.prepareStatement("insert into ncr (news_id,news_cat_id) values(?,?)");
                        ps.setInt(1, news_id);
                        ps.setInt(2, Integer.parseInt(cat_id));
                        n = ps.executeUpdate();
                    }
                    if(n>0)
                        status = true;
                    con.commit();
                    System.out.println("Record Inserted...");
                }
                con.close();
            } catch (Exception e) {
                try {
                    con.rollback();
                } catch (Exception x) {
                }
                System.out.println("Error:" + e.getMessage());
            } finally {
                cp.releaseConnection(con);
            }

        }

        return status;
    }

    public boolean update(News news, String cat_ids) {
        boolean status = false;
        System.out.println("news:"+news);
        System.out.println("catisd:"+cat_ids);
            String catids[] = cat_ids.split(",");
        ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();

        if (con != null) {
            try {
                 con.setAutoCommit(false);
                 System.out.println("title:"+news.getTitle());
                 System.out.println("desc:"+news.getDescription());
                String sql = "update news set title=?,description=?,image=? where id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, news.getTitle());
                ps.setString(2, news.getDescription());
                ps.setString(3, news.getImage());
                ps.setInt(4, news.getId());
                int n = ps.executeUpdate();
                
                int news_id = news.getId();
                System.out.println("news_id:"+news_id);
                ps = con.prepareStatement("delete from ncr where news_id=?");
                ps.setInt(1, news_id);
                n = ps.executeUpdate();
                System.out.println("deleted");
                int x = 0;
                     for (String cat_id : catids) {
                         System.out.println("cat_id:"+cat_id);
                        ps = con.prepareStatement("insert into ncr (news_id,news_cat_id) values(?,?)");
                        ps.setInt(1, news_id);
                        ps.setInt(2, Integer.parseInt(cat_id));
                        x = ps.executeUpdate();
                    }
                if(x>0){
                status = true;
                System.out.println("Record Updated...");
                }
                con.commit();
                con.close();
            } catch (Exception e) {
                try {
                    con.rollback();
                } catch (Exception x) {
                }
                System.out.println("Error:" + e.getMessage());
            } finally {
                cp.releaseConnection(con);
            }

        }

        return status;
    }

         public ArrayList<News> getNewsByReporterId(int reporterid) {
        ArrayList<News> newsList = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where reporter_id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, reporterid);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    newsList.add(news);
                }
                cp.releaseConnection(con);
                smt.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return newsList;
    }

          public ArrayList<News> getNewsByReporterId(int reporterid,String status) {
        ArrayList<News> newsList = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where reporter_id=? and status=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, reporterid);
                smt.setString(2, status);
                ResultSet rs = smt.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    newsList.add(news);
                }
                cp.releaseConnection(con);
                smt.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return newsList;
    }
          
          
     public int getNewsCountByCategory(int catid) {
        int total = 0;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news_cat where cat_id=?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setInt(1, catid);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                }
                cp.releaseConnection(con);
                smt.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }

        return total;

    }

      public int getNewsCountByCategory(int catid,String status) {
        int total = 0;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news where status=? and id in (select news_id from ncr where news_cat_id = ?) ";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1,status);
                smt.setInt(2, catid);
                ResultSet rs = smt.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                }
                cp.releaseConnection(con);
                smt.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }

        return total;

    }
      
    public boolean removeById(int id) {
        boolean status = false;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                con.setAutoCommit(false);
                String sql = "delete from ncr where news_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                int n = ps.executeUpdate();
            ps = con.prepareStatement("delete from news where id=?");
            ps.setInt(1, id);
            n = ps.executeUpdate();
            con.setAutoCommit(true);
                 
                if (n > 0) {
                    status = true;
                    System.out.println("alert('Record Removed...')");
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return status;
    }
    
     
    public boolean remove(News news) {
        boolean status = false;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "delete from news where id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, news.getId());

                int n = ps.executeUpdate();
                if (n > 0) {
                    status = true;
                    System.out.println("Record Removed...");
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return status;
    }

    public News getById(int id) {
        News news = null;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return news;
    }

     public News getByStatus(String status) {
        News news = null;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where status=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, status);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return news;
    }

    
    public News getByReporterId(int id) {
        System.out.println("id:"+id);
        News news = null;
        
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where reporter_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
     //System.out.println(news);
        return news;
    }

    
    public News getNews(News news) {
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, news.getId());
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }
        return news;
    }

    public ArrayList<News> getAllNews() {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }

        return AllNews;
    }

    
   
    
    public ArrayList<News> getAllNews(String status) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where status=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1,status);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }

        return AllNews;
    }
  
      public ArrayList<News> getNewsByLimit(int start, int end,int reporter_id) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where reporter_id =? limit ?,?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1,reporter_id);
                ps.setInt(2, start);
                ps.setInt(3, end);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    
    
    public ArrayList<News> getNewsByLimit(int start, int end) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news limit ?,?";
                PreparedStatement ps = con.prepareStatement(sql);
                 ps.setInt(1, start);
                ps.setInt(2, end);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    public ArrayList<News> getNewsByLimit(int start, int end,String status) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where status = ? limit ?,?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1,status);
                ps.setInt(2, start);
                ps.setInt(3, end);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setId(rs.getInt("id"));
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    
    public int getRecordCount() {
        int total = 0;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                    System.out.println("total records : " + total);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return total;
    }

     public int getRecordCount(int reporter_id,String status) {
        int total = 0;
         System.out.println("status:"+status);
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news where reporter_id=? and status=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1,reporter_id);
                ps.setString(2,status);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                    System.out.println("total records : " + total);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return total;
    }

    public int getRecordCount(int reporter_id) {
        int total = 0;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news where reporter_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1,reporter_id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                    System.out.println("total records : " + total);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return total;
    }
    
    public ArrayList<News> getNewsByCategory(String cat_id,int reporter_id) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where id in(select news_id from ncr where news_cat_id=? ) and reporter_id=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, cat_id);
                ps.setInt(2, reporter_id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    
    public ArrayList<News> getNewsByCategory(String cat_id) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where id in(select news_id from ncr where news_cat_id=? )";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, cat_id);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    public ArrayList<News> getNewsByCategory(String cat_id,String status) {
        ArrayList<News> AllNews = new ArrayList();
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news where status='approved' and id in(select news_id from ncr where news_cat_id=? ) and status=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, cat_id);
                ps.setString(2, status);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    News news = new News();
                    news.setTitle(rs.getString("title"));
                    news.setDescription(rs.getString("description"));
                    news.setImage(rs.getString("image"));
                    news.setReporter_id(rs.getInt("reporter_id"));
                    news.setStatus(rs.getString("status"));
                    news.setStatus_text(rs.getString("status_text"));

                    AllNews.add(news);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return AllNews;
    }

    
    public int getNewsCategoryCount() {
        int total = 0;
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select count(*) from news_cat";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getInt(1);
                    System.out.println("total records : " + total);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error " + e.getMessage());
        }
        return total;
    }

    public ArrayList<NewsCategory> getNewsCategory() {
        ArrayList<NewsCategory> AllNewsCategory = new ArrayList();

        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news_cat";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    NewsCategory news_cat = new NewsCategory();
                    news_cat.setId(rs.getInt("id"));
                    news_cat.setName(rs.getString("name"));

                    AllNewsCategory.add(news_cat);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }

        return AllNewsCategory;
    }
    
  public ArrayList<NewsCategory> getNewsCategoryById(int id) {
        ArrayList<NewsCategory> AllNewsCategory = new ArrayList();
      System.out.println("id:"+id);
        try {
            ConnectionPool cp = ConnectionPool.getInstance();
            cp.initialize();
            Connection con = cp.getConnection();
            if (con != null) {
                String sql = "select * from news_cat where id in(select news_cat_id from ncr where news_id=?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1,id);
                ResultSet rs = ps.executeQuery();
                System.out.println("=============");
                while (rs.next()) {
                    NewsCategory news_cat = new NewsCategory();
                    news_cat.setId(rs.getInt("id"));
                    news_cat.setName(rs.getString("name"));

                    AllNewsCategory.add(news_cat);
                }
                cp.releaseConnection(con);
                ps.close();
            }
        } catch (Exception e) {
            System.out.println("Error:" + e.getMessage());
        }

        return AllNewsCategory;
    }
 
    
    public boolean updateNewsStatus(int id, String status,String statusText){
    boolean sts = false;
        System.out.println("id:"+id  +"status:"+status +"text:"+statusText);
    ConnectionPool cp = ConnectionPool.getInstance();
        cp.initialize();
        Connection con = cp.getConnection();
        System.out.println("cp:"+con);
        if (con != null) {
           try {
                String sql = "update news set status=?, status_text=? where id = ?";
                PreparedStatement smt = con.prepareStatement(sql);
                smt.setString(1, status);
                smt.setString(2, statusText);
                smt.setInt(3, id);
               int n =  smt.executeUpdate();
               System.out.println("n="+n);
                if(n>0){
                sts = true;
                smt.close();
                cp.releaseConnection(con);
                System.out.println("status:"+sts);
                }
            } catch (Exception e) {
                
              System.out.println("Error " + e.getMessage());
            }
       }
     return sts;
}


  /*public static void main(String[] args) {
        NewsDao ndo = new NewsDao();
       
        System.out.println(ndo.getNewsCategoryById(64));
    }*/
}
