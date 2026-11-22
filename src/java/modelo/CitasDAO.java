/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */



package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CitasDAO {

    public boolean registrarCita(CitasVO cita) {

        String sql = "INSERT INTO citas "
                + "(fecha_hora, estado, id_Cliente, "
                + "id_Empleado, id_Servicio) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                LocalDateTime fechaHora =
                        LocalDateTime.parse(cita.getFechaHora());

                ps.setTimestamp(1, Timestamp.valueOf(fechaHora));
                ps.setString(2, cita.getEstado());
                ps.setInt(3, cita.getId_Cliente());
                ps.setInt(4, cita.getId_Empleado());
                ps.setInt(5, cita.getId_Servicio());

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException | RuntimeException e) {

            System.out.println("Error al registrar cita: "
                    + e.getMessage());

            return false;
        }
    }

    // Consultar todas las citas registradas
    public List<CitasVO> listarCitas() {

        List<CitasVO> lista = new ArrayList<>();

        String sql = "SELECT c.id_Cita, c.fecha_hora, c.estado, "
                + "c.id_Cliente, c.id_Empleado, c.id_Servicio, "
                + "cl.nombre AS nombreCliente, "
                + "e.nombre AS nombreEmpleado, "
                + "s.nombre AS nombreServicio "
                + "FROM citas c "
                + "INNER JOIN clientes cl "
                + "ON c.id_Cliente = cl.id_Cliente "
                + "INNER JOIN empleados e "
                + "ON c.id_Empleado = e.id_Empleado "
                + "INNER JOIN servicios s "
                + "ON c.id_Servicio = s.id_Servicio "
                + "ORDER BY c.fecha_hora DESC";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return lista;
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    CitasVO cita = new CitasVO();

                    cita.setId_Cita(rs.getInt("id_Cita"));
                    cita.setFechaHora(
                            rs.getTimestamp("fecha_hora").toLocalDateTime().toString()
                    );
                    cita.setEstado(rs.getString("estado"));
                    cita.setId_Cliente(rs.getInt("id_Cliente"));
                    cita.setId_Empleado(rs.getInt("id_Empleado"));
                    cita.setId_Servicio(rs.getInt("id_Servicio"));

                    cita.setNombreCliente(
                            rs.getString("nombreCliente")
                    );

                    cita.setNombreEmpleado(
                            rs.getString("nombreEmpleado")
                    );

                    cita.setNombreServicio(
                            rs.getString("nombreServicio")
                    );

                    lista.add(cita);
                }
            }

        } catch (SQLException | RuntimeException e) {

            System.out.println("Error al listar citas: "
                    + e.getMessage());
        }

        return lista;
    }
}
