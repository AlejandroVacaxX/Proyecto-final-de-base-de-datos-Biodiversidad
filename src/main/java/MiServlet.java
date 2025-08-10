import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MiServlet")
public class MiServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:postgresql://localhost:5432/indicedebiodiversidadurbanadelaciudaddemexico";
    private static final String USER = "bakaa";
    private static final String PASS = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Captura de parámetros desde el formulario
        String tipoConsulta = request.getParameter("tipoConsulta");
        String parametroAdicional = request.getParameter("parametroadicional");
        String consultaUsuario = request.getParameter("consulta");
        String formulario = request.getParameter("formulario");

        try {
            String consultaSQL;

            switch (formulario) {
                case "sqlCrudo":
                    if (consultaUsuario == null || consultaUsuario.trim().isEmpty()) {
                        request.setAttribute("error", "Por favor ingrese una consulta válida");
                        forwardToJSP(request, response);
                        return;
                    }

                    consultaUsuario = consultaUsuario.trim();

                    if (!esConsultaSQLValida(consultaUsuario)) {
                        request.setAttribute("error", "Consulta no permitida. Use solo SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER o DROP");
                        forwardToJSP(request, response);
                        return;
                    }

                    if (esDropDatabase(consultaUsuario)) {
                        request.setAttribute("error", "No se puede borrar tablas ni la base de datos");
                        forwardToJSP(request, response);
                        return;
                    }

                    consultaSQL = consultaUsuario;
                    break;

                case "catGeo":
                    if (tipoConsulta == null || tipoConsulta.trim().isEmpty()) {
                        request.setAttribute("error", "Debe seleccionar un tipo de consulta");
                        forwardToJSP(request, response);
                        return;
                    }

                    // Solo para ciertos tipos se requiere un parámetro adicional
                    if ((tipoConsulta.equals("consulta2") || tipoConsulta.equals("consulta3")) &&
                            (parametroAdicional == null || parametroAdicional.trim().isEmpty())) {
                        request.setAttribute("error", "Falta el parámetro adicional para esta consulta");
                        forwardToJSP(request, response);
                        return;
                    }

                    consultaSQL = obtenerConsultaPredefinida(tipoConsulta, parametroAdicional);
                    break;

                default:
                    request.setAttribute("error", "Formulario desconocido");
                    forwardToJSP(request, response);
                    return;
            }

            // Ejecutar la consulta
            ejecutarConsulta(request, response, consultaSQL);

        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            forwardToJSP(request, response);
        }
    }

    private String obtenerConsultaPredefinida(String tipoConsulta, String parametroAdicional) {
        switch (tipoConsulta) {
            case "consulta1":
                return "SELECT a.nombre AS alcaldia, e.categoria_iucn AS ecosistema, " +
                        "nap.nombre AS area_protegida FROM alcaldia a " +
                        "JOIN alcaldiaecosistemaprotegida aep ON a.id_alcaldia = aep.id_alcaldia " +
                        "JOIN ecosistema e ON e.id_ecosistema = aep.id_ecosistema " +
                        "LEFT JOIN nombresdeareasprotegidas nap ON nap.id_nombreareaprote = aep.id_protegida " +
                        "ORDER BY a.nombre, e.categoria_iucn";

            case "consulta2":
                return "SELECT a.nombre, a.area_total AS alcaldia, ciu.nombre AS ciudad, " +
                        "nap.nombre AS nombresdeareasprotegidas, an.superficie, " +
                        "an.porcentaje AS areasnaturales, ew.institucion, ew.url AS enlacesweb " +
                        "FROM alcaldia a JOIN ciudad ciu ON ciu.id = a.fk_ciudad " +
                        "LEFT JOIN nombresdeareasprotegidas nap ON nap.id_alcaldia = a.id_alcaldia " +
                        "LEFT JOIN areanatural an ON an.fk_alcaldia = a.id_alcaldia " +
                        "LEFT JOIN enlacesweb ew ON ew.id_alcaldia = a.id_alcaldia " +
                        "WHERE a.nombre = '" + parametroAdicional + "'";

            case "consulta3":
                return "select a.nombre AS alcaldia, n.nombre AS nombresdeareasprotegidas, area.superficie, area.porcentaje AS areanatural from alcaldia a join nombresdeareasprotegidas n ON a.id_alcaldia = n.id_alcaldia join areanatural area ON area.fk_alcaldia = a.id_alcaldia;";
            case "consulta4":
                return "SELECT \n" + //
                                        "    a.nombre AS alcaldia,\n" + //
                                        "    e.categoria_iucn AS ecosistema,\n" + //
                                        "    COUNT(p.id_planta) AS total_plantas,\n" + //
                                        "    COUNT(av.id_ave) AS total_aves,\n" + //
                                        "    COUNT(ar.id_artropodo) AS total_artropodos\n" + //
                                        "FROM \n" + //
                                        "    alcaldia a\n" + //
                                        "LEFT JOIN \n" + //
                                        "    planta p ON a.id_alcaldia = p.id_alcaldia\n" + //
                                        "LEFT JOIN \n" + //
                                        "    ave av ON a.id_alcaldia = av.id_alcaldia\n" + //
                                        "LEFT JOIN \n" + //
                                        "    artropodo ar ON a.id_alcaldia = ar.id_alcaldia\n" + //
                                        "LEFT JOIN \n" + //
                                        "    ecosistema e ON (p.id_ecosistema = e.id_ecosistema OR \n" + //
                                        "                    av.id_ecosistema = e.id_ecosistema OR \n" + //
                                        "                    ar.id_ecosistema = e.id_ecosistema)\n" + //
                                        "WHERE \n" + //
                                        "    a.nombre = '" + parametroAdicional +" 'GROUP BY \n    a.nombre, e.categoria_iucn;";
            case "consulta5":
                return "SELECT \n" + //
                                        "    a.nombre AS alcaldia,\n" + //
                                        "    nap.nombre AS area_protegida,\n" + //
                                        "    nc.categoria AS categoria_proteccion,\n" + //
                                        "    an.superficie AS superficie_area_natural\n" + //
                                        "FROM \n" + //
                                        "    alcaldia a\n" + //
                                        "JOIN \n" + //
                                        "    nombresdeareasprotegidas nap ON a.id_alcaldia = nap.id_alcaldia\n" + //
                                        "JOIN \n" + //
                                        "    nombrecategoriasdeareasprotegidas nc ON nap.id_catego = nc.id_categoareaprote\n" + //
                                        "LEFT JOIN \n" + //
                                        "    areanatural an ON a.id_alcaldia = an.fk_alcaldia\n" + //
                                        "WHERE \n" + //
                                        "    a.nombre = '" + parametroAdicional +" ' ;";
            case "consulta6":
                    return "SELECT \n" + //
                                                "    rp.id_presupuesto,\n" + //
                                                "    rp.presupuestototal,\n" + //
                                                "    rp.porcentajedelpresupuestodelaciudad,\n" + //
                                                "    gb.tipo_gasto,\n" + //
                                                "    gb.total_subcategoria,\n" + //
                                                "    ci.nombre AS ciudad\n" + //
                                                "FROM \n" + //
                                                "    registropresupuesto rp\n" + //
                                                "JOIN \n" + //
                                                "    gastobiodiversidad gb ON rp.id_presupuesto = gb.id_registro_presupuesto\n" + //
                                                "JOIN \n" + //
                                                "    ciudad ci ON rp.id_ciudad = ci.id\n" + //
                                                "LEFT JOIN \n" + //
                                                "    categoriabiofin cb ON gb.id_categoria_biofin = cb.id_categoria\n" + //
                                                "WHERE \n" + //
                                                "    ci.nombre = '" + parametroAdicional +" ';";
                                        default:
                throw new IllegalArgumentException("Tipo de consulta no válido");
        }
    }

    private void ejecutarConsulta(HttpServletRequest request, HttpServletResponse response, String consultaSQL)
            throws ServletException, IOException, SQLException {

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement()) {

            String tipo = consultaSQL.split("\\s+")[0].toUpperCase();

            if ("SELECT".equals(tipo)) {
                ResultSet rs = stmt.executeQuery(consultaSQL);
                request.setAttribute("resultSet", rs);
                forwardToJSP(request, response);
                rs.close();
            } else {
                int filas = stmt.executeUpdate(consultaSQL);
                request.setAttribute("message", "Comando ejecutado. Filas afectadas: " + filas);
                forwardToJSP(request, response);
            }
        }
    }

    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultados.jsp");
        dispatcher.forward(request, response);
    }

    private boolean esConsultaSQLValida(String consulta) {
        return consulta.matches("(?i)^(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP)\\s+.+");
    }

    private boolean esDropDatabase(String consulta) {
        consulta = consulta.trim().toLowerCase();
        return consulta.matches(".*\\bdrop\\s+(database|schema|table)\\b.*");
    }

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error cargando el driver de PostgreSQL", e);
        }
    }
}
