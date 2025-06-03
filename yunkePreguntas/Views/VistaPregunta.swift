//
//  VistaPregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

import SwiftUI

struct VistaPregunta: View {
    @ObservedObject var manager: PreguntaManager
    @State private var respuestaSeleccionada: String? = nil
    @State private var mostrarResultado = false

    var body: some View {
        VStack(spacing: 20) {
            Text(manager.preguntaActual?.pregunta ?? "")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            ForEach(manager.preguntaActual?.opciones.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { clave, texto in
                Button(action: {
                    verificarRespuesta(clave)
                }) {
                    Text("\(clave)) \(texto)")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            mostrarResultado ?
                                (clave == manager.preguntaActual?.respuesta_correcta ? Color.green.opacity(0.5) :
                                 clave == respuestaSeleccionada ? Color.red.opacity(0.5) : Color.gray.opacity(0.2)) :
                                Color.gray.opacity(0.2)
                        )
                        .cornerRadius(10)
                }
                .disabled(mostrarResultado)
            }

            if mostrarResultado {
                if respuestaSeleccionada == manager.preguntaActual?.respuesta_correcta {
                    Text("✅ ¡Respuesta correcta!").foregroundColor(.green)
                } else {
                    Text("❌ Incorrecto. La correcta era: \(manager.preguntaActual?.respuesta_correcta ?? "")").foregroundColor(.red)
                }

                Button("Siguiente pregunta") {
                    manager.siguientePregunta()
                    respuestaSeleccionada = nil
                    mostrarResultado = false
                }
                .padding()
            }

            Spacer()
        }
        .padding()
    }

    func verificarRespuesta(_ clave: String) {
        respuestaSeleccionada = clave
        mostrarResultado = true
    }
}



