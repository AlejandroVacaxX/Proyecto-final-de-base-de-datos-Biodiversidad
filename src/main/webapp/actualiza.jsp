<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es-MX" > 
        <head>
                <title>JSP con acceso a base de datos</title>
                <meta charset="UTF-8">
        </head>
        <body>
                <%!
                        Connection con;
                        Statement stmt;
                        ResultSet rs;
                        String dburl="jdbc:postgresql://localhost:5432/empresa";
                        String user="postgres";
                        String password="";
                %>
                <%
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(dburl,user,password);
                        stmt = con.createStatement();
                        String NombreEmp ="";
                        String NRuta ="";
                        String Actualiza = "";
                %>
		<span> Capturando información del formulario</span>
                <br> <br> <br> 
                <%
                        /* recuperando datos del formulario */
                        request.setCharacterEncoding("UTF-8");
                        NombreEmp = request.getParameter("distribuidor");
                        NRuta = request.getParameter("ruta");
                        //Generando la actualización con el nombre dado en el formulario
                        Actualiza = "update distribuidor set ruta = "+NRuta+" where nombre ='"+NombreEmp+"'";
                %>
                <span> Cuando tengo errores puedo mandar a imprimir la consulta </span>  <br><br>
                <span> Cuando ya está correcta quito la impresión y yap </span> <br><br>  <span> Es muy útil porque es>
                <%= Actualiza %>
                <br> <br><br><br><br>
                <span> Debemos Recordar Restringir el tipo de dato a escribir desde el lado  cliente y lado servidor</>
                <br> <br>
                <%
                        //generando actualización en la Base de datos
                        stmt.executeUpdate(Actualiza);
                        con.close(); //Cerrando conexión con el servidor de Base de Datos
                %> 
                <br><br><br><br><br>
                <span >Datos actualizados: </span> <br><br>
                <span> <%= NombreEmp %> a nueva Ruta número = <%= NRuta %> </span>
	</body>
</html>