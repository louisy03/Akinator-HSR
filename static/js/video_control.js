// static/js/video_control.js

document.addEventListener("DOMContentLoaded", function() {
    const video = document.getElementById("video-background");
    const loaderOverlay = document.getElementById("loader-overlay");

    // Si no hay video, no hacemos nada.
    if (!video) return;

    // --- Parte 1: Lógica para Ocultar el Overlay (Siempre se ejecuta) ---
    
    // Esta lógica es independiente del bucle y se asegura de que el overlay
    // desaparezca tan pronto como el video pueda empezar a reproducirse.
    if (loaderOverlay) {
        const hideLoader = () => {
            loaderOverlay.classList.add('hidden');
        };

        // 'canplay' es el evento perfecto: se dispara cuando hay suficientes datos para reproducir.
        video.addEventListener('canplay', hideLoader);

        // Fallback: Si el video ya está listo (cargado de caché), oculta el overlay inmediatamente.
        // El estado 4 significa que tiene datos suficientes para terminar la reproducción sin problemas.
        if (video.readyState >= 4) {
            hideLoader();
        }
    }

    // --- Parte 2: Lógica para el Bucle de Video Personalizado (Solo si es necesario) ---

    const startTime = parseFloat(video.dataset.startTime);
    const endTime = parseFloat(video.dataset.endTime);

    // Si los atributos para el bucle no existen o no son válidos, el script termina aquí,
    // pero la lógica del overlay de arriba ya está funcionando.
    if (isNaN(startTime) || isNaN(endTime)) {
        return;
    }

    // Si llegamos aquí, es porque SÍ necesitamos configurar un bucle personalizado.
    let hasBeenSetup = false;

    const setupVideoLoop = () => {
        if (hasBeenSetup) return;
        hasBeenSetup = true;

        video.currentTime = startTime;
        video.play().catch(error => {
            console.error("La reproducción automática del video fue bloqueada:", error);
        });
    };

    video.addEventListener("timeupdate", function() {
        if (this.currentTime >= endTime) {
            this.currentTime = startTime;
        }
    });

    video.addEventListener('loadedmetadata', setupVideoLoop);

    if (video.readyState > 0) {
        setupVideoLoop();
    }
});