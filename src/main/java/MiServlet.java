import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
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
    //aqui se ponen las las variables para entrar a la base de datos
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/indicedebiodiversidadurbanadelaciudaddemexico";
    private static final String USER = "bakaa";
    private static final String PASS = "";
    //esto fue lo mas dificil y lo hizo chatgpt porque la documentacion casi me hace llorar XD
    //pero es una funcion que trae la biblioteca, la logica es que si la consulta es incorrecto la funcion manda mensaje de "Bad request"
    //cuando una consulta pide un select de una tabla que no existe esta funcion le dice que no existe
    //https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost-javax.servlet.http.HttpServletRequest-javax.servlet.http.HttpServletResponse-
    //me hubiera encantado hacer el 100% del codigo pero con el tiempo que se me dio jamas hubiera podido realizarlo (bendita IA), aun asi intente leer 
    //toda la informacion que pude y entender cada linea de codigo, en el futuro me encantaria hacer un proyecto de este tipo 100% a manita.
   
    @Override //todas las funciones que tomen informacion de la web llevan estos atributos y siempre un throws
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String consulta = request.getParameter("consulta");

        // Validaciones
        // esto me lo enseño el profesor ismael :)
        isEmpty(request, response, consulta);

        consulta = consulta.trim();

        //hacemos mas robusta la app si ponemos estos if´s de verificacion :)
        if (!esConsultaSQLValida(consulta) ) {
            request.setAttribute("error", "Consulta no permitida. Use solo SELECT, INSERT, UPDATE, DELETE");
            forwardToJSP(request, response);
            return;
        }
        if(esDropDatabase(consulta)){
            request.setAttribute("error", "No se puede borrar tablas ni la base de datos");
            forwardToJSP(request, response);
            return;
        }

        // Intentamos hacer una conexion a la base de datos :)
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement()) {
            /* Esta linea esta cabrona, parto el String en un array separado por espacios '//s'
             * no importa el numero de espacios los pone en un array por el '+'
             * tomo el indice [0] y lo meto en tipo de consulta
             */
            String tipoConsulta = consulta.split("\\s+")[0].toUpperCase();

            if (tipoConsulta.equals("SELECT")) {
                ResultSet rs = stmt.executeQuery(consulta);
                request.setAttribute("resultSet", rs);
                forwardToJSP(request, response);
                rs.close(); // Cerrar ResultSet después de usarlo
            } else { // si no se realiza un select mandamos esto, significa que modificaremos tablas :)
                // no vayan a usar drop database :(
                int filasAfectadas = stmt.executeUpdate(consulta); //aqui mandamos la orden  a update jeje
                request.setAttribute("message", "Comando ejecutado. Filas afectadas: " + filasAfectadas);
                forwardToJSP(request, response); 
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            forwardToJSP(request, response);
        }
    }
    
    //toma la informacion y la pasa a la siguiente pagina los datos recopilados por la consulta sin
    //que el usuario lo note pues no cambia la url
    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultados.jsp");
        dispatcher.forward(request, response);
    }

    //con esto validamos que tipo de consulta se realiza
    //si la consulta no empieza con estas palabras no te deja realizar naranjas dulces
    private boolean esConsultaSQLValida(String consulta) {
        return consulta.matches("(?i)^(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).+");
    }
    //esta funcion evita que alguien borre la bd jeje :)
    private boolean esDropDatabase(String consulta){
        
        consulta = consulta.trim().toLowerCase();
        return consulta.matches(".*\\bdrop\\s+(database|schema|table)\\b.*");   
       //esta expresion simple se la rifo el profe (DIOS) Ismael
    }
    private void isEmpty(HttpServletRequest request, HttpServletResponse response, String consulta) throws ServletException, IOException{

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