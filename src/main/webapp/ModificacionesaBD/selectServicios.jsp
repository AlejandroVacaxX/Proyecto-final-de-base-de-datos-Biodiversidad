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
        Crea = "SELECT  g.id_gasto,g.tipo_gasto,g.subcategoria, g.total_subcategoria, r.presupuestototal, (g.total_subcategoria * 100 / r.presupuestototal) AS porcentaje_del_total FROM  gastobiodiversidad g JOIN  registropresupuesto r ON g.id_registro_presupuesto = r.id_presupuesto WHERE  g.tipo_gasto = 'biofin' AND r.fecha BETWEEN '2019-01-01' AND '2019-12-31' ORDER BY  g.total_subcategoria DESC;";
        break;
        
    case "2":
        Crea = "SELECT  g.id_gasto,g.tipo_gasto,g.subcategoria, g.total_subcategoria, r.presupuestototal, (g.total_subcategoria * 100 / r.presupuestototal) AS porcentaje_del_total FROM  gastobiodiversidad g JOIN  registropresupuesto r ON g.id_registro_presupuesto = r.id_presupuesto WHERE  g.tipo_gasto = 'Actividad ambiental' AND r.fecha BETWEEN '2019-01-01' AND '2019-12-31' ORDER BY  g.total_subcategoria DESC;";
        break;
        
    default:
        Crea = "SELECT * FROM administrabiodiversidad LIMIT 1"; // Consulta por defecto
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
            out.println("<th>Tipo de gasto</th>");
            out.println("<th>Subcategoria</th>");
            out.println("<th>Total por subcategoria</th>");
            out.println("<th>Presupuesto total</th>");
            out.println("<th>Porcentaje calculado</th>");
            out.println("</tr>");
            
            while(rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("tipo_gasto") + "</td>");
                out.println("<td>" + rs.getString("subcategoria") + "</td>");
                out.println("<td>" + rs.getString("total_subcategoria") + "</td>");
                out.println("<td>" + rs.getString("presupuestototal") + "</td>");
                out.println("<td>" + rs.getString("porcentaje_del_total") + "</td>");
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