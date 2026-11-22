<%-- 
    Document   : registrarCita
    Created on : 21/11/2026, 7:21:40 p. m.
    Author     : mabel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.ClientesVO"%>
<%@page import="modelo.EmpleadosVO"%>
<%@page import="modelo.ServicioVO"%>
<%@page import="java.util.List"%>

<%
    List<ClientesVO> clientes =
        (List<ClientesVO>) request.getAttribute("clientes");

    List<EmpleadosVO> empleados =
        (List<EmpleadosVO>) request.getAttribute("empleados");

    List<ServicioVO> servicios =
        (List<ServicioVO>) request.getAttribute("servicios");

    String mensaje = (String) request.getAttribute("mensaje");

    String clienteSeleccionado = request.getParameter("id_Cliente");
    String servicioSeleccionado = request.getParameter("id_Servicio");
    String empleadoSeleccionado = request.getParameter("id_Empleado");
    String fechaSeleccionada = request.getParameter("fechaHora");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Registrar cita | Beauty Manager</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <style>
        body {
            background: #fce4ec;
            font-family: Arial, sans-serif;
        }

        .encabezado {
            background: #f06292;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .encabezado h4 {
            color: white;
            font-weight: bold;
            margin: 10px 0;
        }

        .contenedor {
            max-width: 750px;
            margin: 35px auto;
            background: white;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.10);
        }

        .contenedor h4 {
            color: #c2185b;
            font-weight: bold;
        }

        .campo {
            margin-top: 25px;
            margin-bottom: 25px;
        }

        .campo label {
            display: block;
            position: static;
            transform: none;
            color: #880e4f;
            font-size: 15px;
            margin-bottom: 10px;
            width: 100%;
        }

        .campo select {
            display: block;
            width: 100%;
            height: 48px;
            padding: 0 12px;
            border: 1px solid #ddd;
            border-radius: 7px;
            background-color: white;
            box-sizing: border-box;
            color: #333;
            outline: none;
        }

        .campo input[type="datetime-local"] {
            display: block;
            width: 100%;
            height: 48px;
            padding: 0 12px;
            border: 1px solid #ddd;
            border-radius: 7px;
            box-sizing: border-box;
            color: #333;
            background: white;
            margin: 0;
            box-shadow: none;
        }

        .campo select:focus,
        .campo input[type="datetime-local"]:focus {
            border: 1px solid #c2185b;
            box-shadow: 0 0 3px #c2185b;
        }

        .btn-rosa {
            background: #c2185b;
            border-radius: 25px;
            width: 100%;
            margin-top: 15px;
        }

        .btn-rosa:hover {
            background: #ad1457;
        }

        .btn-volver {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #c2185b;
        }

        .mensaje {
            padding: 12px;
            background: #fce4ec;
            color: #880e4f;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .aviso {
            color: #ad1457;
            background: #fce4ec;
            padding: 12px;
            border-radius: 8px;
        }

        .informacion {
            color: #777;
            margin-top: 20px;
        }

        @media (max-width: 600px) {
            .contenedor {
                margin: 20px 12px;
                padding: 22px;
            }
        }
    </style>
</head>

<body>

<header class="encabezado">
    <h4>Beauty Manager</h4>
    <p>Agenda tu momento de belleza</p>
</header>

<main class="contenedor">

    <h4 class="center-align">Registrar cita</h4>

    <p class="center-align grey-text">
        Completa los datos para programar el servicio.
    </p>

    <% if (mensaje != null) { %>
        <div class="mensaje">
            <%= mensaje %>
        </div>
    <% } %>

    <% if (clientes == null || clientes.isEmpty()
          || empleados == null || empleados.isEmpty()
          || servicios == null || servicios.isEmpty()) { %>

        <div class="aviso center-align">
            No es posible registrar una cita.
            Verifica que existan clientes, empleados y servicios registrados.
        </div>

    <% } else { %>

    <form action="<%=request.getContextPath()%>/citas"
          method="POST">

        <div class="campo">
            <label for="id_Cliente">Seleccionar cliente</label>

            <select name="id_Cliente" id="id_Cliente" required>
                <option value="" disabled
                    <%= clienteSeleccionado == null ? "selected" : "" %>>
                    Elige un cliente
                </option>

                <% for (ClientesVO cliente : clientes) { %>
                    <option value="<%=cliente.getId_Cliente()%>"
                        <%= String.valueOf(cliente.getId_Cliente()).equals(clienteSeleccionado) ? "selected" : "" %>>
                        <%=cliente.getNombre()%> - <%=cliente.getCedula()%>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="campo">
            <label for="id_Servicio">Seleccionar servicio</label>

            <select name="id_Servicio" id="id_Servicio" required>
                <option value="" disabled
                    <%= servicioSeleccionado == null ? "selected" : "" %>>
                    Elige un servicio
                </option>

                <% for (ServicioVO servicio : servicios) { %>
                    <option value="<%=servicio.getId_Servicio()%>"
                        <%= String.valueOf(servicio.getId_Servicio()).equals(servicioSeleccionado) ? "selected" : "" %>>
                        <%=servicio.getNombre()%> -
                        $<%=String.format("%,.0f", servicio.getPrecio())%>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="campo">
            <label for="id_Empleado">Seleccionar empleado</label>

            <select name="id_Empleado" id="id_Empleado" required>
                <option value="" disabled
                    <%= empleadoSeleccionado == null ? "selected" : "" %>>
                    Elige un empleado
                </option>

                <% for (EmpleadosVO empleado : empleados) { %>
                    <option value="<%=empleado.getId_Empleado()%>"
                        <%= String.valueOf(empleado.getId_Empleado()).equals(empleadoSeleccionado) ? "selected" : "" %>>
                        <%=empleado.getNombre()%> - <%=empleado.getCargo()%>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="campo">
            <label for="fechaHora">Fecha y hora de la cita</label>

            <input type="datetime-local"
                   id="fechaHora"
                   name="fechaHora"
                   value="<%=fechaSeleccionada != null ? fechaSeleccionada : ""%>"
                   required>
        </div>

        <p class="informacion">
            <i class="material-icons tiny">info</i>
            La cita quedará registrada inicialmente como pendiente.
        </p>

        <button type="submit"
                class="btn btn-rosa waves-effect waves-light">
            <i class="material-icons left">event_available</i>
            Registrar cita
        </button>

    </form>

    <% } %>

    <a href="<%=request.getContextPath()%>/inicio"
       class="btn-volver">
        <i class="material-icons tiny">arrow_back</i>
        Volver al inicio
    </a>

</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        const fecha = document.getElementById('fechaHora');

        if (fecha) {
            const ahora = new Date();

            ahora.setMinutes(
                ahora.getMinutes() - ahora.getTimezoneOffset()
            );

            fecha.min = ahora.toISOString().slice(0, 16);
        }
    });
</script>

</body>
</html>
