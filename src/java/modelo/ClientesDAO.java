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

public class ClientesDAO {

    // Verificar si la cedula ya existe
    public boolean existeCedula(String cedula) {

        String sql = "SELECT id_Cliente FROM clientes "
                   + "WHERE cedula = ?";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return true;
            }

            try (PreparedStatement ps =
                    con.prepareStatement(sql)) {

                ps.setString(1, cedula);

                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }

        } catch (SQLException e) {

            System.out.println(
                "Error al verificar cedula: " + e.getMessage()
            );

            return true;
        }
    }

    // Registrar un cliente
    public boolean registrarCliente(ClientesVO cliente) {

        String sql = "INSERT INTO clientes "
                   + "(nombre, cedula, direccion, celular, correo) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return false;
            }

            try (PreparedStatement ps =
                    con.prepareStatement(sql)) {

                ps.setString(1, cliente.getNombre());
                ps.setString(2, cliente.getCedula());
                ps.setString(3, cliente.getDireccion());
                ps.setString(4, cliente.getCelular());
                ps.setString(5, cliente.getCorreo());

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {

            System.out.println(
                "Error al registrar cliente: " + e.getMessage()
            );

            return false;
        }
    }

    // Consultar todos los clientes
    public List<ClientesVO> listarClientes() {

        List<ClientesVO> lista = new ArrayList<>();

        String sql = "SELECT * FROM clientes ORDER BY nombre";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return lista;
            }

            try (PreparedStatement ps =
                    con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    ClientesVO cliente = new ClientesVO();

                    cliente.setId_Cliente(
                        rs.getInt("id_Cliente")
                    );

                    cliente.setNombre(
                        rs.getString("nombre")
                    );

                    cliente.setCedula(
                        rs.getString("cedula")
                    );

                    cliente.setDireccion(
                        rs.getString("direccion")
                    );

                    cliente.setCelular(
                        rs.getString("celular")
                    );

                    cliente.setCorreo(
                        rs.getString("correo")
                    );

                    lista.add(cliente);
                }
            }

        } catch (SQLException e) {

            System.out.println(
                "Error al consultar clientes: " + e.getMessage()
            );
        }

        return lista;
    }
}
