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
                        String TipoA = "";
                        String PresupuestoA ="";
                        String SubcategoA = "";
                        String Crea = "";
                %>
		
                <%
                        /* recuperando datos del formulario */
                        request.setCharacterEncoding("UTF-8");
                        
                        Presupuesto = request.getParameter("dinero");
                        Subcatego = request.getParameter("sucategoria");
                        Tipo = request.getParameter("tipogasto");
                       
                        Subcatego = request.getParameter("sucategoriaA");
                      

                        //Generando la actualización con el nombre dado en el formulario
                       
                        Crea = " UPDATE gastobiodiversidad SET tipo_gasto = '"+Tipo+"', subcategoria = '"+Subcatego+"', total_subcategoria = '"+Presupuesto+"' where subcategoria = '"+SubcategoA+"' ;";
                        
                %>     
                <h1>Datos actualizados exitosamente</h1>
                <%
                        //generando actualización en la Base de datos
                        stmt.executeUpdate(Crea);
                        con.close(); //Cerrando conexión con el servidor de Base de Datos
                %> 
                <br><br><br><br><br>
                <a href="../modificacion.jsp" class="back-btn">Realiza una nueva consulta</a>
                <a href="../index.html" class="back-btn">Regresar al menu</a>
	</body>
</html>