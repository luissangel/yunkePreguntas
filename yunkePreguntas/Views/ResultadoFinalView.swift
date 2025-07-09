//
//  ResultadoFinalView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct ResultadoFinalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var volverAlInicio: Bool // <-- Recibe el binding de VistaPregunta

    let puntaje: Int
    let total: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 ¡Has terminado!")
                .font(.largeTitle)
            
            Text("Tu puntaje: \(puntaje) de \(total)")
                .font(.title2)
            
            Text("Calificación: \(Int(Double(puntaje) / Double(total) * 100))%")
                .font(.title3)
                .foregroundColor(.blue)

            Button("Volver a Materias") {
                // 1. Descarta esta vista (ResultadoFinalView)
                self.presentationMode.wrappedValue.dismiss()
                // 2. Establece el binding para que las vistas anteriores también se descarten
                self.volverAlInicio = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Opcional: Oculta el botón de retroceso aquí
    }
}

