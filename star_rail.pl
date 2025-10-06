% honkai-akinator/star_rail.pl

% --- HECHOS: personaje(Nombre, Atributo, Valor). ---
% Todos los valores DEBEN ser átomos (minúsculas, sin espacios o usando guiones bajos).

% Himeko
personaje(himeko, origen_historia, expreso_astral).
personaje(himeko, genero, femenino).
personaje(himeko, rareza, cinco_estrellas).
personaje(himeko, via, erudicion).
personaje(himeko, elemento, fuego).
personaje(himeko, rol_secundario, no_aplica). % DPS puro
personaje(himeko, escalado_dano, atk).
personaje(himeko, tiene_forma_alterna, no).
personaje(himeko, tipo_arma, libro). % Asumiendo un objeto tipo libro/cáliz
personaje(himeko, color_pelo_dominante, rojo).


% Welt
personaje(welt, origen_historia, expreso_astral).
personaje(welt, genero, masculino).
personaje(welt, rareza, cinco_estrellas).
personaje(welt, via, nihilidad).
personaje(welt, elemento, imaginario).
personaje(welt, rol_secundario, debuffer).
personaje(welt, escalado_dano, atk).
personaje(welt, tiene_forma_alterna, no).
personaje(welt, tipo_arma, otro). % Bastón
personaje(welt, color_pelo_dominante, otro). % Negro/Gris

% Dan Heng
personaje(dan_heng, origen_historia, expreso_astral).
personaje(dan_heng, genero, masculino).
personaje(dan_heng, rareza, cuatro_estrellas).
personaje(dan_heng, via, caza).
personaje(dan_heng, elemento, viento).
personaje(dan_heng, rol_secundario, no_aplica).
personaje(dan_heng, escalado_dano, atk).
personaje(dan_heng, tiene_forma_alterna, si). % Imbibitor Lunae
personaje(dan_heng, tipo_arma, lanza).
personaje(dan_heng, color_pelo_dominante, otro). % Negro

% March 7th
personaje(march_7th, origen_historia, expreso_astral).
personaje(march_7th, genero, femenino).
personaje(march_7th, rareza, cuatro_estrellas).
personaje(march_7th, via, conservacion).
personaje(march_7th, elemento, hielo).
personaje(march_7th, rol_secundario, shielder).
personaje(march_7th, escalado_dano, def).
personaje(march_7th, tiene_forma_alterna, no).
personaje(march_7th, tipo_arma, otro). % Arco
personaje(march_7th, color_pelo_dominante, otro). % Rosa

% Kafka
personaje(kafka, origen_historia, otros). % Cazadores de Estelarones
personaje(kafka, genero, femenino).
personaje(kafka, rareza, cinco_estrellas).
personaje(kafka, via, nihilidad).
personaje(kafka, elemento, rayo).
personaje(kafka, rol_secundario, debuffer).
personaje(kafka, escalado_dano, atk).
personaje(kafka, tiene_forma_alterna, no).
personaje(kafka, tipo_arma, otro). % Subfusiles
personaje(kafka, color_pelo_dominante, otro). % Morado/Fucsia

% Blade
personaje(blade, origen_historia, otros). % Cazadores de Estelarones
personaje(blade, genero, masculino).
personaje(blade, rareza, cinco_estrellas).
personaje(blade, via, destruccion).
personaje(blade, elemento, viento).
personaje(blade, rol_secundario, no_aplica).
personaje(blade, escalado_dano, hp).
personaje(blade, tiene_forma_alterna, no).
personaje(blade, tipo_arma, espada_ligera).
personaje(blade, color_pelo_dominante, otro). % Negro

% Seele
personaje(seele, origen_historia, belobog).
personaje(seele, genero, femenino).
personaje(seele, rareza, cinco_estrellas).
personaje(seele, via, caza).
personaje(seele, elemento, quantico).
personaje(seele, rol_secundario, no_aplica).
personaje(seele, escalado_dano, atk).
personaje(seele, tiene_forma_alterna, no).
personaje(seele, tipo_arma, otro). % Guadaña
personaje(seele, color_pelo_dominante, azul).

% Bronya
personaje(bronya, origen_historia, belobog).
personaje(bronya, genero, femenino).
personaje(bronya, rareza, cinco_estrellas).
personaje(bronya, via, armonia).
personaje(bronya, elemento, viento).
personaje(bronya, rol_secundario, buffer).
personaje(bronya, escalado_dano, atk). % Su buff escala con su Daño CRIT, pero su daño base es ATK
personaje(bronya, tiene_forma_alterna, no).
personaje(bronya, tipo_arma, otro). % Rifle
personaje(bronya, color_pelo_dominante, blanco).

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