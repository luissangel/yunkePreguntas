//
//  ContenidoPregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

import SwiftUI

struct ContenidoPregunta: View {
    let pregunta: Pregunta
    @State private var seleccion: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(pregunta.pregunta)
                .font(.title2)
            
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
