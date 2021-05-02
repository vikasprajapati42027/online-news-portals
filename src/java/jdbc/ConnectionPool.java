 

package jdbc;
import java.sql.*;
import java.util.*;
public class ConnectionPool {
    static final int MAX_CONNECTION = 20;
    static Vector connections = null;
    static ConnectionPool instance = null;
    
    //this function used for create an object or instance of ConnectionPool
    public static synchronized ConnectionPool getInstance()
    {
        if(instance == null)
        {
            instance = new ConnectionPool();
        }
        return instance;
    }
    
    
    
    //this function used for remove all connection from ConnectionPool
    
    public synchronized void removeAllConnections()
    {
        try
        {
            if(connections == null)
            {
                return;
            }
            int sz = connections.size();
            for(int i=0;i<sz;i++)
            {
                Connection c = (Connection)connections.elementAt(i);
                c.close();
            }
            connections.removeAllElements();
            connections = null;
        }catch(SQLException e)
        {
            System.out.println(e);
        }
    }
    
    //this function used for initialize ConnectionPool
    public synchronized void initialize()
    {
        if(connections==null)
        {
            try
            {
                String userName = "root";
                String password = "";
                
                String url = "jdbc:mysql://localhost:3306/gist";
                Class.forName("com.mysql.jdbc.Driver");
                System.out.println("Going to create connection......");
                connections = new Vector();
                int count=0;
                while(count<MAX_CONNECTION)
                {
                    Connection con = DriverManager.getConnection(url,userName,password);
                    System.out.println("Connection created....");
                    connections.addElement(con);
                    count++;
                }
            }catch(Exception e)
            {
                System.out.println("Error:"+e.getMessage());
            }
        }
    }
    
    //this function used for get Connection from ConnectionPool
    public synchronized Connection getConnection()
    {
        Connection c = null;
        if(connections == null)
        {
            return null;
        }
        if(connections.size()>0)
        {
            c = (Connection)connections.elementAt(0);
            connections.removeElementAt(0);
        }
        return c;
    }
    
    //this function used for release Connection and add that connection in ConnectionPool
    public synchronized void releaseConnection(Connection c)
    {
        connections.addElement(c);
        notifyAll();
    }
    
 }
