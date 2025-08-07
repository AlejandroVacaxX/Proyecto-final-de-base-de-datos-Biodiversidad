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

//Esto es un controller como el profe Ismael nos enseño pero con el protocolo http jeje
@WebServlet("/MiServlet")
public class MiServlet extends HttpServlet {
    // aqui se ponen las las variables para entrar a la base de datos
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/indicedebiodiversidadurbanadelaciudaddemexico";
    private static final String USER = "bakaa";
    private static final String PASS = "";
    // esto fue lo mas dificil y lo hizo chatgpt porque la documentacion casi me
    // hace llorar XD
    // pero es una funcion que trae la biblioteca, la logica es que si la consulta
    // es incorrecto la funcion manda mensaje de "Bad request"
    // cuando una consulta pide un select de una tabla que no existe esta funcion le
    // dice que no existe
    // https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost-javax.servlet.http.HttpServletRequest-javax.servlet.http.HttpServletResponse-
    // me hubiera encantado hacer el 100% del codigo pero con el tiempo que se me
    // dio jamas hubiera podido realizarlo (bendita IA), aun asi intente leer
    // toda la informacion que pude y entender cada linea de codigo, en el futuro me
    // encantaria hacer un proyecto de este tipo 100% a manita.

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipoConsulta = request.getParameter("tipoConsulta");
        String parametroAdicional = request.getParameter("parametroadicional");
        String consultaUsuario = request.getParameter("consulta");
        String formulario = request.getParameter("formulario");

        // Validaciones básicas

        if ("sqlCrudo".equals(formulario)) {
            if (consultaUsuario == null || consultaUsuario.trim().isEmpty()) {
                request.setAttribute("error", "Por favor ingrese una consulta válida");
                forwardToJSP(request, response);
                return;
            }
        } else if ("catGeo".equals(formulario)) {
            if (tipoConsulta == null || tipoConsulta.trim().isEmpty()) {
                request.setAttribute("error", "Debe seleccionar un tipo de consulta");
                forwardToJSP(request, response);
                return;
            }

            // Solo para ciertas consultas, el parámetro adicional es obligatorio
            if ((tipoConsulta.equals("consulta2") || tipoConsulta.equals("consulta3")) &&
                    (parametroAdicional == null || parametroAdicional.trim().isEmpty())) {
                request.setAttribute("error", "Falta el parámetro adicional para esta consulta");
                forwardToJSP(request, response);
                return;
            }
        }

        // Determinar qué consulta ejecutar
        String consultaSQL;
        try {
            if (tipoConsulta != null) {
                // Consultas predefinidas (geo)
                consultaSQL = obtenerConsultaPredefinida(tipoConsulta, parametroAdicional);
            } else {
                // Consulta personalizada del usuario
                consultaSQL = consultaUsuario.trim();

                if (!esConsultaSQLValida(consultaSQL)) {
                    request.setAttribute("error", "Consulta no permitida. Use solo SELECT, INSERT, UPDATE, DELETE");
                    forwardToJSP(request, response);
                    return;
                }

                if (esDropDatabase(consultaSQL)) {
                    request.setAttribute("error", "No se puede borrar tablas ni la base de datos");
                    forwardToJSP(request, response);
                    return;
                }
            }

            // Ejecutar consulta
            ejecutarConsulta(request, response, consultaSQL);

        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            forwardToJSP(request, response);
        }
    }

    // Método auxiliar para consultas predefinidas
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
                        "WHERE a.nombre = ' " + parametroAdicional + "'";

            default:
                throw new IllegalArgumentException("Tipo de consulta no válido");
        }
    }

    // Método reutilizable para ejecución de consultas
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

    // toma la informacion y la pasa a la siguiente pagina los datos recopilados por
    // la consulta sin
    // que el usuario lo note pues no cambia la url
    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultados.jsp");
        dispatcher.forward(request, response);
    }

    // con esto validamos que tipo de consulta se realiza
    // si la consulta no empieza con estas palabras no te deja realizar naranjas
    // dulces
    private boolean esConsultaSQLValida(String consulta) {
        return consulta.matches("(?i)^(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).+");
    }

    // esta funcion evita que alguien borre la bd jeje :)
    private boolean esDropDatabase(String consulta) {

        consulta = consulta.trim().toLowerCase();
        return consulta.matches(".*\\bdrop\\s+(database|schema|table)\\b.*");
        // esta expresion simple se la rifo el profe (DIOS) Ismael
    }

    private void isEmpty(HttpServletRequest request, HttpServletResponse response, String consulta)
            throws ServletException, IOException {

        if (consulta == null || consulta.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingrese una consulta válida");
            forwardToJSP(request, response);
            return;
        }
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