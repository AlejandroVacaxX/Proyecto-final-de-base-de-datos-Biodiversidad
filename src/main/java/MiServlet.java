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
//Por lo que investigue hubiera sido imposible realizar este proyecto sin el uso de un servlet
//si la comunicacion hubiera sido entre archivos .jsp no se podia, o al menos yo no pude
@WebServlet("/MiServlet")
public class MiServlet extends HttpServlet {
    //aqui se ponen las las variables para entrar a la base de datos
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/empresa";
    private static final String USER = "bakaa";
    private static final String PASS = "";
    //esto fue lo mas dificil y lo hizo chatgpt porque la documentacion casi me hace llorar XD
    //pero es una funcion que trae la biblioteca, la logica es que si la consulta es incorrecto la funcion manda mensaje de "Bad request"
    //cuando una consulta pide un select de una tabla que no existe esta funcion le dice que no existe
    //https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html#doPost-javax.servlet.http.HttpServletRequest-javax.servlet.http.HttpServletResponse-
    //me hubiera encantado hacer el 100% del codigo pero con el tiempo que se me dio jamas hubiera podido realizarlo (bendita IA), aun asi intente leer 
    //toda la informacion que pude y entender cada linea de codigo, en el futuro me encantaria hacer un proyecto de este tipo 100% a manita.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String consulta = request.getParameter("consulta");

        // Validaciones
        // esto me lo enseño el profesor ismael :)
        if (consulta == null || consulta.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingrese una consulta válida");
            forwardToJSP(request, response);
            return;
        }

        consulta = consulta.trim();
        //hacemos mas robusta la app si ponemos estos if´s de verificacion :)
        if (!esConsultaSQLValida(consulta)) {
            request.setAttribute("error", "Consulta no permitida. Use solo SELECT, INSERT, UPDATE, DELETE");
            forwardToJSP(request, response);
            return;
        }

        // Intentamos hacer una conexion a la base de datos :)
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             Statement stmt = conn.createStatement()) {
            //esto corta la palabra y lo pasa a mayusculas, gracias a esto puedo saber que tipo de consulta se realiza
            //lo saque de reddit XD
            String tipoConsulta = consulta.split("\\s+")[0].toUpperCase();

            if (tipoConsulta.equals("SELECT")) {
                ResultSet rs = stmt.executeQuery(consulta);
                request.setAttribute("resultSet", rs);
                forwardToJSP(request, response);
                rs.close(); // Cerrar ResultSet después de usarlo
            } else { // si no se realiza un select mandamos esto, significa que modificaremos tablas :)
                // no vayan a usar drop database :(
                int filasAfectadas = stmt.executeUpdate(consulta);
                request.setAttribute("message", "Comando ejecutado. Filas afectadas: " + filasAfectadas);
                forwardToJSP(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            forwardToJSP(request, response);
        }
    }
    //este obvio se nota que me lo hizo chat 
    //pero hace magia basicamente
    //toma la informacion y la pasa a la siguiente pagina los datos recopilados por la consulta
    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultados.jsp");
        dispatcher.forward(request, response);
    }
    //con esto validamos que tipo de consulta se realiza
    //si quisiera aqui podria hacer que solo se realicen consultas para evitar que se borre la bd por gente cochina
    private boolean esConsultaSQLValida(String consulta) {
        return consulta.matches("(?i)^(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP).+");
    }
    //esta funcion evita que alguien borre la bd jeje :)
    private boolean esDropDatabase( String consulta){
        String metodoEvitar = "drop database empresa";
        if(consulta.trim().equals(metodoEvitar));
        return true;
    }
    private void isEmpty(HttpServletRequest request, HttpServletResponse response, String consulta) throws ServletException, IOException{

        if (consulta == null || consulta.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingrese una consulta válida");
            forwardToJSP(request, response);
            return;
        }
    }
    
    //esto me lo recomendo chatgpt para que se note si no se cargue el driver
    //aunque para este proyecto eso nunca pasa porque se agrega a la carpeta webapps
    @Override
    public void init() throws ServletException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error cargando el driver de PostgreSQL", e);
        }
    }
}