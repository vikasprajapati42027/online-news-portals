<%@page import="java.sql.*,beans.*,daos.NewsDao,java.util.ArrayList" %>
<div class="col-lg-3">

        <h1 class="my-4">News Category</h1>
        <div class="list-group">    
            <a href="home.jsp" class="list-group-item <%if(request.getParameter("cat_id")==null) out.println("  active");%>">All News</a>
            
         <%

                            NewsDao ndo = new NewsDao();
                            ArrayList<NewsCategory> category = new ArrayList();
                            category = ndo.getNewsCategory();
                          
                            for (NewsCategory cat : category) {%>                                
                      
                             <a href="home.jsp?cat_id=<%=cat.getId()%>" class="list-group-item <%if(String.valueOf(cat.getId()).equals(String.valueOf(request.getParameter("cat_id"))))out.println("active");%>"><%=cat.getName()%> 
                                 <span class="badge-dark"><%=ndo.getNewsCountByCategory(cat.getId(),"approved")%></span></a>                      
                        <%}%>
                        
                        
      </div>
                        <br> 
                        <a href="subscribers.jsp" class="btn btn-dark">SUBSCRIBE</a>
      </div>