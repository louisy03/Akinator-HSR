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