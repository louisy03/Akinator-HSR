// static/js/game_logic.js

document.addEventListener('DOMContentLoaded', function () {
    // --- LÓGICA DEL FORMULARIO DEL JUEGO (SOLO PARA juego_prolog.html) ---
    const form = document.getElementById('game-form');
    if (form) {
        form.addEventListener('submit', function (event) {
            // 1. Prevenir la recarga de la página
            event.preventDefault();

            // Obtener el botón que fue presionado para enviar el formulario
            const button = event.submitter;
            const formData = new FormData();
            formData.append(button.name, button.value);

            // 2. Enviar la respuesta al servidor de forma asíncrona
            fetch(form.action, {
                method: 'POST',
                body: new URLSearchParams(formData) // Formato estándar para formularios
            })
            .then(response => response.json()) // Esperamos una respuesta en formato JSON
            .then(data => {
                // 3. Actualizar la página con los nuevos datos o redirigir
                if (data.status === 'continue') {
                    // Actualizar el contenido dinámicamente
                    document.getElementById('candidates-count').textContent = data.candidatos_restantes;
                    document.getElementById('question-text').textContent = data.pregunta;

                    const buttonContainer = document.getElementById('button-container');
                    buttonContainer.innerHTML = ''; // Limpiar botones antiguos

                    data.respuestas.forEach(respuesta => {
                        const newButton = document.createElement('button');
                        newButton.type = 'submit';
                        newButton.name = 'respuesta';
                        newButton.value = respuesta;
                        // Formatear texto para el botón (ej: 'cinco_estrellas' -> 'Cinco Estrellas')
                        newButton.textContent = respuesta.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
                        buttonContainer.appendChild(newButton);
                    });
                } else {
                    // Si el juego termina (éxito o fracaso), redirigir a la página de resultados
                    window.location.href = data.redirect_url;
                }
            })
            .catch(error => console.error('Error en la comunicación con el servidor:', error));
        });
    }

    const restartButton = document.getElementById('restart-button');
    if (restartButton) {
        restartButton.addEventListener('click', function () {
            // Opcional: Muestra un loader si lo deseas
            const loader = document.getElementById('loader-overlay');
            if(loader) loader.classList.remove('hidden');

            fetch('/reiniciar', {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    // Redirigir a la página de inicio que nos indica el servidor
                    window.location.href = data.redirect_url;
                }
            })
            .catch(error => {
                console.error('Error al reiniciar el juego:', error);
                // Opcional: Oculta el loader si hubo un error
                if(loader) loader.classList.add('hidden');
            });
        });
    }

});
