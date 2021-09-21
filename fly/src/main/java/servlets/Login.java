package servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Login")
public class Login extends HttpServlet {
    public static boolean isLoggedIn = false;
    public static String password = "admin";
    public static String email = "admin@flyaway.com";

    @Override
    public void doPost (HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();

        String email = req.getParameter("USERNAME");
        String pass = req.getParameter("PASSWORD");

        if (email.equals(Login.email) && pass.equals(Login.password)){
            isLoggedIn = true;
            out.println("You have LoggedIn");
            resp.sendRedirect("/fly/admin-dashboard.jsp");
        }
        else {
            isLoggedIn = false;
            out.println("Login Failed : Incorrect email or Password");
        }
        out.close();
    }
}