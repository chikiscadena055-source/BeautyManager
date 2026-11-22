<%-- 
    Document   : recuperarPassword
    Created on : 21/11/2026, 11:08:56 p. m.
    Author     : mabel
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar contraseña - Beauty Manager</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #fce4ec, #f8bbd0);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
        }

        .contenedor {
            width: 90%;
            max-width: 480px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        h4 {
            color: #c2185b;
            text-align: center;
            font-weight: bold;
        }

        .subtitulo {
            text-align: center;
            color: #777;
            margin-bottom: 25px;
        }

        .input-field input:focus {
            border-bottom: 1px solid #ec407a !important;
            box-shadow: 0 1px 0 0 #ec407a !important;
        }

        .input-field input:focus + label {
            color: #c2185b !important;
        }

        .btn-pink {
            background-color: #ec407a;
            width: 100%;
            border-radius: 8px;
        }

        .btn-pink:hover {
            background-color: #c2185b;
        }

        .enlace {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #c2185b;
        }

        .mensaje {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }

        .error {
            background: #ffebee;
            color: #c62828;
        }

        .exito {
            background: #e8f5e9;
            color: #2e7d32;
        }
    </style>
</head>

<body>

<div class="contenedor">

    <h4>Beauty Manager</h4>

    <p class="subtitulo">Recuperación de contraseña</p>

    <% if (request.getAttribute("mensaje") != null) { %>
        <div class="mensaje error">
            <%= request.getAttribute("mensaje") %>
        </div>
    <% } %>

    <% if (request.getAttribute("mensajeExito") != null) { %>

        <div class="mensaje exito">
            <%= request.getAttribute("mensajeExito") %>
        </div>

        <a href="<%= request.getContextPath() %>/principal.jsp"
           class="btn btn-pink">
            Volver al inicio de sesión
        </a>

    <% } else { %>

        <form action="<%= request.getContextPath() %>/recuperarPassword"
              method="POST">

            <div class="input-field">
                <input type="number" id="usuario" name="usuario"
                       min="1" required>
                <label for="usuario">Usuario (ID del empleado)</label>
            </div>

            <div class="input-field">
                <input type="text" id="cedula" name="cedula"
                       maxlength="20" required>
                <label for="cedula">Número de cédula</label>
            </div>

            <div class="input-field">
                <input type="password" id="password" name="password"
                       minlength="8" required>
                <label for="password">Nueva contraseña</label>
            </div>

            <div class="input-field">
                <input type="password" id="confirmarPassword"
                       name="confirmarPassword" minlength="8" required>
                <label for="confirmarPassword">
                    Confirmar nueva contraseña
                </label>
            </div>

            <button type="submit" class="btn btn-pink">
                Restablecer contraseña
            </button>

        </form>

    <% } %>

    <a class="enlace"
       href="<%= request.getContextPath() %>/principal.jsp">
        Volver al inicio de sesión
    </a>

</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>

