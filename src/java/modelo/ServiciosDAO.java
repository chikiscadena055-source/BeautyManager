/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServiciosDAO {

    public List<ServicioVO> listarServicios() {

        List<ServicioVO> lista = new ArrayList<>();

        String sql = "SELECT id_Servicio, nombre, precio, "
                   + "descripcion FROM servicios";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return lista;
            }

            try (PreparedStatement ps =
                    con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    ServicioVO servicio = new ServicioVO();

                    servicio.setId_Servicio(
                        rs.getInt("id_Servicio")
                    );

                    servicio.setNombre(
                        rs.getString("nombre")
                    );

                    servicio.setPrecio(
                        rs.getDouble("precio")
                    );

                    servicio.setDescripcion(
                        rs.getString("descripcion")
                    );

                    lista.add(servicio);
                }
            }

        } catch (SQLException e) {

            System.out.println(
                "Error al consultar servicios: "
                + e.getMessage()
            );
        }

        return lista;
    }
}
