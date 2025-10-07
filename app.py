# honkai-akinator/app.py

from flask import Flask, render_template, request, session, redirect, url_for, jsonify
from pyswip import Prolog

app = Flask(__name__)
# ¡IMPORTANTE! Cambia esto en producción. Es necesario para usar 'session'.
app.secret_key = 'una_clave_secreta_super_segura_para_homenaje_a_honkai' 

# Inicializa el motor de Prolog
prolog = Prolog()
# Carga el archivo de conocimiento. ¡Debe estar en la misma carpeta!
prolog.consult("star_rail.pl") 

# Definición de las preguntas en el orden en que se harán.
# Las respuestas se obtendrán dinámicamente de Prolog.
PREGUNTAS = {
    # PRIORIDAD ALTA
    "origen_historia": "¿De qué facción principal es tu personaje?",
    "genero": "¿Tu personaje es de género femenino o masculino?",
    "rareza": "¿Tu personaje es de 5 estrellas o 4 estrellas?",
    "via": "¿Cuál es la Vía de tu personaje?",
    "elemento": "¿Cuál es el elemento de tu personaje?",
    # PRIORIDAD MEDIA
    "rol_secundario": "¿Tiene tu personaje un rol de soporte secundario notable?",
    "escalado_dano": "¿El daño del personaje escala principalmente con HP o DEF en lugar de ATK?",
    # PRIORIDAD BAJA (Desempate)
    "tiene_forma_alterna": "¿Tu personaje tiene una versión alternativa (ej. Dan Heng IL)?",
    "tipo_arma": "¿Qué tipo de arma visualmente distintiva usa tu personaje?",
    "color_pelo_dominante": "¿Cuál es el color de pelo dominante de tu personaje?",
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
    # Si es un GET, es la primera carga de la página, así que inicializamos.
    if request.method == 'GET' and 'requisitos' not in session:
        inicializar_juego()


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
    
    siguiente_clave = obtener_siguiente_pregunta()
    
    # CASO 1: FRACASO INMEDIATO (No quedan candidatos)
    # Esta es la nueva condición que resuelve la lentitud.
    if not candidatos_restantes and session['preguntas_hechas']:
        session['resultado'] = {'adivinado': False, 'candidatos': []}
        if request.method == 'POST':
            return jsonify({'status': 'failure', 'redirect_url': url_for('resultado')})
        return redirect(url_for('resultado'))

    # CASO 2: ÉXITO (Queda 1 candidato) o FRACASO FINAL (Se acabaron las preguntas)
    if len(candidatos_restantes) == 1 or not siguiente_clave:
        personaje_crudo = candidatos_restantes[0] if len(candidatos_restantes) == 1 else None
        
        if personaje_crudo: # Adivinanza
            session['resultado'] = {'adivinado': True, 'personaje': personaje_crudo.replace("_", " ").title()}
            if request.method == 'POST':
                return jsonify({'status': 'success', 'redirect_url': url_for('resultado')})
            return redirect(url_for('resultado'))
        else: # Fracaso por falta de preguntas
            candidatos_formateados = [c.replace("_", " ").title() for c in candidatos_restantes]
            session['resultado'] = {'adivinado': False, 'candidatos': candidatos_formateados}
            if request.method == 'POST':
                return jsonify({'status': 'failure', 'redirect_url': url_for('resultado')})
            return redirect(url_for('resultado'))
    
    # --- PREPARAR SIGUIENTE PREGUNTA ---
    session['pregunta_actual'] = siguiente_clave
    pregunta_texto = PREGUNTAS[siguiente_clave]

    # Caso 3: Continúa el juego.
    # --- OBTENER RESPUESTAS POSIBLES DESDE PROLOG ---
    # Consulta: findall(Valor, personaje(_, atributo, Valor), Valores), sort(Valores, RespuestasUnicas).
    # `sort/2` en Prolog ordena y elimina duplicados.
    query_respuestas = f"findall(V, personaje(_, {siguiente_clave}, V), Vs), sort(Vs, Respuestas)"
    resultados_respuestas = list(prolog.query(query_respuestas))
    
    respuestas_posibles = []
    if resultados_respuestas:
        respuestas_posibles = [str(r) for r in resultados_respuestas[0]['Respuestas']]
    
    # Si es un POST, devolvemos JSON para la actualización asíncrona.
    if request.method == 'POST':
        return jsonify({
            'status': 'continue',
            'pregunta': pregunta_texto,
            'respuestas': respuestas_posibles,
            'candidatos_restantes': len(candidatos_restantes)
        })

    # Si es un GET, renderizamos la página completa por primera vez.
    return render_template('juego_prolog.html',
                           pregunta=pregunta_texto,
                           respuestas=respuestas_posibles,
                           candidatos_restantes=len(candidatos_restantes))

@app.route('/resultado')
def resultado():
    """Muestra la página de resultados usando los datos de la sesión."""
    datos_resultado = session.pop('resultado', None)
    if not datos_resultado:
        return redirect(url_for('inicio')) # Si no hay resultado, volver al inicio
    return render_template('resultado.html', **datos_resultado)

@app.route('/reiniciar', methods=['POST'])
def reiniciar():
    """
    Endpoint dedicado para limpiar la sesión y reiniciar el juego.
    Responde con JSON para que sea manejado por JavaScript.
    """
    inicializar_juego()
    return jsonify({'status': 'success', 'redirect_url': url_for('inicio')})

if __name__ == '__main__':
    # Usar un host específico para evitar problemas en algunos entornos de desarrollo
    app.run(debug=True)