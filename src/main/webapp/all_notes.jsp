<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="com.helper.FactoryProvider" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entities.Todo" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All notes: Note Taker</title>
<%@include file="all_js_css.jsp" %>
</head>
<body>
<div class="container">
  <%@include file="newbar.jsp" %>
  <br>
  <h1 class="text-uppercase"> All Notes :</h1>
  <div class="row">
    <div class="col-12">
      <% 
        try {
            Session s = FactoryProvider.getFactory().openSession();
            Query query = s.createQuery("from Todo");
            List<Todo> todoList = query.list();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Todo todo : todoList) {
                String formattedDate = dateFormat.format(todo.getAddedDate());
      %>
                <div class="card mt-3">
                  <img style="max-width:100px" src="image/pencil.png" class="card-img-top m-4 mx-auto" alt="...">
                  <div class="card-body">
                    <h5 class="card-title"><%= todo.getTitle() %></h5>
                    <p class="card-text"><%= todo.getContent() %></p>
                    <p class="text-primary"><b><%= formattedDate %></b></p>
                    <div class="container text-center mt-2">
                      <a href="DeleteServlet?note_id=<%= todo.getId() %>" class="btn btn-danger">Delete</a>
                      <a href="edit.jsp?note_id=<%= todo.getId() %>" class="btn btn-primary">Update</a>
                    </div>
                  </div>
                </div>
      <% 
            }
            s.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
      %>
    </div>
  </div>
</div>
</body>
</html>
