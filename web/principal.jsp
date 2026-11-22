<%-- 
    Document   : principal
    Created on : 15/11/2026, 7:20:57 p. m.
    Author     : mabel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Beauty Manager</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">

    <style>
        body {
            background: #fce4ec;
            font-family: Arial, sans-serif;
        }

        .contenedor {
            margin-top: 45px;
            margin-bottom: 45px;
        }

        .tarjeta {
            border-radius: 18px;
            overflow: hidden;
        }

        .encabezado {
            background: #ec407a;
            color: white;
            padding: 25px;
            text-align: center;
        }

        .encabezado h3 {
            font-weight: bold;
            margin: 0;
        }

        .imagen {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .contenido {
            padding: 30px !important;
        }

        .btn-ingresar {
            background: #c2185b;
            width: 100%;
            border-radius: 25px;
            margin-top: 15px;
        }

        .btn-ingresar:hover {
            background: #880e4f;
        }

        .enlaces a {
            color: #c2185b;
            font-weight: bold;
        }

        .error {
            color: #c62828;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="container contenedor">

    <div class="row">
        <div class="col s12 m8 l6 offset-m2 offset-l3">

            <div class="card tarjeta z-depth-4">

                <div class="encabezado">
                    <h3>Beauty Manager</h3>
                    <p>Tu belleza, nuestro compromiso</p>
                </div>

                <img src="${pageContext.request.contextPath}/imagenes/salon.png"
                     class="imagen"
                     alt="Salón de belleza">

                <div class="card-content contenido">

                    <h5 class="center-align">
                        Iniciar sesión
                    </h5>

                    <% if(request.getAttribute("mensaje") != null) { %>
                        <p class="error">
                            <%= request.getAttribute("mensaje") %>
                        </p>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/acceso"
                          method="POST">

                        <div class="input-field">
                            <i class="material-icons prefix">person</i>

                            <input type="text"
                                   id="usuario"
                                   name="usuario"
                                   required>

                            <label for="usuario">Usuario</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">lock</i>

                            <input type="password"
                                   id="password"
                                   name="password"
                                   required>

                            <label for="password">Contraseña</label>
                        </div>

                        <button type="submit"
                                class="btn btn-ingresar">
                            INGRESAR
                        </button>

                    </form>

                    <div class="center-align enlaces"
                         style="margin-top:25px;">

                        <p>
                            <a href="${pageContext.request.contextPath}/recuperarPassword">
                                ¿Olvidaste tu contraseña?
                            </a>
                        </p>

                        <p class="grey-text text-darken-1">
                            El registro de empleados está disponible
                            únicamente desde el sistema.
                        </p>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>
