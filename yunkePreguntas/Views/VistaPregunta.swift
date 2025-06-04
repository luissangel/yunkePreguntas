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
    @State private var mostrarFinal = false
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack(spacing: 20) {
            if let pregunta = manager.preguntaActual {
                Text(pregunta.pregunta)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(pregunta.opciones.sorted(by: { $0.key < $1.key }), id: \.key) { clave, texto in
                    Button(action: {
                        verificarRespuesta(clave)
                    }) {
                        Text("\(clave)) \(texto)")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                mostrarResultado ?
                                    (clave == pregunta.respuesta_correcta ? Color.green.opacity(0.5) :
                                     clave == respuestaSeleccionada ? Color.red.opacity(0.5) : Color.gray.opacity(0.2)) :
                                    Color.gray.opacity(0.2)
                            )
                            .cornerRadius(10)
                    }
                    .disabled(mostrarResultado)
                }

                if mostrarResultado {
                    if respuestaSeleccionada == pregunta.respuesta_correcta {
                        Text("✅ ¡Respuesta correcta!").foregroundColor(.green)
                    } else {
                        Text("❌ Incorrecto. La correcta era: \(pregunta.respuesta_correcta)").foregroundColor(.red)
                    }

                    Button("Siguiente pregunta") {
                        if manager.preguntasContestadas + 1 >= manager.limitePreguntas {
                            mostrarFinal = true
                        } else {
                            manager.siguientePregunta()
                        }
                        manager.responder(correcta: respuestaSeleccionada == pregunta.respuesta_correcta)
                        respuestaSeleccionada = nil
                        mostrarResultado = false
                    }
                    .padding()
                }
            } else {
                Text("Cargando pregunta...")
            }

            Spacer()
        }
        .padding()
        .sheet(isPresented: $mostrarFinal, onDismiss: {
            // Al cerrar el resultado, se cierra también esta vista para regresar al menú
            presentationMode.wrappedValue.dismiss()
        }) {
            ResultadoFinalView(puntaje: manager.aciertos, total: manager.limitePreguntas)
        }


    }

    func verificarRespuesta(_ clave: String) {
        respuestaSeleccionada = clave
        mostrarResultado = true
    }
}




