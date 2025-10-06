// static/js/chroma_key.js

document.addEventListener('DOMContentLoaded', function () {
    const videoSource = document.getElementById('celebration-video-source');
    const canvas = document.getElementById('celebration-canvas');

    // Si no existen los elementos necesarios, no hacemos nada.
    if (!videoSource || !canvas) {
        return;
    }

    const ctx = canvas.getContext('2d');

    videoSource.addEventListener('loadedmetadata', function () {
        // Ajustar el tamaño del canvas al del video
        canvas.width = videoSource.videoWidth;
        canvas.height = videoSource.videoHeight;
    });

    videoSource.addEventListener('play', function () {
        // Función que se ejecutará en bucle para procesar cada fotograma
        function step() {
            if (videoSource.paused || videoSource.ended) {
                return;
            }

            // 1. Dibuja el fotograma actual del video en el canvas
            ctx.drawImage(videoSource, 0, 0, canvas.width, canvas.height);

            // 2. Obtiene los datos de los píxeles del canvas
            let frame = ctx.getImageData(0, 0, canvas.width, canvas.height);
            let data = frame.data;

            // 3. Itera sobre cada píxel (cada píxel son 4 valores: R, G, B, A)
            for (let i = 0; i < data.length; i += 4) {
                let red = data[i];
                let green = data[i + 1];
                let blue = data[i + 2];

                // --- Lógica del Chroma Key ---
                // Si el píxel es predominantemente verde (y no muy oscuro)
                // Puedes ajustar estos valores para que coincidan con tu tono de verde.
                if (green > 100 && red < 100 && blue < 100) {
                    // 4. Lo hacemos completamente transparente
                    data[i + 3] = 0; // Canal Alpha
                }
            }

            // 5. Vuelve a poner los datos de píxeles modificados en el canvas
            ctx.putImageData(frame, 0, 0);

            // Pide al navegador que ejecute 'step' en el siguiente fotograma
            requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    });

    videoSource.play().catch(e => console.error("Error al reproducir video de celebración:", e));
});