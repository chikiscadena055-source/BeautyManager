<%-- 
    Document   : cerrarSesion
    Created on : 15/11/2026, 7:37:48 p. m.
    Author     : mabel
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();

    response.sendRedirect(
        request.getContextPath() + "/principal.jsp"
    );
%>

