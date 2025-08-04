import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/MiServlet")  // Esta anotación mapea la URL al Servlet
public class MiServlet extends HttpServlet {

    // Datos de conexión a la BD (ajusta según tu configuración)
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/indicedebiodiversidadurbanadelaciudaddemexico";
    private static final String USER = "bakaa";
    private static final String PASS = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String consulta = request.getParameter("consulta");

        // Validación básica
        if (consulta == null || consulta.trim().isEmpty()) {
            enviarError(out, "Por favor ingrese una consulta válida");
            return;
        }

        consulta = consulta.trim();

        // Verifica que sea una consulta SQL (protección básica)
        if (!esConsultaSQLValida(consulta)) {
            enviarError(out, "Consulta no permitida. Use solo SELECT, INSERT, UPDATE, DELETE");
            return;
        }

        // Procesar la consulta
        try {
            procesarConsultaSQL(out, consulta);
        } catch (Exception e) {
            enviarError(out, "Error: " + e.getMessage());
        }
    }

    // Método para procesar la consulta SQL
    private void procesarConsultaSQL(PrintWriter out, String consulta) throws SQLException {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement()) {

            String tipoConsulta = consulta.split("\\s+")[0].toUpperCase();

            if (tipoConsulta.equals("SELECT")) {
                try (ResultSet rs = stmt.executeQuery(consulta)) {
                    generarTablaHTML(out, rs);
                }
            } else {
                int filasAfectadas = stmt.executeUpdate(consulta);
                out.print("<div class='success'>Comando ejecutado. Filas afectadas: " + filasAfectadas + "</div>");
            }
        }
    }

    // Genera una tabla HTML a partir del ResultSet
    private void generarTablaHTML(PrintWriter out, ResultSet rs) throws SQLException {
        ResultSetMetaData metaData = rs.getMetaData();
        int columnCount = metaData.getColumnCount();

        out.print("<div class='table-responsive'><table class='data-table'>");
        out.print("<thead><tr>");

        // Encabezados
        for (int i = 1; i <= columnCount; i++) {
            out.print("<th>" + metaData.getColumnLabel(i) + "</th>");
        }
        out.print("</tr></thead><tbody>");

        // Datos
        while (rs.next()) {
            out.print("<tr>");
            for (int i = 1; i <= columnCount; i++) {
                Object value = rs.getObject(i);
                out.print("<td>" + (value != null ? value.toString() : "NULL") + "</td>");
            }
            out.print("</tr>");
        }

        out.print("</tbody></table></div>");
    }

    // Valida que sea una consulta SQL permitida
    private boolean esConsultaSQLValida(String consulta) {
        return consulta.matches("(?i)^(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).+");
    }

    // Muestra errores en formato HTML
    private void enviarError(PrintWriter out, String mensaje) {
        out.print("<div class='error'>" + mensaje + "</div>");
    }

    // Carga el driver de PostgreSQL al iniciar el Servlet
    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error cargando el driver de PostgreSQL", e);
        }
    }
}