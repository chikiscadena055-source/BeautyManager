<%-- 
    Document   : inicio
    Created on : 15/11/2026, 7:32:28 p. m.
    Author     : mabel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="modelo.ServicioVO"%>

<%
    // Verificar que el empleado haya iniciado sesión
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(
            request.getContextPath() + "/principal.jsp"
        );
        return;
    }

    String nombreEmpleado =
        (String) session.getAttribute("nombreEmpleado");

    if (nombreEmpleado == null || nombreEmpleado.trim().isEmpty()) {
        nombreEmpleado = "Empleado";
    }

    // Obtener los servicios enviados por InicioServlet
    List<ServicioVO> servicios =
        (List<ServicioVO>) request.getAttribute("servicios");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Beauty Manager | Inicio</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">

    <style>
        body {
            background-color: #fce4ec;
            font-family: Arial, sans-serif;
        }

        nav {
            background-color: #ec407a;
        }

        .brand-logo {
            font-weight: bold;
            margin-left: 15px;
        }

        .bienvenida {
            background: linear-gradient(
                rgba(136, 14, 79, 0.55),
                rgba(194, 24, 91, 0.65)
            ),
            url('<%=request.getContextPath()%>/imagenes/salon.png');

            background-size: cover;
            background-position: center;
            min-height: 300px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            padding: 35px 15px;
        }

        .bienvenida h3 {
            font-weight: bold;
            text-shadow: 2px 2px 5px #333;
        }

        .bienvenida p {
            font-size: 18px;
        }

        .titulo-seccion {
            color: #880e4f;
            font-weight: bold;
            margin-top: 40px;
            margin-bottom: 25px;
            text-align: center;
        }

        .card {
            border-radius: 15px;
            overflow: hidden;
        }

        .imagen-servicio {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
        }

        .card-title {
            color: #880e4f !important;
            font-weight: bold !important;
        }

        .icono {
            color: #ec407a;
            font-size: 45px;
        }

        .precio {
            color: #c2185b;
            font-weight: bold;
            font-size: 18px;
            margin-top: 12px;
        }

        .card-action a {
            color: #c2185b !important;
            font-weight: bold;
        }

        .boton-principal {
            background-color: #c2185b;
            border-radius: 25px;
        }

        .boton-principal:hover {
            background-color: #880e4f;
        }

        footer {
            background-color: #880e4f;
            color: white;
            text-align: center;
            padding: 18px;
            margin-top: 40px;
        }
    </style>
</head>

<body>

    <!-- Menú principal -->
    <nav>
        <div class="nav-wrapper">
            <a href="<%=request.getContextPath()%>/inicio"
               class="brand-logo">
                Beauty Manager
            </a>

            <ul class="right hide-on-med-and-down">
                <li>
                    <a href="<%=request.getContextPath()%>/inicio">
                        Inicio
                    </a>
                </li>

                <li>
                    <a href="<%=request.getContextPath()%>/cerrarSesion.jsp">
                        <i class="material-icons left">exit_to_app</i>
                        Cerrar sesión
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Bienvenida -->
    <section class="bienvenida">
        <h3>Bienvenido a Beauty Manager</h3>

        <h5>
            Hola, <strong><%=nombreEmpleado%></strong>
        </h5>

        <p>
            Administra los servicios, clientes y citas de tu salón
            de belleza.
        </p>
    </section>

    <div class="container">

        <!-- Servicios -->
        <h4 class="titulo-seccion">
            Nuestros servicios
        </h4>

        <div class="row">

            <%
                if (servicios != null && !servicios.isEmpty()) {

                    for (ServicioVO servicio : servicios) {

                        String nombreServicio =
                            servicio.getNombre() == null
                            ? ""
                            : servicio.getNombre().trim().toLowerCase(
                                new Locale("es", "CO")
                            );

                        String imagenServicio = "corte.jpg";

                        switch (nombreServicio) {
                            case "corte de cabello":
                                imagenServicio = "corte.jpg";
                                break;

                            case "manicure":
                                imagenServicio = "manicure.jpg";
                                break;

                            case "pedicure":
                                imagenServicio = "pedicure.jpg";
                                break;

                            case "corte básico":
                                imagenServicio = "corte_basico.jpg";
                                break;

                            case "corte premium":
                                imagenServicio = "corte_premium.jpg";
                                break;

                            case "manicure clásica":
                                imagenServicio = "manicure_clasica.jpg";
                                break;

                            case "pedicure spa":
                                imagenServicio = "pedicure_spa.jpg";
                                break;
                        }
            %>

            <div class="col s12 m6 l4">
                <div class="card hoverable">

                    <!-- Fotografía del servicio -->
                    <div class="card-image">
                        <img
                            src="<%=request.getContextPath()%>/imagenes/servicios/<%=imagenServicio%>"
                            alt="<%=servicio.getNombre()%>"
                            class="imagen-servicio">
                    </div>

                    <div class="card-content center-align">

                        <span class="card-title">
                            <%=servicio.getNombre()%>
                        </span>

                        <p>
                            <%=servicio.getDescripcion()%>
                        </p>

                        <p class="precio">
                            $<%=String.format(
                                new Locale("es", "CO"),
                                "%,.0f",
                                servicio.getPrecio()
                            )%>
                        </p>

                    </div>

                </div>
            </div>

            <%
                    }

                } else {
            %>

            <div class="col s12">
                <div class="card-panel pink lighten-5 center-align">
                    No hay servicios disponibles para mostrar.
                </div>
            </div>

            <%
                }
            %>

        </div>

        <!-- Administración de clientes -->
        <h4 class="titulo-seccion">
            Administración de clientes
        </h4>

        <div class="row">

            <div class="col s12 m6">
                <div class="card hoverable center-align">

                    <div class="card-content">
                        <i class="material-icons icono">
                            person_add
                        </i>

                        <span class="card-title">
                            Registrar cliente
                        </span>

                        <p>
                            Agregar un nuevo cliente al sistema.
                        </p>
                    </div>

                    <div class="card-action">
                        <a href="<%=request.getContextPath()%>/clientes">
                            Registrar cliente
                        </a>
                    </div>

                </div>
            </div>

            <div class="col s12 m6">
                <div class="card hoverable center-align">

                    <div class="card-content">
                        <i class="material-icons icono">
                            people
                        </i>

                        <span class="card-title">
                            Listar clientes
                        </span>

                        <p>
                            Consultar los clientes registrados.
                        </p>
                    </div>

                    <div class="card-action">
                        <a href="<%=request.getContextPath()%>/listarClientes">
                            Ver clientes
                        </a>
                    </div>

                </div>
            </div>

        </div>

        <!-- Administración de citas -->
        <h4 class="titulo-seccion">
            Administración de citas
        </h4>

        <div class="row">

            <div class="col s12 m6">
                <div class="card hoverable center-align">

                    <div class="card-content">
                        <i class="material-icons icono">
                            event_available
                        </i>

                        <span class="card-title">
                            Registrar cita
                        </span>

                        <p>
                            Programar una nueva cita para un cliente.
                        </p>
                    </div>

                    <div class="card-action">
                        <a href="<%=request.getContextPath()%>/citas">
                            Registrar cita
                        </a>
                    </div>

                </div>
            </div>

            <div class="col s12 m6">
                <div class="card hoverable center-align">

                    <div class="card-content">
                        <i class="material-icons icono">
                            date_range
                        </i>

                        <span class="card-title">
                            Listar citas
                        </span>

                        <p>
                            Consultar las citas programadas.
                        </p>
                    </div>

                    <div class="card-action">
                        <a href="<%=request.getContextPath()%>/listarCitas">
                            Ver citas
                        </a>
                    </div>

                </div>
            </div>

        </div>

        <!-- Administración de empleados -->
        <h4 class="titulo-seccion">
            Administración de empleados
        </h4>

        <div class="row">

            <div class="col s12 m6 offset-m3">
                <div class="card hoverable center-align">

                    <div class="card-content">
                        <i class="material-icons icono">
                            person_add
                        </i>

                        <span class="card-title">
                            Registrar empleado
                        </span>

                        <p>
                            Crear una nueva cuenta de empleado
                            para acceder a Beauty Manager.
                        </p>
                    </div>

                    <div class="card-action">
                        <a href="<%=request.getContextPath()%>/registroEmpleado">
                            Registrar empleado
                        </a>
                    </div>

                </div>
            </div>

        </div>

    </div>

    <!-- Pie de página -->
    <footer>
        <p>
            Beauty Manager - Sistema de gestión para salones de belleza
        </p>
        <p>
            © 2026 Todos los derechos reservados.
        </p>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js">
    </script>

</body>
</html>
