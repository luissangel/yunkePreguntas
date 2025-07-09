//
//  SeleccionCantidadView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct SeleccionCantidadView: View {
    let materia: String
    @State private var cantidadSeleccionada = 10
    @State private var mostrarVistaPregunta = false
    @State private var shouldPopToRoot = false

    @Environment(\.presentationMode) var presentationMode

    let cantidadesDisponibles = [10, 15, 20]

    var body: some View {
        VStack(spacing: 25) { // Más espacio entre elementos
            Text("Materia:")
                .font(.title3)
                .foregroundColor(.gray)

            Text(materia)
                .font(.largeTitle) // Título más prominente
                .fontWeight(.bold)
                .foregroundColor(.blue) // Un color que destaque
                .padding(.bottom, 20)

            Text("¿Cuántas preguntas quieres contestar?")
                .font(.headline)
                .foregroundColor(.primary)

            // El Picker con un estilo más moderno y destacado
            Picker("Cantidad de preguntas", selection: $cantidadSeleccionada) {
                ForEach(cantidadesDisponibles, id: \.self) { num in
                    Text("\(num)")
                        .font(.title2) // Fuentes más grandes para las opciones
                        .fontWeight(.semibold)
                        .tag(num)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Sigue siendo Segmented
            .background(
                RoundedRectangle(cornerRadius: 15) // Fondo redondeado para el picker
                    .fill(Color.gray.opacity(0.1))
            )
            .padding(.horizontal) // Padding lateral para que no toque los bordes
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3) // Sombra sutil

            Spacer()

            Button("Iniciar Cuestionario") {
                mostrarVistaPregunta = true
            }
            .font(.title2) // Fuente más grande para el botón
            .fontWeight(.bold)
            .padding(.vertical, 15)
            .padding(.horizontal, 40)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.green]), startPoint: .leading, endPoint: .trailing)) // Degradado atractivo
            .foregroundColor(.white)
            .cornerRadius(30) // Más redondeado para parecer un "pill"
            .shadow(color: Color.green.opacity(0.4), radius: 10, x: 0, y: 5) // Sombra que resalte

        }
        .padding()
        .navigationTitle("") // Ocultamos el título de la navegación si ya lo mostramos grande en la vista
        .navigationBarTitleDisplayMode(.inline) // Para que el espacio no sea tan grande si hay otro título
        .background(Color.blue.opacity(0.05).ignoresSafeArea()) // Fondo suave para toda la vista
        .sheet(isPresented: $mostrarVistaPregunta, onDismiss: {
            if self.shouldPopToRoot {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            VistaPregunta(manager: PreguntaManager(materia: materia, cantidad: cantidadSeleccionada), volverAlInicio: $shouldPopToRoot)
        }
    }
}


