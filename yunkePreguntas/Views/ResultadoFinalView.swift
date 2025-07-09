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

    @State private var animateIcon = false // <-- Nueva propiedad @State para la animación

    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding(.bottom, 10)
                .rotationEffect(.degrees(animateIcon ? 360 : 0)) // <-- Usamos 'animateIcon'
                .animation(.easeOut(duration: 1.5), value: animateIcon) // <-- Animación basada en 'animateIcon'
                .onAppear {
                    // Al aparecer la vista, activamos la animación
                    animateIcon = true
                }

            Text("🎉 ¡Has terminado!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            VStack(spacing: 10) {
                Text("Tu puntaje:")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("\(puntaje) de \(total)")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
            }
            .padding(.vertical, 10)

            Text("Calificación: \(Int(Double(puntaje) / Double(total) * 100))%")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.purple)

            Spacer()

            Button("Volver a Materias") {
                self.presentationMode.wrappedValue.dismiss()
                self.volverAlInicio = true
            }
            .font(.title2)
            .fontWeight(.bold)
            .padding(.vertical, 15)
            .padding(.horizontal, 40)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled(true)
    }
}

