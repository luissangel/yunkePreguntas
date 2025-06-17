//
//  ContenidoPregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//


//Esta vista es para mostrar el contenido de las preguntas, es decir, la pregunta con sus opciones

import SwiftUI

struct ContenidoPregunta: View {
//Se declara una constante pregunta del tipo Pregunta que es mi struct
    let pregunta: Pregunta
    
//seleccion: una variable de estado que guarda cuál opción ha seleccionado el usuario (ej. "a", "b", etc.). Al estar anotada con @State, cualquier cambio en su valor provoca una actualización automática de la vista.
    @State private var seleccion: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(pregunta.pregunta)
                .font(.title2)
            
            
//  sorted(by:) es una función que ordena una colección usando una función de comparación.sorted(by:) es una función que ordena una colección usando una función de comparación.
//  $0 y $1 representan dos elementos del diccionario. En este caso, cada uno es una tupla del tipo (key: String, value: String), por ejemplo ("a", "París").
//SwiftUI necesita saber cómo identificar cada elemento del ForEach. Para eso usamos id:..key le dice: usa la clave del diccionario como identificador único para cada fila (cada botón).
//  Esto es importante para que SwiftUI pueda actualizar correctamente la interfaz cuando cambie el estado (@State).
            ForEach(pregunta.opciones.sorted(by: { $0.key < $1.key }), id: \.key) { clave, opcion in
                Button(action: {
                    seleccion = clave
                }) {
                    HStack {
                        Text("\(clave)) \(opcion)")
                        Spacer()
//                        leer la documentación abajo
                        if seleccion == clave {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    .padding()
                    .background(seleccion == clave ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}


//SwiftUI construye un botón por cada opción. Entonces, internamente, el ForEach genera algo como:

//Botón para "a"
//Botón para "b"
//Botón para "c"
//Botón para "d"

//Cuando haces clic en una opción (por ejemplo la opción "b"), se guarda así:
//seleccion = "b"

//Por qué luego if seleccion == clave?
//Porque cada botón necesita saber si él fue el que fue seleccionado.
//Así que en cada vuelta del ForEach, se hace algo así:
//if seleccion == "a" // ¿fui yo?
//if seleccion == "b" // ¿fui yo?
//if seleccion == "c" // ¿fui yo?
//...

//¿Por qué se vuelve a ejecutar el ForEach después de seleccion = clave?
//Porque @State en SwiftUI dispara una actualización automática de la vista cuando cambia su valor.
//La propiedad @State le dice a SwiftUI:
//“Si esta variable cambia, vuelve a dibujar (renderizar) cualquier parte de la vista que dependa de ella.”

//Entonces, ¿qué pasa cuando haces esto?
//seleccion = clave
//Se asigna una nueva clave (ej. "c") a seleccion.
//SwiftUI detecta que @State seleccion ha cambiado.
//SwiftUI vuelve a ejecutar el cuerpo de la vista ContenidoPregunta.
//El nuevo valor de seleccion se usa en el if seleccion == clave para que solo el botón correspondiente se marque visualmente.


//Es como decir:
//“Cuando el usuario toca una opción, actualiza el estado y vuelve a construir toda la vista con ese nuevo estado.”
//¿Y se ejecuta TODO de nuevo?
//Técnicamente, sí se vuelve a construir todo el body, pero SwiftUI es inteligente y eficiente: solo vuelve a dibujar lo que realmente cambió visualmente. En este caso, solo cambia:
//
//El botón que antes estaba seleccionado y ahora no lo está.
//El nuevo botón que acaba de ser seleccionado.

//Ejemplo en acción:
//Supón que el usuario hace esto:
//
//Toca "b" → seleccion = "b" → SwiftUI redibuja la vista:
//"a" no tiene check
//"b" tiene check y fondo azul
//"c" y "d" sin cambios
//Luego toca "d" → seleccion = "d" → SwiftUI redibuja:
//"b" pierde el check
//"d" lo gana
//"a" y "c" igual
