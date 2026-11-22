/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
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

@WebServlet(name = "RegistroEmpleadoServlet", urlPatterns = {"/registroEmpleado"})
public class RegistroEmpleadoServlet extends HttpServlet {

    // Verificar que exista una sesión iniciada
    private boolean sesionValida(HttpServletRequest request) {
        HttpSession sesion = request.getSession(false);

        return sesion != null
                && sesion.getAttribute("usuario") != null;
    }

    // Abrir formulario de registro
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!sesionValida(request)) {
            response.sendRedirect(
                    request.getContextPath() + "/principal.jsp"
            );
            return;
        }

        request.getRequestDispatcher("/registroEmpleado.jsp")
                .forward(request, response);
    }

    // Procesar registro de empleado
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!sesionValida(request)) {
            response.sendRedirect(
                    request.getContextPath() + "/principal.jsp"
            );
            return;
        }

        String nombre = request.getParameter("nombre");
        String cedula = request.getParameter("cedula");
        String cargo = request.getParameter("cargo");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String confirmarPassword = request.getParameter("confirmarPassword");

        if (nombre == null || cedula == null || cargo == null
                || correo == null || password == null
                || confirmarPassword == null
                || nombre.trim().isEmpty()
                || cedula.trim().isEmpty()
                || cargo.trim().isEmpty()
                || correo.trim().isEmpty()
                || password.isEmpty()
                || confirmarPassword.isEmpty()) {

            request.setAttribute("mensaje",
                    "Todos los campos son obligatorios.");

            request.getRequestDispatcher("/registroEmpleado.jsp")
                    .forward(request, response);
            return;
        }

        nombre = nombre.trim();
        cedula = cedula.trim();
        cargo = cargo.trim();
        correo = correo.trim();

        if (password.length() < 8) {
            request.setAttribute("mensaje",
                    "La contraseña debe tener mínimo 8 caracteres.");

            request.getRequestDispatcher("/registroEmpleado.jsp")
                    .forward(request, response);
            return;
        }

        if (!password.equals(confirmarPassword)) {
            request.setAttribute("mensaje",
                    "Las contraseñas no coinciden.");

            request.getRequestDispatcher("/registroEmpleado.jsp")
                    .forward(request, response);
            return;
        }

        if (!correo.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            request.setAttribute("mensaje",
                    "Ingrese un correo electrónico válido.");

            request.getRequestDispatcher("/registroEmpleado.jsp")
                    .forward(request, response);
            return;
        }

        EmpleadosDAO empleadoDAO = new EmpleadosDAO();

        if (empleadoDAO.existeCedula(cedula)) {
            request.setAttribute("mensaje",
                    "Ya existe un empleado registrado con esa cédula.");

            request.getRequestDispatcher("/registroEmpleado.jsp")
                    .forward(request, response);
            return;
        }

        int idGenerado = empleadoDAO.registrarEmpleado(
                nombre, cedula, cargo, correo, password
        );

        if (idGenerado > 0) {
            request.setAttribute("mensaje",
                    "Empleado registrado correctamente.");

            request.setAttribute("idGenerado", idGenerado);
        } else {
            request.setAttribute("mensaje",
                    "No fue posible registrar el empleado. Verifique los datos.");
        }

        request.getRequestDispatcher("/registroEmpleado.jsp")
                .forward(request, response);
    }
}
