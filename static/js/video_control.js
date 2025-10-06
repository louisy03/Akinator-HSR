// static/js/video_control.js

document.addEventListener("DOMContentLoaded", function() {
    const video = document.getElementById("video-background");
    if (!video) return;

    // --- CONFIGURACIÓN ---
    // Define aquí los tiempos de inicio y fin del bucle (en segundos)
    const startTime = 23; // Ejemplo: Empezar en el minuto 1:00
    const endTime = 93;  // Ejemplo: Terminar en el minuto 2:00

    // Función para iniciar y controlar la reproducción del video
    function playVideoSegment() {
        video.currentTime = startTime;
        const playPromise = video.play();

        if (playPromise !== undefined) {
            playPromise.then(_ => {
                // La reproducción automática comenzó correctamente.
            }).catch(error => {
                // La reproducción automática fue prevenida.
                console.error("La reproducción automática del video fue bloqueada:", error);
            });
        }
    }

    // Evento que se dispara continuamente mientras el video se reproduce
    video.addEventListener("timeupdate", function() {
        // Si el tiempo actual supera el punto final, lo reiniciamos al punto de inicio
        if (this.currentTime >= endTime) {
            this.currentTime = startTime;
        }
    });

    // El evento 'loadedmetadata' es más fiable para saber cuándo podemos manipular el video.
    video.addEventListener('loadedmetadata', playVideoSegment);

    // Como respaldo, si el video ya está listo, lo iniciamos.
    if (video.readyState >= 3) { // HAVE_FUTURE_DATA
        playVideoSegment();
    }
});
