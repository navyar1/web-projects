
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="com.helper.FactoryProvider" %>
<%@ page import="com.entities.Todo" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <%@include file="all_js_css.jsp" %>
</head>
<body>

<div class="container-fluid ">
   <%@include file="newbar.jsp" %>
    <h1>Edit your note</h1>
    
    <%
    int noteId=Integer.parseInt(request.getParameter("note_id").trim());

	Session s= FactoryProvider.getFactory().openSession();
	Transaction tx=s.beginTransaction();
	Todo todo=(Todo)s.get(Todo.class, noteId);
	
    %>
    
    
   <form action="UpdateServlet" method="post">
   
   <input value="<%=todo.getId() %>" name=noteId type="hidden" />
  <div class="form-group">
    <label for="title">Note Title</label>
    <input name="title" required type="text" class="form-control" id="title" aria-describedby="emailHelp" placeholder="Enter here"
    
    value="<%=todo.getTitle() %>"
    
    />
    
  </div>
  <div class="form-group">
    <label for="content">Note Content</label>
    <textarea name="content" required id="content" placeholder="enter your content here"
    class="form-control"
    style="height:300px;"
    <%=todo.getContent() %>
    ></textarea>
  </div>
  
  <div class ="container text-center">
  <button type="submit" class="btn btn-success">Save your note</button>
  </div>
</form>
   
   </div>
</body>
</html>