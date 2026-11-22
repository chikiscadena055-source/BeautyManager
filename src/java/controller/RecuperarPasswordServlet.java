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

@WebServlet(name = "RecuperarPasswordServlet",
            urlPatterns = {"/recuperarPassword"})
public class RecuperarPasswordServlet extends HttpServlet {

    // Mostrar formulario de recuperación
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/recuperarPassword.jsp")
                .forward(request, response);
    }

    // Procesar recuperación de contraseña
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String usuario = request.getParameter("usuario");
        String cedula = request.getParameter("cedula");
        String password = request.getParameter("password");
        String confirmarPassword =
                request.getParameter("confirmarPassword");

        if (usuario == null || cedula == null
                || password == null || confirmarPassword == null
                || usuario.trim().isEmpty()
                || cedula.trim().isEmpty()
                || password.isEmpty()
                || confirmarPassword.isEmpty()) {

            request.setAttribute("mensaje",
                    "Todos los campos son obligatorios.");

            request.getRequestDispatcher("/recuperarPassword.jsp")
                    .forward(request, response);
            return;
        }

        usuario = usuario.trim();
        cedula = cedula.trim();

        if (password.length() < 8) {
            request.setAttribute("mensaje",
                    "La contraseña debe tener mínimo 8 caracteres.");

            request.getRequestDispatcher("/recuperarPassword.jsp")
                    .forward(request, response);
            return;
        }

        if (!password.equals(confirmarPassword)) {
            request.setAttribute("mensaje",
                    "Las contraseñas no coinciden.");

            request.getRequestDispatcher("/recuperarPassword.jsp")
                    .forward(request, response);
            return;
        }

        EmpleadosDAO empleadoDAO = new EmpleadosDAO();

        boolean actualizado = empleadoDAO.restablecerPassword(
                usuario, cedula, password
        );

        if (actualizado) {
            request.setAttribute("mensajeExito",
                    "Contraseña actualizada correctamente.");
        } else {
            request.setAttribute("mensaje",
                    "No se pudo verificar el usuario y la cédula. "
                    + "Compruebe los datos ingresados.");
        }

        request.getRequestDispatcher("/recuperarPassword.jsp")
                .forward(request, response);
    }
}

