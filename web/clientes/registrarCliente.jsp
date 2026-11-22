<%-- 
    Document   : registrarCliente
    Created on : 21/11/2026, 4:58:40 p. m.
    Author     : mabel
--%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Registrar cliente | Beauty Manager</title>

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
            max-width: 650px;
            margin: 45px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        h4 {
            color: #c2185b;
            text-align: center;
            margin-bottom: 25px;
        }

        .btn-rosa {
            background: #e91e63;
            border-radius: 20px;
            margin: 5px;
        }

        .btn-rosa:hover {
            background: #c2185b;
        }

        .mensaje {
            display: flex;
            align-items: flex-start;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #880e4f;
            background: #fce4ec;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .icono-mensaje {
            font-size: 24px;
            font-weight: bold;
            margin-right: 12px;
            flex-shrink: 0;
        }

        .texto-mensaje {
            display: block;
            white-space: normal;
        }

        .input-field input:focus {
            border-bottom: 1px solid #e91e63 !important;
            box-shadow: 0 1px 0 0 #e91e63 !important;
        }

        .input-field input:focus + label {
            color: #c2185b !important;
        }

        @media (max-width: 600px) {
            .contenedor {
                margin: 20px 12px;
                padding: 20px;
            }

            nav .brand-logo {
                font-size: 20px;
            }
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

    <h4>Registrar nuevo cliente</h4>

    <p>Completa los siguientes datos para registrar un cliente.</p>

    <%
        String mensaje = (String) request.getAttribute("mensaje");

        if (mensaje != null) {
            boolean exitoso = mensaje.contains("correctamente");
    %>

        <div class="mensaje" role="status">

            <span class="icono-mensaje">
                <%= exitoso ? "✓" : "⚠" %>
            </span>

            <div class="texto-mensaje">
                <strong><%= mensaje %></strong>
            </div>

        </div>

    <%
        }
    %>

    <form action="<%=request.getContextPath()%>/clientes"
          method="POST">

        <div class="input-field">
            <input type="text"
                   id="nombre"
                   name="nombre"
                   maxlength="100"
                   required>
            <label for="nombre">Nombre completo *</label>
        </div>

        <div class="input-field">
            <input type="text"
                   id="cedula"
                   name="cedula"
                   maxlength="20"
                   required>
            <label for="cedula">Número de cédula *</label>
        </div>

        <div class="input-field">
            <input type="text"
                   id="direccion"
                   name="direccion"
                   maxlength="150">
            <label for="direccion">Dirección</label>
        </div>

        <div class="input-field">
            <input type="tel"
                   id="celular"
                   name="celular"
                   maxlength="15">
            <label for="celular">Celular</label>
        </div>

        <div class="input-field">
            <input type="email"
                   id="correo"
                   name="correo"
                   maxlength="100">
            <label for="correo">Correo electrónico</label>
        </div>

        <div class="center-align">

            <button type="submit" class="btn btn-rosa">
                Registrar cliente
            </button>

            <a href="<%=request.getContextPath()%>/inicio"
               class="btn grey">
                Volver
            </a>

        </div>

    </form>

</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>
