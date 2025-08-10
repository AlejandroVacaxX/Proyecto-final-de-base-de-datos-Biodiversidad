p<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es-MX" > 

        <head>
                <title>Modificando Base de Datos</title>
                <meta charset="UTF-8">
        </head>
        <body>
                <%!
                        Connection con;
                        Statement stmt;
                        ResultSet rs;
                        String dburl="jdbc:postgresql://localhost:5432/indicedebiodiversidadurbanadelaciudaddemexico";
                        String user="bakaa";
                        String password="";
                %>
                <%
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(dburl,user,password);
                        stmt = con.createStatement();
                        String Tipo ="";
                        String Nombre ="";
                        String Ncientifico ="";
                        String Invasora="";
                        String Exotica="";
                        String NombreA="";
                        String Crea = "";
                %>
		<span> Capturando información del formulario</span>
                <br> <br> <br> 
                <%
                        /* recuperando datos del formulario */
                        request.setCharacterEncoding("UTF-8");
                        Tipo = request.getParameter("tipo");
                        Nombre = request.getParameter("nombre");
                        Ncientifico = request.getParameter("nombreC");
                        Invasora = request.getParameter("invasora");
                        Exotica = request.getParameter("exotica");
                        Boolean invasora = Boolean.parseBoolean(Invasora);
                        Boolean exotica = Boolean.parseBoolean(Exotica);
                        NombreA = request.getParameter("nombreA");
                        //Generando la actualización con el nombre dado en el formulario
                        Crea = "UPDATE "+Tipo+" SET nombre = '"+Nombre+"', "+
                                 "nombre_cientifico = '"+Ncientifico+"', "+
                                "exotica = "+exotica+", "+ "invasora = "+invasora+" WHERE nombre = '"+NombreA+"'; ";
                %>
                <span> Cuando tengo errores puedo mandar a imprimir la consulta </span>  <br><br>
                <span> Cuando ya está correcta quito la impresión y yap </span> <br><br>  <span> Es muy útil porque es>
                <%= Crea %>
                <br> <br><br><br><br>
                <span> Debemos Recordar Restringir el tipo de dato a escribir desde el lado  cliente y lado servidor</>
                <br> <br>
                <%
                        //generando actualización en la Base de datos
                        stmt.executeUpdate(Crea);
                        con.close(); //Cerrando conexión con el servidor de Base de Datos
                %> 
                <br><br><br><br><br>
                <span >Datos actualizados: </span> <br><br>
                <span> <%= Nombre %> <%= Ncientifico%> <%= invasora %> <%=exotica%> </span>
                <a href="../modificacion.jsp" class="back-btn">Regresar al menu</a>
	</body>
</html>