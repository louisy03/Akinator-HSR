document.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.arg-container');
    if (!container) return;

    const content = document.getElementById('glitch-content');
    const contentHTML = content.innerHTML;
    
    // --- GLITCH DE TEXTO ---
    const glitchLayers = document.createElement('div');
    glitchLayers.className = 'glitch-layers';
    container.appendChild(glitchLayers);

    for (let i = 0; i < 3; i++) {
        const slice = document.createElement('div');
        slice.className = 'glitch-slice';
        slice.innerHTML = contentHTML;
        glitchLayers.appendChild(slice);
    }
    
    const slices = document.querySelectorAll('.glitch-slice');
    
    const triggerTextGlitch = () => {
        slices.forEach(slice => {
            const top = Math.random() * 100;
            const height = Math.random() * 20 + 1;

            slice.style.clipPath = `polygon(0% ${top}%, 100% ${top}%, 100% ${top + height}%, 0% ${top + height}%)`;
            slice.style.transform = `translateX(${(Math.random() - 0.5) * 30}px)`;
            slice.style.visibility = 'visible';

            setTimeout(() => {
                slice.style.visibility = 'hidden';
            }, Math.random() * 150 + 50);
        });

        setTimeout(triggerTextGlitch, Math.random() * 600 + 200);
    };

    // --- GLITCH DE BLOQUES DEL CONTENEDOR ---
    const containerGlitchLayers = document.createElement('div');
    containerGlitchLayers.className = 'container-glitch-layers';
    container.appendChild(containerGlitchLayers);

    for (let i = 0; i < 10; i++) { // Crea 10 bloques reutilizables
        const block = document.createElement('div');
        block.className = 'container-glitch-block';
        containerGlitchLayers.appendChild(block);
    }

    const glitchBlocks = document.querySelectorAll('.container-glitch-block');

    const triggerContainerGlitch = () => {
        glitchBlocks.forEach(block => {
            // Activa solo un bloque que no esté ya activo
            if (block.style.display === 'block') return;

            const blockWidth = Math.random() * 80 + 10;
            const blockHeight = Math.random() * 80 + 5;
            const top = Math.random() * (container.clientHeight - blockHeight);
            
            const onLeft = Math.random() > 0.5;

            block.style.width = `${blockWidth}px`;
            block.style.height = `${blockHeight}px`;
            block.style.top = `${top}px`;
            
            // Resetea estilos
            block.style.left = '';
            block.style.right = '';
            block.classList.remove('glitch-block-left', 'glitch-block-right');
            
            const xOffset = blockWidth * 0.75; // Cuánto se sale del borde
            const yOffset = (Math.random() - 0.5) * 50;
            
            if (onLeft) {
                block.classList.add('glitch-block-left');
                block.style.left = '0';
                block.style.transform = `translateX(-${xOffset}px) translateY(${yOffset}px)`;
            } else {
                block.classList.add('glitch-block-right');
                block.style.right = '0';
                block.style.transform = `translateX(${xOffset}px) translateY(${yOffset}px)`;
            }
            
            block.style.display = 'block';

            setTimeout(() => {
                block.style.display = 'none';
            }, Math.random() * 100 + 20); // Duración visible del bloque
        });
        
        // Vuelve a llamar a la función para el siguiente frame de glitch
        setTimeout(triggerContainerGlitch, Math.random() * 200 + 100);
    };

    // Inicia ambos ciclos de glitches
    triggerTextGlitch();
    triggerContainerGlitch();
});