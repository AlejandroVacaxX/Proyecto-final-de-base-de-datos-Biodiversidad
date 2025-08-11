<%@ page import="java.sql.*" %>
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
                        
                        String Nombre ="";
                        String AreaNaturalProtegida ="";
                        String AreaNPEfec="";
                        String Crea = "";
                %>
		<span> Capturando información del formulario</span>
                <br> <br> <br> 
                <%
                        /* recuperando datos del formulario */
                        request.setCharacterEncoding("UTF-8");
                        
                        Nombre = request.getParameter("nombre");
                        AreaNaturalProtegida = request.getParameter("areaP");
                        AreaNPEfec = request.getParameter("areaE");
                       
                        //Generando la actualización con el nombre dado en el formulario
                       
                        String consultaCombinada = "INSERT INTO territorioareanatprotegida (totalprotegida, totalprotegidaefectiva) VALUES (" + 
                                                   AreaNaturalProtegida + ", " + AreaNPEfec + ")";
                        String consulta1 = "INSERT INTO nombresdeareasprotegidas (nombre) VALUES ('" + Nombre + "')";
                        Crea = consultaCombinada + "; " + consulta1 + "; ";
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