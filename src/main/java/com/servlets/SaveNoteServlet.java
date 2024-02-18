package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.entities.Todo;
import com.helper.FactoryProvider;

/**
 * Servlet implementation class SaveNoteServlet
 */
public class SaveNoteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveNoteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //title and content fetch
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            Todo todo = new Todo(title, content, new Date());

            // Hibernate save
            Session session = FactoryProvider.getFactory().openSession();
            Transaction transaction = session.beginTransaction();
            session.save(todo);
            transaction.commit();
            session.close();

            // Set response content type
            response.setContentType("text/html");

            // Send response
            
            PrintWriter out = response.getWriter();
            out.println("<h1 style='text-align:center;'>Note is added successfully</h1>");
            out.println("<p style='text-align:center;'><a href='all_notes.jsp'>View all notes</a></p>");
            out.close(); // close PrintWriter to release resources

            out.close(); // close PrintWriter to release resources
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.println("An error occurred while saving the note");
            out.close();
        }
    }
}
