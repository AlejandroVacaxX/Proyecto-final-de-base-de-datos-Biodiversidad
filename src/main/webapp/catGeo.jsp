<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <title>Biodiversidad CDMX</title>
</head>

<body>
    <main class="main-container">
        <header class="input-container">
            <form id="queryForm" action="MiServlet" method="POST">
                <select name="tipoConsulta">
                    <option value="consulta1">Áreas naturales por alcaldía</option>
                    <option value="consulta2">Especies invasoras por alcaldia</option>
                    <option value="consulta3">Ecosistema por alcaldia</option>
                </select>

                <select name="parametroadicional">
                    <option value="Alvaro Obregon">Alvaro Obregon</option>
                    <option value="Azcapotzalco">Azcapotzalco</option>
                    <option value="Benito Juarez">Benito Juarez</option>
                    <option value="Coyoacan">Coyoacan</option>
                    <option value="Cuajimalpa de Morelos">Cuajimalpa de Morelos</option>
                    <option value="Cuahutemoc">Cuahutemoc</option>
                    <option value="Gustavo A. Madero">Gustavo A. Madero</option>
                    <option value="Iztacalco">Iztacalco</option>
                    <option value="Iztapalapa">Iztapalapa</option>
                    <option value="La Magdalena Contreras">La Magdalena Contreras</option>
                    <option value="Miguel Hidalgo">Miguel Hidalgo</option>
                    <option value="Milpa Alta">Milpa Alta</option>
                    <option value="Tlahuac">Tlahuac</option>
                    <option value="Venustiano Carranza">Venustiano Carranza</option>
                    <option value="Xochimilco">Xochimilco</option>
                    <option value="Tlalpan">Tlalpan</option>
                </select>
                <input type="hidden" name="formulario" value="catGeo"> <!--Gracias a esta madre puedo saber de que archivo viene la peticion-->
                <button type="submit" class="search-btn">
                    <span class="material-symbols-outlined">search</span>
                </button>
            </form>
        </header>

        <!-- esta madre se lleva los resultados jejeje-->
        <div id="resultsContainer"></div>
    </main>

    <script>
        document.getElementById('queryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const consulta = document.querySelector('select[name="tipoConsulta"]').value;
            const parametro = document.querySelector('select[name="parametroadicional"]').value;
            
            fetch('MiServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `formulario=catGeo&tipoConsulta=${encodeURIComponent(consulta)}&parametroadicional=${encodeURIComponent(parametro)}`
            })
            .then(response => response.text())
            .then(data => {
                document.getElementById('resultsContainer').innerHTML = data;
            })
            .catch(error => {
                document.getElementById('resultsContainer').innerHTML = 
                    `<div class="error">Error al procesar la consulta: ${error.message}</div>`;
            });
        });
    </script>
</body>
</html>