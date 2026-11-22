<%-- 
    Document   : ListarCitas
    Created on : 21/11/2026, 8:15:18 p. m.
    Author     : mabel
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.CitasVO"%>
<%@page import="java.util.List"%>

<%
    List<CitasVO> citas =
        (List<CitasVO>) request.getAttribute("citas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Consultar citas | Beauty Manager</title>

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
            padding: 25px;
            text-align: center;
        }

        .contenedor {
            background: white;
            max-width: 1200px;
            margin: 35px auto;
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.10);
        }

        h4 {
            color: #c2185b;
            font-weight: bold;
        }

        .tabla-contenedor {
            overflow-x: auto;
        }

        table {
            min-width: 850px;
        }

        thead {
            background: #fce4ec;
            color: #880e4f;
        }

        th {
            font-weight: bold;
        }

        .estado {
            background: #fff3e0;
            color: #e65100;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
        }

        .btn-rosa {
            background: #c2185b;
            border-radius: 25px;
            margin: 5px;
        }

        .btn-rosa:hover {
            background: #ad1457;
        }

        .sin-citas {
            background: #fce4ec;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            color: #880e4f;
        }
    </style>
</head>

<body>

<header class="encabezado">
    <h4 style="color:white;">Beauty Manager</h4>
    <p>Administración de citas</p>
</header>

<main class="contenedor">

    <h4 class="center-align">Citas registradas</h4>

    <p class="center-align grey-text">
        Consulta los servicios programados en el salón.
    </p>

    <% if (citas == null || citas.isEmpty()) { %>

        <div class="sin-citas">
            <i class="material-icons">event_busy</i>
            <p>No hay citas registradas actualmente.</p>
        </div>

    <% } else { %>

        <div class="tabla-contenedor">
            <table class="highlight centered responsive-table">

                <thead>
                    <tr>
                        <th>N.º</th>
                        <th>Cliente</th>
                        <th>Servicio</th>
                        <th>Empleado</th>
                        <th>Fecha y hora</th>
                        <th>Estado</th>
                    </tr>
                </thead>

                <tbody>

                    <% for (CitasVO cita : citas) { %>

                        <tr>
                            <td><%=cita.getId_Cita()%></td>

                            <td><%=cita.getNombreCliente()%></td>

                            <td><%=cita.getNombreServicio()%></td>

                            <td><%=cita.getNombreEmpleado()%></td>

                            <td><%=cita.getFechaHora().replace("T", " ")%></td>

                            <td>
                                <span class="estado">
                                    <%=cita.getEstado()%>
                                </span>
                            </td>
                        </tr>

                    <% } %>

                </tbody>

            </table>
        </div>

        <p class="grey-text">
            Total de citas registradas: <strong><%=citas.size()%></strong>
        </p>

    <% } %>

    <div class="center-align" style="margin-top:25px;">

        <a href="<%=request.getContextPath()%>/citas"
           class="btn btn-rosa">
            <i class="material-icons left">add</i>
            Registrar cita
        </a>

        <a href="<%=request.getContextPath()%>/inicio"
           class="btn grey">
            <i class="material-icons left">home</i>
            Volver al inicio
        </a>

    </div>

</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>

