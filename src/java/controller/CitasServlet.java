/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


package controller;

import modelo.CitasDAO;
import modelo.CitasVO;
import modelo.ClientesDAO;
import modelo.ClientesVO;
import modelo.EmpleadosDAO;
import modelo.EmpleadosVO;
import modelo.ServiciosDAO;
import modelo.ServicioVO;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CitasServlet", urlPatterns = {"/citas"})
public class CitasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Verificar que el usuario haya iniciado sesión
        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/principal.jsp");
            return;
        }

        cargarDatosFormulario(request);

        request.getRequestDispatcher(
                "/citas/registrarCita.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Verificar la sesión antes de registrar una cita
        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/principal.jsp");
            return;
        }

        try {

            int idCliente = Integer.parseInt(
                    request.getParameter("id_Cliente"));

            int idEmpleado = Integer.parseInt(
                    request.getParameter("id_Empleado"));

            int idServicio = Integer.parseInt(
                    request.getParameter("id_Servicio"));

            String fechaHora = request.getParameter("fechaHora");

            if (fechaHora == null || fechaHora.isBlank()
                    || LocalDateTime.parse(fechaHora)
                    .isBefore(LocalDateTime.now())) {

                request.setAttribute(
                        "mensaje",
                        "Selecciona una fecha y hora futura."
                );

                cargarDatosFormulario(request);

                request.getRequestDispatcher(
                        "/citas/registrarCita.jsp"
                ).forward(request, response);

                return;
            }

            CitasVO cita = new CitasVO();

            cita.setId_Cliente(idCliente);
            cita.setId_Empleado(idEmpleado);
            cita.setId_Servicio(idServicio);
            cita.setFechaHora(fechaHora);
            cita.setEstado("Pendiente");

            CitasDAO dao = new CitasDAO();

            if (dao.registrarCita(cita)) {

                request.setAttribute(
                        "mensaje",
                        "¡La cita se registró correctamente!"
                );

            } else {

                request.setAttribute(
                        "mensaje",
                        "No fue posible registrar la cita."
                );
            }

        } catch (NumberFormatException | NullPointerException e) {

            request.setAttribute(
                    "mensaje",
                    "Verifica los datos seleccionados."
            );

        } catch (java.time.format.DateTimeParseException e) {

            request.setAttribute(
                    "mensaje",
                    "La fecha y hora no tienen un formato válido."
            );
        }

        cargarDatosFormulario(request);

        request.getRequestDispatcher(
                "/citas/registrarCita.jsp"
        ).forward(request, response);
    }

    private void cargarDatosFormulario(HttpServletRequest request) {

        ClientesDAO clientesDAO = new ClientesDAO();
        EmpleadosDAO empleadosDAO = new EmpleadosDAO();
        ServiciosDAO serviciosDAO = new ServiciosDAO();

        List<ClientesVO> clientes =
                clientesDAO.listarClientes();

        List<EmpleadosVO> empleados =
                empleadosDAO.listarEmpleados();

        List<ServicioVO> servicios =
                serviciosDAO.listarServicios();

        request.setAttribute("clientes", clientes);
        request.setAttribute("empleados", empleados);
        request.setAttribute("servicios", servicios);
    }
}
