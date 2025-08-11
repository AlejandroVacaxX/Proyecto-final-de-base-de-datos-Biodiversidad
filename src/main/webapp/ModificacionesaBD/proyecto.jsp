<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es-MX"> 
<link rel="stylesheet" href="css/styleCuestionario.css">
<head>
    <title>Consulta de Biodiversidad</title>
    <meta charset="UTF-8">
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        img {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
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
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(dburl,user,password);
            stmt = con.createStatement();
            String Tipo = "";
            String Ecosistema = "";
            String Crea = "";
            
            /* recuperando datos del formulario */
            request.setCharacterEncoding("UTF-8");
            Tipo = request.getParameter("tipo");

            switch(Tipo) {
    case "1":
        Crea = "select proyectos, calculo from proyectosbiodiversidad;";
        break;
        
    default:
        Crea = "SELECT * FROM   proyectosbiodiversidad LIMIT 1"; // Consulta por defecto
        break;
}
    %>
    <%
    System.out.println("Consulta SQL: " + Crea); // Verás el error claramente
%>
    
    <h1>Resultados para <%= Tipo %> en ecosistema <%= Ecosistema %></h1>
    
    <%
            rs = stmt.executeQuery(Crea);
            
            // Mostrar resultados en tabla
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>Proyectos por millon de habitantes</th>");
            out.println("<th>Como se genero el calculo?</th>");
            out.println("</tr>");
            
            while(rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("proyectos") + "</td>");
                out.println("<td>" + rs.getString("calculo") + "</td>");
                out.println("</tr>");
            }
            
            out.println("</table>");
            
        } catch(Exception e) {
            out.println("<h2 style='color:red'>Error: " + e.getMessage() + "</h2>");
        } finally {
            if(con != null) con.close();
        }
    %>
    
    <br><br>
    <a href="../catServicios.jsp" class="back-btn">Hacer otra consulta</a>
    <a href="../index.html" class="back-btn">Regresar al menu</a>
</body>
</html>