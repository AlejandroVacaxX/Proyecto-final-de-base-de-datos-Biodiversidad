<%@ page import="java.sql.*"    %>
<%@
    page contentType = "text/html ; charset = utf-8"
    pageEncoding = "utf-8"
%>
<!DOCTYPE html>
<hmtl lang = "es-MX">
    <head>
        <title> JSP buscar datos</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="style.css?version=${System.currentTimeMillis()}">
    </head>
    <body>
            <h1> Ingresa nuevos datos </h1>
            <form action="CreaNuevo.jsp" method="post">
    Clave: <input type="text" name="clave" required><br>
    Nombre: <input type="text" name="nombre" required><br>
    Ruta: <input type="text" name="ruta" required><br>
    <input type="submit" value="Guardar">
</form>
    </body>
    
</html>
