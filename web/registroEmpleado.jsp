<%-- 
    Document   : registroEmpleado
    Created on : 21/11/2026, 10:20:08 p. m.
    Author     : mabel
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Beauty Manager | Registro de empleado</title>

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
            margin-top: 35px;
            margin-bottom: 35px;
        }

        .tarjeta {
            border-radius: 18px;
            overflow: hidden;
        }

        .encabezado {
            background: #ec407a;
            color: white;
            text-align: center;
            padding: 22px;
        }

        .encabezado h4 {
            font-weight: bold;
            margin: 0;
        }

        .contenido {
            padding: 30px !important;
        }

        .btn-registrar {
            background: #c2185b;
            width: 100%;
            border-radius: 25px;
            margin-top: 15px;
        }

        .btn-registrar:hover {
            background: #880e4f;
        }

        .mensaje {
            text-align: center;
            font-weight: bold;
            color: #c2185b;
            margin-bottom: 20px;
        }

        .enlace {
            color: #c2185b;
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
                    <h4>Beauty Manager</h4>
                    <p>Registro de empleados</p>
                </div>

                <div class="card-content contenido">

                    <h5 class="center-align">
                        Crear cuenta de empleado
                    </h5>

                    <% if(request.getAttribute("mensaje") != null) { %>
                        <p class="mensaje">
                            <%= request.getAttribute("mensaje") %>
                        </p>
                    <% } %>

                    <% if(request.getAttribute("idGenerado") != null) { %>
                        <div class="card-panel pink lighten-5 center-align">
                            <h6>Tu registro fue exitoso.</h6>
                            <p>Tu usuario para iniciar sesión es:</p>
                            <h4 class="pink-text text-darken-2">
                                <strong>
                                    <%= request.getAttribute("idGenerado") %>
                                </strong>
                            </h4>
                            <p>Guarda este número para ingresar a Beauty Manager.</p>
                        </div>
                    <% } %>

                    <form action="${pageContext.request.contextPath}/registroEmpleado"
                          method="POST">

                        <div class="input-field">
                            <i class="material-icons prefix">person</i>
                            <input type="text"
                                   id="nombre"
                                   name="nombre"
                                   maxlength="100"
                                   required>
                            <label for="nombre">Nombre completo</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">badge</i>
                            <input type="text"
                                   id="cedula"
                                   name="cedula"
                                   maxlength="20"
                                   required>
                            <label for="cedula">Número de cédula</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">work</i>
                            <input type="text"
                                   id="cargo"
                                   name="cargo"
                                   maxlength="50"
                                   required>
                            <label for="cargo">Cargo</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">email</i>
                            <input type="email"
                                   id="correo"
                                   name="correo"
                                   maxlength="100"
                                   required>
                            <label for="correo">Correo electrónico</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">lock</i>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   minlength="8"
                                   required>
                            <label for="password">Contraseña</label>
                        </div>

                        <div class="input-field">
                            <i class="material-icons prefix">lock_outline</i>
                            <input type="password"
                                   id="confirmarPassword"
                                   name="confirmarPassword"
                                   minlength="8"
                                   required>
                            <label for="confirmarPassword">
                                Confirmar contraseña
                            </label>
                        </div>

                        <button type="submit"
                                class="btn btn-registrar">
                            REGISTRAR EMPLEADO
                        </button>

                    </form>

                    <div class="center-align" style="margin-top:25px;">
                        <a class="enlace"
                           href="${pageContext.request.contextPath}/principal.jsp">
                            Volver al inicio de sesión
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js">
</script>

</body>
</html>
