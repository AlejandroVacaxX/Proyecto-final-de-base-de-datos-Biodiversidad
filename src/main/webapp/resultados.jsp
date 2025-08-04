<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Resultados</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <%--nunca pude hacer que el archivo style funcionara :( --%>
    <%--por eso pongo bien mugroso el codigo del css aqui jsjsjs :( --%>
    <%--Agradezco a  https://www.youtube.com/watch?v=krUdJ87uxXc, porque de ahi me robe el css para que quedara padrisimo la bd--%>
    <%--Pero se lo robe copiando a mano porque asi no cuenta ;)--%>
    <style>
      
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    color: wheat;
}
body {
    background-image: url('naturaleza-cdmx-chapu.jpg');
    width: 100vw;  
    height: 100vh;
    background-size: cover;
    background-position: center;
    display: flex;
    align-items: center;
    justify-content: center;
    position:relative;
}
body::before {
    content: "";
    position: absolute;
    width: 100vw;  
    height: 100vh;
    background: rgba(0, 0, 0, 0.15);
    backdrop-filter: blur(5px);  
    z-index: 0;
}
.main-container {
    border: solid;
    width: 700px;
    height: 500px;
    z-index: 1;
    background: linear-gradient(
        to top, 
        rgba(0, 0, 0, 0.15),
        rgba(255, 255, 255, 0.15)
    );
    border-radius: 12px;
    backdrop-filter: blur(50px);  
    padding: 20px;
}
.input-container{
    position: relative;
}
.consulta-input{
    width: 600px;
    padding: 10px;
    border-radius: 99px;
    border: 3px solid transparent;
    background: rgba(0, 0, 0, 0.15);
    outline: none;
    font-weight: 500;
    transition: 0.25s border;
    padding-right: 45px;
}
.consulta.input:focus{
    border:3px sold rgba(255, 255, 255, 0.15)
}
.consulta-input::placeholder{
    color: rgba(255, 255, 255, 0.75);
}
.search-btn{
    position: absolute;
    right: 16px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    display: flex;
    border: none;
    cursor: pointer;
}
/*Este codigo es de las tablas*/
.results-container {
    margin-top: 20px;
    padding: 15px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-radius: 8px;
    max-height: 70vh;
    overflow-y: auto;
}
.table-responsive {
    overflow-x: auto;
}
.data-table {
    width: 100%;
    border-collapse: collapse;
    color: wheat;
}
.data-table th, .data-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}
.data-table th {
    background-color: rgba(0, 0, 0, 0.3);
    position: sticky;
    top: 0;
}
.data-table tr:hover {
    background-color: rgba(255, 255, 255, 0.05);
}
.error {
    color: #ff6b6b;
    padding: 10px;
    background: rgba(255, 0, 0, 0.1);
    border-radius: 4px;
}
.success {
    color: #51cf66;
    padding: 10px;
    background: rgba(0, 255, 0, 0.1);
    border-radius: 4px;
}
.back-btn {

            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
}
.audiopajarito {
    position: absolute;  /* Lo posiciona de forma absoluta */
    top: 20px;          /* 20px desde arriba */
    right: 20px;        /* 20px desde la derecha */
    width: 200px;       /* Ancho del control */
    z-index: 100;       /* Para que quede sobre otros elementos */
    
}

    </style>
</head>
<body>
<div class="audio-container">
    <audio class="audiopajarito" loop autoplay>
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