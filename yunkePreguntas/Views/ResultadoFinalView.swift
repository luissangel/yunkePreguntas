//
//  ResultadoFinalView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct ResultadoFinalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var volverAlInicio: Bool

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
                // Descarta esta vista (ResultadoFinalView)
                self.presentationMode.wrappedValue.dismiss()
                // Y establece el binding para que las vistas anteriores también se descarten
                self.volverAlInicio = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        // ¡Esta es la línea clave! Deshabilita el cierre interactivo del sheet
        .interactiveDismissDisabled(true)
    }
}

