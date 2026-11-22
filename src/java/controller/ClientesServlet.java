/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import modelo.ClientesDAO;
import modelo.ClientesVO;

@WebServlet(
    name = "ClientesServlet",
    urlPatterns = {"/clientes", "/listarClientes"}
)
public class ClientesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ClientesDAO dao = new ClientesDAO();

        if (request.getServletPath().equals("/listarClientes")) {

            request.setAttribute(
                "clientes",
                dao.listarClientes()
            );

            request.getRequestDispatcher(
                "/clientes/listarClientes.jsp"
            ).forward(request, response);

        } else {

            request.getRequestDispatcher(
                "/clientes/registrarCliente.jsp"
            ).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String cedula = request.getParameter("cedula");
        String direccion = request.getParameter("direccion");
        String celular = request.getParameter("celular");
        String correo = request.getParameter("correo");

        if (nombre == null || nombre.trim().isEmpty()
                || cedula == null || cedula.trim().isEmpty()) {

            request.setAttribute(
                "mensaje",
                "El nombre y la cédula son obligatorios."
            );

            request.getRequestDispatcher(
                "/clientes/registrarCliente.jsp"
            ).forward(request, response);

            return;
        }

        ClientesDAO dao = new ClientesDAO();

        cedula = cedula.trim();

        if (dao.existeCedula(cedula)) {

            request.setAttribute(
                "mensaje",
                "La cédula ya está registrada. Verifica los datos."
            );

            request.getRequestDispatcher(
                "/clientes/registrarCliente.jsp"
            ).forward(request, response);

            return;
        }

        ClientesVO cliente = new ClientesVO();

        cliente.setNombre(nombre.trim());
        cliente.setCedula(cedula);
        cliente.setDireccion(
            direccion == null ? "" : direccion.trim()
        );
        cliente.setCelular(
            celular == null ? "" : celular.trim()
        );
        cliente.setCorreo(
            correo == null ? "" : correo.trim()
        );

        boolean registrado = dao.registrarCliente(cliente);

        if (registrado) {

            request.setAttribute(
                "mensaje",
                "¡Cliente registrado correctamente!"
            );

        } else {

            request.setAttribute(
                "mensaje",
                "No fue posible registrar el cliente. Revisa la conexión y los datos."
            );
        }

        request.getRequestDispatcher(
            "/clientes/registrarCliente.jsp"
        ).forward(request, response);
    }
}
