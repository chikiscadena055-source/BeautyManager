<%-- 
    Document   : listarClientes
    Created on : 21/11/2026, 5:31:27 p. m.
    Author     : mabel
--%>



<%@page import="java.util.List"%>
<%@page import="modelo.ClientesVO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Listado de clientes | Beauty Manager</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <style>
        body {
            background: #fce4ec;
            font-family: Arial, sans-serif;
        }

        nav {
            background: #f06292;
        }

        .contenedor {
            max-width: 1200px;
            margin: 40px auto;
            padding: 25px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        h4 {
            color: #c2185b;
            text-align: center;
            margin-bottom: 25px;
        }

        .resumen {
            background: #fce4ec;
            color: #880e4f;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            text-align: center;
        }

        .cantidad {
            font-size: 30px;
            font-weight: bold;
            display: block;
        }

        .buscador {
            margin-top: 20px;
            margin-bottom: 15px;
        }

        .tabla-contenedor {
            overflow-x: auto;
        }

        table thead {
            background: #f8bbd0;
            color: #880e4f;
        }

        table th, table td {
            padding: 12px;
        }

        .btn-rosa {
            background: #e91e63;
            border-radius: 20px;
            margin: 5px;
        }

        .btn-rosa:hover {
            background: #c2185b;
        }

        .mensaje-vacio {
            padding: 20px;
            text-align: center;
            background: #fce4ec;
            color: #880e4f;
            border-radius: 8px;
        }

        .numero {
            font-weight: bold;
            color: #c2185b;
            text-align: center;
        }

        .input-field input:focus {
            border-bottom: 1px solid #e91e63 !important;
            box-shadow: 0 1px 0 0 #e91e63 !important;
        }

        .input-field input:focus + label {
            color: #c2185b !important;
        }
    </style>
</head>

<body>

<nav>
    <div class="nav-wrapper container">
        <a href="<%=request.getContextPath()%>/inicio/inicio.jsp"
           class="brand-logo">
            Beauty Manager
        </a>
    </div>
</nav>

<div class="contenedor">

    <h4>Listado de clientes</h4>

    <p>Consulta y administra la información de los clientes registrados.</p>

    <%
        List<ClientesVO> clientes =
            (List<ClientesVO>) request.getAttribute("clientes");

        int total = (clientes == null) ? 0 : clientes.size();
    %>

    <div class="resumen">
        <span class="cantidad" id="totalClientes">
            <%= total %>
        </span>
        <strong>Clientes registrados</strong>
    </div>

    <div class="right-align">
        <a href="<%=request.getContextPath()%>/clientes"
           class="btn btn-rosa">
            + Registrar nuevo cliente
        </a>
    </div>

    <div class="input-field buscador">
        <input type="text"
               id="buscarCliente"
               onkeyup="filtrarClientes()">
        <label for="buscarCliente">
            Buscar por nombre o cédula
        </label>
    </div>

    <%
        if (clientes != null && !clientes.isEmpty()) {
    %>

    <div class="tabla-contenedor">

        <table class="highlight responsive-table">

            <thead>
                <tr>
                    <th>N.º</th>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Cédula</th>
                    <th>Dirección</th>
                    <th>Celular</th>
                    <th>Correo</th>
                </tr>
            </thead>

            <tbody id="tablaClientes">

                <%
                    int numero = 1;

                    for (ClientesVO cliente : clientes) {
                %>

                <tr>
                    <td class="numero">
                        <%= numero++ %>
                    </td>

                    <td><%= cliente.getId_Cliente() %></td>
                    <td><%= cliente.getNombre() %></td>
                    <td><%= cliente.getCedula() %></td>
                    <td><%= cliente.getDireccion() %></td>
                    <td><%= cliente.getCelular() %></td>
                    <td><%= cliente.getCorreo() %></td>
                </tr>

                <%
                    }
                %>

            </tbody>

        </table>

        <div id="sinResultados"
             class="mensaje-vacio"
             style="display:none; margin-top:15px;">
            No se encontraron clientes con esa búsqueda.
        </div>

    </div>

    <%
        } else {
    %>

        <div class="mensaje-vacio">
            No hay clientes registrados para mostrar.
        </div>

    <%
        }
    %>

    <div class="center-align" style="margin-top:25px;">
        <a href="<%=request.getContextPath()%>/inicio"
           class="btn grey">
            Volver al inicio
        </a>
    </div>

</div>

<script>

    function filtrarClientes() {

        let buscador = document.getElementById("buscarCliente");

        let filtro = buscador.value.toLowerCase();

        let tabla = document.getElementById("tablaClientes");

        if (!tabla) {
            return;
        }

        let filas = tabla.getElementsByTagName("tr");

        let encontrados = 0;

        for (let i = 0; i < filas.length; i++) {

            let nombre = filas[i].cells[2].textContent.toLowerCase();

            let cedula = filas[i].cells[3].textContent.toLowerCase();

            if (nombre.includes(filtro) || cedula.includes(filtro)) {

                filas[i].style.display = "";

                encontrados++;

            } else {

                filas[i].style.display = "none";
            }
        }

        document.getElementById("sinResultados").style.display =
            encontrados === 0 ? "block" : "none";

        document.getElementById("totalClientes").textContent =
            encontrados;
    }

</script>

</body>
</html>
