<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es-MX" > 
<link rel="stylesheet" href="../css/styleCuestionario.css">
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
                        String Tipo = "";
                        String Presupuesto ="";
                        String Subcatego = "";
                        String Crea = "";
                %>
                <%
                        /* recuperando datos del formulario */
                        request.setCharacterEncoding("UTF-8");
                        
                        Presupuesto = request.getParameter("dinero");
                        Subcatego = request.getParameter("subcategoria");
                        Tipo = request.getParameter("tipogasto");

                        //Generando la actualización con el nombre dado en el formulario
                       
                        Crea = "INSERT INTO gastobiodiversidad (tipo_gasto, subcategoria, total_subcategoria) VALUES ('"+Tipo+"','"+ Subcatego +"', '"+Presupuesto+"');";
                        
                %>     
               <h1>Datos actualizados exitosamente</h1>
                <%
                        //generando actualización en la Base de datos
                        stmt.executeUpdate(Crea);
                        con.close(); //Cerrando conexión con el servidor de Base de Datos
                %> 
                <br><br><br><br><br>

                <a href="../modificacion.jsp" class="back-btn">Regresar al menu</a>
	</body>
</html>