% honkai-akinator/star_rail.pl

% --- HECHOS: personaje(Nombre, Atributo, Valor). ---
% Todos los valores DEBEN ser átomos (minúsculas, sin espacios o usando guiones bajos).

% Himeko
personaje(himeko, origen_historia, expreso_astral).
personaje(himeko, genero, femenino).
personaje(himeko, rareza, cinco_estrellas).
personaje(himeko, via, erudicion).
personaje(himeko, elemento, fuego).
personaje(himeko, rol, sub_dps). % DPS puro
personaje(himeko, tipo_modelo, alto).
personaje(himeko, escalado, atk).
personaje(himeko, tiene_forma_alterna, no).
personaje(himeko, color_pelo_dominante, rojo).

% Welt
personaje(welt, origen_historia, expreso_astral).
personaje(welt, genero, masculino).
personaje(welt, rareza, cinco_estrellas).
personaje(welt, via, nihilidad).
personaje(welt, elemento, imaginario).
personaje(welt, rol, debuffer).
personaje(welt, tipo_modelo, alto).
personaje(welt, escalado, atk).
personaje(welt, tiene_forma_alterna, no).
personaje(welt, color_pelo_dominante, otro). % Negro/Gris

% Dan Heng
personaje(dan_heng, origen_historia, expreso_astral).
personaje(dan_heng, genero, masculino).
personaje(dan_heng, rareza, cuatro_estrellas).
personaje(dan_heng, via, caza).
personaje(dan_heng, elemento, viento).
personaje(dan_heng, rol, dps).
personaje(dan_heng, tipo_modelo, alto).
personaje(dan_heng, escalado, atk).
personaje(dan_heng, tiene_forma_alterna, si). % Imbibitor Lunae
personaje(dan_heng, color_pelo_dominante, otro). % Negro

% March 7th
personaje(march_7th, origen_historia, expreso_astral).
personaje(march_7th, genero, femenino).
personaje(march_7th, rareza, cuatro_estrellas).
personaje(march_7th, via, conservacion).
personaje(march_7th, elemento, hielo).
personaje(march_7th, rol, shielder).
personaje(march_7th, tipo_modelo, mediano).
personaje(march_7th, escalado, def).
personaje(march_7th, tiene_forma_alterna, no).
personaje(march_7th, color_pelo_dominante, otro). % Rosa

% Seele
personaje(seele, origen_historia, belobog).
personaje(seele, genero, femenino).
personaje(seele, rareza, cinco_estrellas).
personaje(seele, via, caza).
personaje(seele, elemento, quantico).
personaje(seele, rol, dps).
personaje(seele, tipo_modelo, mediano).
personaje(seele, escalado, atk).
personaje(seele, tiene_forma_alterna, no).
personaje(seele, color_pelo_dominante, azul).

% Bronya
personaje(bronya, origen_historia, belobog).
personaje(bronya, genero, femenino).
personaje(bronya, rareza, cinco_estrellas).
personaje(bronya, via, armonia).
personaje(bronya, elemento, viento).
personaje(bronya, rol, buffer).
personaje(bronya, tipo_modelo, mediano).
personaje(bronya, escalado, atk). % Su buff escala con su Daño CRIT, pero su daño base es ATK
personaje(bronya, tiene_forma_alterna, no).
personaje(bronya, color_pelo_dominante, blanco).

% Cazador estelaron

% Firefly
personaje(firefly, origen_historia, colonipenal)
personaje(firefly, genero, femenino)
personaje(firefly, rareza, cinco_estrellas)
personaje(firefly, via, destruccion)
personaje(firefly, elemento, fuego)
personaje(firefly, tipo_modelo, mediano)
personaje(firefly, rol, dps)
personaje(firefly, escalado, ruptura)
personaje(firefly, tiene_forma_alterna, no)
personaje(firefly, color_pelo_dominante, )

% Kafka
personaje(kafka, origen_historia, cazador_estelaron)
personaje(kafka, genero, femenino)
personaje(kafka, rareza, cinco_estrellas)
personaje(kafka, via, nihilidad)
personaje(kafka, elemento, electrico)
personaje(kafka, rol, support) %se cambia rol_secundario por rol
personaje(kafka, tipo_modelo, alto)
personaje(kafka, escalado, ataque)
personaje(kafka, tiene_forma_alterna, no)
personaje(kafka, color_pelo_dominante, violeta)

% Silver wolf
personaje(silver_wolf, origen_historia, cazador_estelaron)
personaje(silver_wolf, genero, femenino)
personaje(silver_wolf, rareza, cinco_estrellas)
personaje(silver_wolf, via, nihilidad)
personaje(silver_wolf, elemento, cuantico)
personaje(silver_wolf, rol, debuffer) %se cambia rol_secundario por rol
personaje(silver_wolf, tipo_modelo, chico) %chico, mediano, alto
personaje(silver_wolf, escalado, ataque)
personaje(silver_wolf, tiene_forma_alterna, no)
personaje(silver_wolf, color_pelo_dominante, gris)

% Blade
personaje(blade, origen_historia, cazador_estelaron)
personaje(blade, genero, masculino)
personaje(blade, rareza, cinco_estrellas)
personaje(blade, via, destruccion)
personaje(blade, elemento, viento)
personaje(blade, rol, dps) %se cambia rol_secundario por rol
personaje(blade, tipo_modelo, alto) %chico, mediano, alto
personaje(blade, escalado, vida)
personaje(blade, tiene_forma_alterna, no)
personaje(blade, color_pelo_dominante, negro)

% Colonipenal

% Robin
personaje(robin, origen_historia, colonipenal)
personaje(robin, genero, femenino)
personaje(robin, rareza, cinco_estrellas)
personaje(robin, via, armonia)
personaje(robin, elemento, fisico)
personaje(robin, rol, buffer) %se cambia rol_secundario por rol
personaje(robin, tipo_modelo, mediano) %chico, mediano, alto
personaje(robin, escalado, ataque)
personaje(robin, tiene_forma_alterna, no)
personaje(robin, color_pelo_dominante, azul)

% Sparkle
personaje(sparkle, origen_historia, colonipenal)
personaje(sparkle, genero, femenino)
personaje(sparkle, rareza, cinco_estrellas)
personaje(sparkle, via, armonia)
personaje(sparkle, elemento, cuantico)
personaje(sparkle, rol, buffer) %se cambia rol_secundario por rol
personaje(sparkle, tipo_modelo, chico) %chico, mediano, alto
personaje(sparkle, escalado, ataque)
personaje(sparkle, tiene_forma_alterna, no)
personaje(sparkle, color_pelo_dominante, negro)

% Black Swan
personaje(black_swan, origen_historia, colonipenal)
personaje(black_swan, genero, femenino)
personaje(black_swan, rareza, cinco_estrellas)
personaje(black_swan, via, nihilidad)
personaje(black_swan, elemento, viento)
personaje(black_swan, rol, dps) %se cambia rol_secundario por rol
personaje(black_swan, tipo_modelo, alto) %chico, mediano, alto
personaje(black_swan, escalado, ataque) %se cambia escalado_dano por escalado
personaje(black_swan, tiene_forma_alterna, no)
personaje(black_swan, color_pelo_dominante, morado)

% Domingo
personaje(sunday, origen_historia, colonipenal)
personaje(sunday, genero, masculino)
personaje(sunday, rareza, cinco_estrellas)
personaje(sunday, via, armonia)
personaje(sunday, elemento, imaginario)
personaje(sunday, rol, buffer) %se cambia rol_secundario por rol
personaje(sunday, tipo_modelo, alto) %chico, mediano, alto
personaje(sunday, escalado, ataque) %se cambia escalado_dano por escalado
personaje(sunday, tiene_forma_alterna, no)
personaje(sunday, color_pelo_dominante, azul)

% Acheron
personaje(acheron, origen_historia, colonipenal)
personaje(acheron, genero, femenino)
personaje(acheron, rareza, cinco_estrellas)
personaje(acheron, via, nihilidad)
personaje(acheron, elemento, electrico)
personaje(acheron, rol, dps) %se cambia rol_secundario por rol
personaje(acheron, tipo_modelo, alto) %chico, mediano, alto
personaje(acheron, escalado, ataque) %se cambia escalado_dano por escalado
personaje(acheron, tiene_forma_alterna, no)
personaje(acheron, color_pelo_dominante, purpura)

% Gallagher
personaje(gallagher, origen_historia, colonipenal)
personaje(gallagher, genero, masculino)
personaje(gallagher, rareza, cuatro_estrellas)
personaje(gallagher, via, abundancia)
personaje(gallagher, elemento, fuego)
personaje(gallagher, rol, soporte) %se cambia rol_secundario por rol
personaje(gallagher, tipo_modelo, alto) %chico, mediano, alto
personaje(gallagher, escalado, ruptura) %se cambia escalado_dano por escalado
personaje(gallagher, tiene_forma_alterna, no)
personaje(gallagher, color_pelo_dominante, marron)

% IPC

% Aventurino
personaje(aventurino, origen_historia, ipc)
personaje(aventurino, genero, masculino)
personaje(aventurino, rareza, cinco_estrellas)
personaje(aventurino, via, conservacion)
personaje(aventurino, elemento, imaginario)
personaje(aventurino, rol, shielder) %se cambia rol_secundario por rol
personaje(aventurino, tipo_modelo, alto) %chico, mediano, alto
personaje(aventurino, escalado, defensa) %se cambia escalado_dano por escalado
personaje(aventurino, tiene_forma_alterna, no)
personaje(aventurino, color_pelo_dominante, rubio)

% Topaz
personaje(topaz, origen_historia, ipc)
personaje(topaz, genero, femenino)
personaje(topaz, rareza, cinco_estrellas)
personaje(topaz, via, caceria)
personaje(topaz, elemento, fuego)
personaje(topaz, rol, sub_dps) %se cambia rol_secundario por rol
personaje(topaz, tipo_modelo, alto) %chico, mediano, alto
personaje(topaz, escalado, ataque) %se cambia escalado_dano por escalado
personaje(topaz, tiene_forma_alterna, no)
personaje(topaz, color_pelo_dominante, blanco)

% Jade
personaje(jade, origen_historia, ipc)
personaje(jade, genero, femenino)
personaje(jade, rareza, cinco_estrellas)
personaje(jade, via, erudicion)
personaje(jade, elemento, electrico)
personaje(jade, rol, sub_dps) %se cambia rol_secundario por rol
personaje(jade, tipo_modelo, alto) %chico, mediano, alto
personaje(jade, escalado, ataque) %se cambia escalado_dano por escalado
personaje(jade, tiene_forma_alterna, no)
personaje(jade, color_pelo_dominante, violeta)

% Vigilantes de la gaxia

% Rappa
personaje(rappa, origen_historia, )
personaje(rappa, genero, femenino)
personaje(rappa, rareza, cinco_estrellas)
personaje(rappa, via, erudicion)
personaje(rappa, elemento, imaginario)
personaje(rappa, rol, dps) %se cambia rol_secundario por rol
personaje(rappa, tipo_modelo, alto) %chico, mediano, alto
personaje(rappa, escalado, ruptura) %se cambia escalado_dano por escalado
personaje(rappa, tiene_forma_alterna, no)
personaje(rappa, color_pelo_dominante, rosa)

% Bothill
personaje(bothill, origen_historia, )
personaje(bothill, genero, masculino)
personaje(bothill, rareza, cinco_estrellas)
personaje(bothill, via, caceria)
personaje(bothill, elemento, fisico)
personaje(bothill, rol, dps) %se cambia rol_secundario por rol
personaje(bothill, tipo_modelo, alto) %chico, mediano, alto
personaje(bothill, escalado, ruptura) %se cambia escalado_dano por escalado
personaje(bothill, tiene_forma_alterna, no)
personaje(bothill, color_pelo_dominante, negro)

% Amphoreus

% Hysilens
personaje(hysilens, origen_historia, amphoreus)
personaje(hysilens, genero, femenino)
personaje(hysilens, rareza, cinco_estrellas)
personaje(hysilens, via, nihilidad)
personaje(hysilens, elemento, fisico)
personaje(hysilens, rol, dps) %se cambia rol_secundario por rol
personaje(hysilens, tipo_modelo, alto)
personaje(hysilens, escalado, ataque)
personaje(hysilens, tiene_forma_alterna, no)
personaje(hysilens, color_pelo_dominante, negro)

% -------------------------------------------------------------------
% --- REGLAS: Logica central del Akinator ---

% Regla principal para encontrar a todos los personajes que cumplen una lista de requisitos.
% Requisitos es una lista de la forma [atributo-valor, ...]
encuentra_personaje(Requisitos, Candidatos) :-
    % 1. Encontrar todos los Nombres de personaje.
    findall(Nombre, 
            (
                personaje(Nombre, _, _), 
                check_requisitos(Nombre, Requisitos) % Comprobar que cumple TODOS los requisitos
            ), 
            ListaFinal),
            
    % 2. Eliminar duplicados y obtener la lista final de candidatos.
    sort(ListaFinal, Candidatos).

% Regla auxiliar para chequear que un personaje cumpla con TODOS los requisitos.
% Caso base: Si no quedan requisitos, el personaje cumple.
check_requisitos(_, []). 

% Caso recursivo: Verifica el requisito actual y pasa al siguiente.
check_requisitos(Nombre, [Attr-Val | RestoRequisitos]) :-
    personaje(Nombre, Attr, Val), % ¿Es verdad que personaje(Nombre, Attr, Val)?
    check_requisitos(Nombre, RestoRequisitos). % Continúa con el resto de la lista