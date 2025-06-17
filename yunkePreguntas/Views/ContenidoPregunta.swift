//
//  ContenidoPregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//


//Esta vista es para mostrar el contenido de las preguntas, es decir, la pregunta con sus opciones

import SwiftUI

struct ContenidoPregunta: View {
    let pregunta: Pregunta
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
