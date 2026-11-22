/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


package controller;

import modelo.EmpleadosDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "acceso", urlPatterns = {"/acceso"})
public class acceso extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        if (usuario == null || password == null
                || usuario.trim().isEmpty()
                || password.isEmpty()) {

            request.setAttribute("mensaje",
                    "Por favor ingrese usuario y contraseña.");

            request.getRequestDispatcher("/principal.jsp")
                    .forward(request, response);
            return;
        }

        EmpleadosDAO empleadoDAO = new EmpleadosDAO();

        if (empleadoDAO.validarEmpleado(usuario, password)) {

            String nombreEmpleado =
                    empleadoDAO.obtenerNombreEmpleado(usuario);

            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usuario);

            sesion.setAttribute("nombreEmpleado",
                    nombreEmpleado != null
                    && !nombreEmpleado.trim().isEmpty()
                            ? nombreEmpleado : usuario);

            response.sendRedirect(
                    request.getContextPath() + "/inicio");

        } else {

            request.setAttribute("mensaje",
                    "Datos incorrectos. Verifique su usuario y contraseña.");

            request.getRequestDispatcher("/principal.jsp")
                    .forward(request, response);
        }
    }
}