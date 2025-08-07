<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Resultados</title>
    <link rel="stylesheet" href="style.css">
    <%--nunca pude hacer que el archivo style funcionara :( --%>
    <%--por eso pongo bien mugroso el codigo del css aqui jsjsjs :( --%>
    <%--Agradezco a  https://www.youtube.com/watch?v=krUdJ87uxXc, porque de ahi me robe el css para que quedara padrisimo la bd--%>
    <%--Pero se lo robe copiando a mano porque asi no cuenta ;)--%>

</head>
<body>
//nunca pude hacer que se centrara bonito 
<div class="audio-container">
    <audio class="audiopajarito" autoplay controller>
        <source src="bird-song-23221.mp3" type="audio/mp3">
    </audio>
</div>
    <div class="results-container">
        <%--esta madre maneja errores en consultas--%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } else if (request.getAttribute("message") != null) { %>
            <div class="success"><%= request.getAttribute("message") %></div>
        <% } else { %>
            <h2>Resultados de la Consulta</h2>
            <% 
            ResultSet rs = (ResultSet) request.getAttribute("resultSet");
            if (rs != null) {
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
            %>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr> <%-- Este for itera sobre las columnas para traer n numero--%>
                                <% for (int i = 1; i <= columnCount; i++) { %>
                                    <th><%= metaData.getColumnLabel(i) %></th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody>
                        <%-- Ahora traemos n renglones jeje--%>
                            <% while (rs.next()) { %>
                                <tr> <%--wacha el poder, esto llena de null renglones vacios --%>
                                    <% for (int i = 1; i <= columnCount; i++) { %>
                                        <td><%= rs.getString(i) != null ? rs.getString(i) : "NULL" %></td>
                                    <% } %>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        <% } %>
        <%-- aqui mandamos a traer el boton para regresar bb--%>
        <a href="index.jsp" class="back-btn">Nueva Consulta</a>
    </div>
</body>
</html>