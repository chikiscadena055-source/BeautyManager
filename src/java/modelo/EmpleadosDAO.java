/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class EmpleadosDAO {

    private static final int ITERACIONES = 120000;
    private static final int LONGITUD_HASH = 256;
    private static final int LONGITUD_SALT = 16;

    // Generar una contraseña protegida
    private String hashPassword(String password)
            throws GeneralSecurityException {

        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[LONGITUD_SALT];
        random.nextBytes(salt);

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                ITERACIONES,
                LONGITUD_HASH
        );

        try {
            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

            byte[] hash = factory.generateSecret(spec).getEncoded();

            return "PBKDF2$" + ITERACIONES + "$"
                    + Base64.getEncoder().encodeToString(salt) + "$"
                    + Base64.getEncoder().encodeToString(hash);

        } finally {
            spec.clearPassword();
        }
    }

    // Verificar una contraseña protegida
    private boolean verificarPassword(String password, String almacenada) {

        try {
            String[] partes = almacenada.split("\\$");

            if (partes.length != 4 || !partes[0].equals("PBKDF2")) {
                return false;
            }

            int iteraciones = Integer.parseInt(partes[1]);
            byte[] salt = Base64.getDecoder().decode(partes[2]);
            byte[] hashOriginal = Base64.getDecoder().decode(partes[3]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    iteraciones,
                    hashOriginal.length * 8
            );

            try {
                SecretKeyFactory factory =
                        SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");

                byte[] hashCalculado =
                        factory.generateSecret(spec).getEncoded();

                return MessageDigest.isEqual(hashOriginal, hashCalculado);

            } finally {
                spec.clearPassword();
            }

        } catch (GeneralSecurityException | IllegalArgumentException e) {
            System.out.println("Error al verificar contraseña: " + e.getMessage());
            return false;
        }
    }

    // Validar usuario y contraseña
    public boolean validarEmpleado(String usuario, String password) {

        String sql = "SELECT pass_Empleado FROM empleados WHERE id_Empleado = ?";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return false;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, usuario);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        return false;
                    }

                    String almacenada = rs.getString("pass_Empleado");

                    if (almacenada == null || password == null) {
                        return false;
                    }

                    if (almacenada.startsWith("PBKDF2$")) {
                        return verificarPassword(password, almacenada);
                    }

                    // Compatibilidad con contraseñas antiguas
                    boolean coincide = MessageDigest.isEqual(
                            password.getBytes(java.nio.charset.StandardCharsets.UTF_8),
                            almacenada.getBytes(java.nio.charset.StandardCharsets.UTF_8)
                    );

                    if (coincide) {
                        actualizarPassword(usuario, password);
                    }

                    return coincide;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al validar empleado: " + e.getMessage());
            return false;
        }
    }

    // Actualizar contraseña antigua al formato protegido
    private void actualizarPassword(String usuario, String password) {

        String sql = "UPDATE empleados SET pass_Empleado = ? WHERE id_Empleado = ?";

        try {
            String passwordProtegida = hashPassword(password);

            try (Connection con = Conexion.conectar()) {

                if (con == null) {
                    return;
                }

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, passwordProtegida);
                    ps.setString(2, usuario);
                    ps.executeUpdate();
                }
            }

        } catch (SQLException | GeneralSecurityException e) {
            System.out.println("Error al actualizar contraseña: " + e.getMessage());
        }
    }

    // Obtener nombre del empleado
    public String obtenerNombreEmpleado(String usuario) {

        String sql = "SELECT nombre FROM empleados WHERE id_Empleado = ?";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return null;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, usuario);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        return rs.getString("nombre");
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al obtener nombre: " + e.getMessage());
        }

        return null;
    }

    // Listar empleados
    public List<EmpleadosVO> listarEmpleados() {

        List<EmpleadosVO> lista = new ArrayList<>();

        String sql = "SELECT id_Empleado, nombre, cargo "
                   + "FROM empleados ORDER BY nombre";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return lista;
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    EmpleadosVO empleado = new EmpleadosVO();

                    empleado.setId_Empleado(rs.getInt("id_Empleado"));
                    empleado.setNombre(rs.getString("nombre"));
                    empleado.setCargo(rs.getString("cargo"));

                    lista.add(empleado);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al listar empleados: " + e.getMessage());
        }

        return lista;
    }

    // Verificar si la cédula ya existe
    public boolean existeCedula(String cedula) {

        String sql = "SELECT id_Empleado FROM empleados WHERE cedula = ?";

        try (Connection con = Conexion.conectar()) {

            if (con == null) {
                return true;
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, cedula);

                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al verificar cédula: " + e.getMessage());
            return true;
        }
    }

    // Registrar empleado y recuperar el ID generado
    public int registrarEmpleado(String nombre, String cedula, String cargo,
            String correo, String password) {

        String sql = "INSERT INTO empleados "
                   + "(nombre, cedula, cargo, correo, pass_Empleado) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try {

            String passwordProtegida = hashPassword(password);

            try (Connection con = Conexion.conectar()) {

                if (con == null) {
                    return -1;
                }

                try (PreparedStatement ps = con.prepareStatement(
                        sql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setString(1, nombre);
                    ps.setString(2, cedula);
                    ps.setString(3, cargo);
                    ps.setString(4, correo);
                    ps.setString(5, passwordProtegida);

                    int filas = ps.executeUpdate();

                    if (filas > 0) {

                        try (ResultSet rs = ps.getGeneratedKeys()) {

                            if (rs.next()) {
                                return rs.getInt(1);
                            }
                        }
                    }
                }
            }

        } catch (SQLException | GeneralSecurityException e) {
            System.out.println("Error al registrar empleado: " + e.getMessage());
        }

        return -1;
    }

    // Restablecer contraseña verificando usuario y cédula
    public boolean restablecerPassword(String usuario, String cedula,
            String nuevaPassword) {

        String sql = "UPDATE empleados SET pass_Empleado = ? "
                   + "WHERE id_Empleado = ? AND cedula = ?";

        try {

            String passwordProtegida = hashPassword(nuevaPassword);

            try (Connection con = Conexion.conectar()) {

                if (con == null) {
                    return false;
                }

                try (PreparedStatement ps = con.prepareStatement(sql)) {

                    ps.setString(1, passwordProtegida);
                    ps.setString(2, usuario);
                    ps.setString(3, cedula);

                    return ps.executeUpdate() > 0;
                }
            }

        } catch (SQLException | GeneralSecurityException e) {
            System.out.println("Error al restablecer contraseña: " + e.getMessage());
            return false;
        }
    }
}
