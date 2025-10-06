# honkai-akinator/app.py

from flask import Flask, render_template, request, session, redirect, url_for
from pyswip import Prolog

app = Flask(__name__)
# ¡IMPORTANTE! Cambia esto en producción. Es necesario para usar 'session'.
app.secret_key = 'una_clave_secreta_super_segura_para_homenaje_a_honkai' 

# Inicializa el motor de Prolog
prolog = Prolog()
# Carga el archivo de conocimiento. ¡Debe estar en la misma carpeta!
prolog.consult("star_rail.pl") 

# Definición de las preguntas en el orden en que se harán.
# Ahora cada pregunta tiene un texto y una lista de respuestas posibles.
PREGUNTAS = {
    # PRIORIDAD ALTA
    "origen_historia": {
        "texto": "¿De qué facción principal es tu personaje?",
        "respuestas": ["expreso_astral", "xianzhou", "belobog", "otros"]
    },
    "genero": {
        "texto": "¿Tu personaje es de género femenino o masculino?",
        "respuestas": ["femenino", "masculino"]
    },
    "rareza": {
        "texto": "¿Tu personaje es de 5 estrellas o 4 estrellas?",
        "respuestas": ["cinco_estrellas", "cuatro_estrellas"]
    },
    "via": {
        "texto": "¿Cuál es la Vía de tu personaje?",
        "respuestas": ["caza", "erudicion", "destruccion", "conservacion", "armonia", "nihilidad", "abundancia"]
    },
    "elemento": {
        "texto": "¿Cuál es el elemento de tu personaje?",
        "respuestas": ["fuego", "hielo", "viento", "rayo", "fisico", "quantico", "imaginario"]
    },
    # PRIORIDAD MEDIA
    "rol_secundario": {
        "texto": "¿Tiene tu personaje un rol de soporte secundario notable?",
        "respuestas": ["shielder", "healer", "buffer", "debuffer", "no_aplica"]
    },
    "escalado_dano": {
        "texto": "¿El daño del personaje escala principalmente con HP o DEF en lugar de ATK?",
        "respuestas": ["hp", "def", "atk"]
    },
    # PRIORIDAD BAJA (Desempate)
    "tiene_forma_alterna": {
        "texto": "¿Tu personaje tiene una versión alternativa (ej. Dan Heng IL)?",
        "respuestas": ["si", "no"]
    },
    "tipo_arma": {
        "texto": "¿Qué tipo de arma visualmente distintiva usa tu personaje?",
        "respuestas": ["lanza", "guantes", "espada_ligera", "libro", "otro"]
    },
    "color_pelo_dominante": {
        "texto": "¿Cuál es el color de pelo dominante de tu personaje?",
        "respuestas": ["blanco", "rojo", "azul", "verde", "otro"]
    },
}

def inicializar_juego():
    """Reinicia la sesión del juego."""
    # Lista de pares Atributo-Valor que se cumplen (ej: ['genero-femenino', 'via-caza'])
    session['requisitos'] = [] 
    session['preguntas_hechas'] = []
    # Usamos una lista de las claves de PREGUNTAS para mantener el orden.
    session['orden_preguntas'] = list(PREGUNTAS.keys()) 

def obtener_siguiente_pregunta():
    """Devuelve la clave del siguiente atributo a preguntar."""
    for key in session['orden_preguntas']:
        if key not in session['preguntas_hechas']:
            return key
    return None

@app.route('/')
def inicio():
    inicializar_juego()
    return redirect(url_for('jugar'))

@app.route('/jugar', methods=['GET', 'POST'])
def jugar():
    # --- PROCESAR RESPUESTA ANTERIOR ---
    if request.method == 'POST':
        # La respuesta ahora viene del valor de un botón, ya no es necesario procesar el texto.
        respuesta_usuario = request.form.get('respuesta')
        
        atributo_clave = session.get('pregunta_actual')
        
        if atributo_clave:
            # Agregamos el nuevo requisito (Attr-Valor)
            session['requisitos'].append(f"{atributo_clave}-{respuesta_usuario}")
            session['preguntas_hechas'].append(atributo_clave)
        
    # --- CONSULTAR PROLOG ---
    # Convertimos la lista de requisitos a la sintaxis de lista de Prolog: [req1-val1, req2-val2]
    requisitos_prolog = "[" + ",".join(session.get('requisitos')) + "]"
    
    # Consulta: encuentra_personaje([req1-val1, ...], Candidatos)
    consulta = f"encuentra_personaje({requisitos_prolog}, Candidatos)"
    
    # Ejecutamos la consulta
    resultados = list(prolog.query(consulta))

    candidatos_restantes = []
    if resultados and 'Candidatos' in resultados[0]:
        # El resultado es una lista de átomos de Prolog; la convertimos a lista de Python
        candidatos_restantes = [str(c) for c in resultados[0]['Candidatos']]
    
    # --- CHEQUEAR ESTADO DEL JUEGO ---
    
    # Caso 1: ¡Adivinanza! Queda solo 1 candidato.
    if len(candidatos_restantes) == 1:
        # Formateamos el nombre (ej: 'dan_heng' -> 'Dan Heng')
        personaje_adivinado = candidatos_restantes[0].replace("_", " ").title()
        return render_template('resultado.html', adivinado=True, personaje=personaje_adivinado)
        
    # Caso 2: Se acabaron las preguntas o no quedan candidatos.
    siguiente_clave = obtener_siguiente_pregunta()
    if not siguiente_clave:
        # Formateamos los nombres para el resultado
        candidatos_formateados = [c.replace("_", " ").title() for c in candidatos_restantes]
        return render_template('resultado.html', adivinado=False, candidatos=candidatos_formateados)
    
    # Caso 3: Continúa el juego.
    session['pregunta_actual'] = siguiente_clave
    pregunta_actual = PREGUNTAS[siguiente_clave]
    
    return render_template('juego_prolog.html', 
                           pregunta=pregunta_actual['texto'], 
                           respuestas=pregunta_actual['respuestas'],
                           clave_atributo=siguiente_clave,
                           candidatos_restantes=len(candidatos_restantes))

if __name__ == '__main__':
    # Usar un host específico para evitar problemas en algunos entornos de desarrollo
    app.run(debug=True)