//
//  VistaPregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//


import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

struct VistaPregunta: View {
    @ObservedObject var manager: PreguntaManager
    @State private var respuestaSeleccionada: String? = nil
    @State private var mostrarResultado = false
    @State private var mostrarFinal = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var volverAlInicio: Bool

    var body: some View {
        VStack(spacing: 25) { // Más espacio entre secciones
            // Indicador de progreso/pregunta actual
            Text("Pregunta \(manager.preguntasContestadas + 1) de \(manager.limitePreguntas)")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 10)

            if let pregunta = manager.preguntaActual {
                // Contenedor para la pregunta
                Text(pregunta.pregunta)
                    .font(.title) // Más grande
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20) // Fondo de tarjeta para la pregunta
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal) // Margen lateral

                // Opciones de respuesta
                VStack(spacing: 15) { // Espacio entre opciones
                    ForEach(pregunta.opciones.sorted(by: { $0.key < $1.key }), id: \.key) { clave, texto in
                        Button(action: {
                            if !mostrarResultado { // Solo permite seleccionar si aún no se ha mostrado el resultado
                                verificarRespuesta(clave)
                            }
                        }) {
                            HStack {
                                Text("\(clave))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(width: 25) // Ancho fijo para la letra
                                Text(texto)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                // Lógica de color para el feedback visual
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        mostrarResultado ?
                                            (clave == pregunta.respuesta_correcta ? Color.green.opacity(0.6) :
                                             (clave == respuestaSeleccionada ? Color.red.opacity(0.6) : Color.gray.opacity(0.2))) :
                                            Color.gray.opacity(0.15) // Color por defecto más claro
                                    )
                                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                            )
                            .foregroundColor(mostrarResultado && (clave == pregunta.respuesta_correcta || clave == respuestaSeleccionada) ? .white : .black) // Texto blanco para opciones correctas/incorrectas
                            .scaleEffect(respuestaSeleccionada == clave && mostrarResultado ? 1.05 : 1.0) // Pequeña escala al seleccionar
                            .animation(.easeOut(duration: 0.2), value: respuestaSeleccionada) // Animación al seleccionar
                        }
                        .disabled(mostrarResultado) // Deshabilita los botones después de responder
                    }
                }
                .padding(.horizontal)

                // Mensaje de resultado de la respuesta
                if mostrarResultado {
                    VStack {
                        if respuestaSeleccionada == pregunta.respuesta_correcta {
                            Text("✅ ¡Respuesta correcta!")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                        } else {
                            Text("❌ Incorrecto.")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                            Text("La correcta era: \(pregunta.respuesta_correcta)) \(pregunta.opciones[pregunta.respuesta_correcta]!)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top, 10)

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
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .transition(.opacity.animation(.easeIn(duration: 0.3))) // Animación al aparecer el botón
                }
            } else {
                Text("Cargando pregunta...")
                    .font(.title2)
                    .foregroundColor(.gray)
            }

            Spacer()
            let adSize = currentOrientationAnchoredAdaptiveBanner(width: 375)
            BannerViewContainer(adSize)
                .frame(width: adSize.size.width, height: adSize.size.height)
        }
        //aqui termina el vstack 
        .padding(.vertical) // Padding general para la vista
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()) // Fondo degradado suave
        .sheet(isPresented: $mostrarFinal, onDismiss: {
            if self.volverAlInicio {
                 self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            ResultadoFinalView(volverAlInicio: $volverAlInicio, puntaje: manager.aciertos, total: manager.limitePreguntas)
        }
    }

    func verificarRespuesta(_ clave: String) {
        respuestaSeleccionada = clave
        mostrarResultado = true
        // Puedes añadir aquí un feedback háptico (vibración)
        // Por ejemplo: let impactMed = UIImpactFeedbackGenerator(style: .medium)
        // impactMed.impactOccurred()
    }
}

private struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    
    init(_ adSize: AdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = "ca-app-pub-3533060432708868/3650213154"
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
}


