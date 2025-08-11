<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="es-MX"> 
<link rel="stylesheet" href="../css/styleCuestionario.css">
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
            
            /* recuperando datos del formulario */
            request.setCharacterEncoding("UTF-8");
            Tipo = request.getParameter("tipoanimal");
            Ecosistema = request.getParameter("tipoeco");
            
            //Generando la consulta
            String Crea = "SELECT a.nombre, a.nombre_cientifico, a.exotica, a.invasora, a.foto_url, eco.categoria_iucn FROM " + Tipo + " AS a JOIN ecosistema eco ON eco.id_ecosistema = a.id_ecosistema where eco.categoria_iucn ='"+Ecosistema+"' ;";
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
    out.println("<th>Nombre</th>");
    out.println("<th>Nombre Científico</th>");
    out.println("<th>Exótica</th>");
    out.println("<th>Invasora</th>");
    out.println("<th>Imagen</th>");
    out.println("<th>Categoría IUCN</th>");
    out.println("</tr>");
    
    while(rs.next()) {
        // Generar nombre de archivo automático basado en nombre científico
        String nombreArchivo = rs.getString("nombre").toLowerCase()
                                      .replace(" ", "_")
                                      .replace("á", "a").replace("é", "e").replace("í", "i")
                                      .replace("ó", "o").replace("ú", "u") + ".jpg";
        
        // Ruta relativa a la carpeta de imágenes
        String rutaImagen = request.getContextPath() + "/imagenes/" + nombreArchivo;
        
        out.println("<tr>");
        out.println("<td>" + rs.getString("nombre") + "</td>");
        out.println("<td>" + rs.getString("nombre_cientifico") + "</td>");
        out.println("<td>" + rs.getString("exotica") + "</td>");
        out.println("<td>" + rs.getString("invasora") + "</td>");
        out.println("<td><img src='" + rutaImagen + "' alt='Imagen de " + rs.getString("nombre") + "' style='max-width:100px; height:auto; border:1px solid #ddd;'></td>");
        out.println("<td>" + rs.getString("categoria_iucn") + "</td>");
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
    <a href="MuestraAnimales.jsp" class="back-btn">Hacer otra consulta</a>
    <a href="../index.html" class="back-btn">Regresar al menu</a>
</body>
</html>