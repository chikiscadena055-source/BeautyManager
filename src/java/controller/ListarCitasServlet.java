/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controller;

import modelo.CitasDAO;
import modelo.CitasVO;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ListarCitasServlet", urlPatterns = {"/listarCitas"})
public class ListarCitasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/principal.jsp");
            return;
        }

        CitasDAO dao = new CitasDAO();

        List<CitasVO> citas = dao.listarCitas();

        request.setAttribute("citas", citas);

        request.getRequestDispatcher(
                "/citas/listarCitas.jsp"
        ).forward(request, response);
    }
}

