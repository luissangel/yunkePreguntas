//
//  SeleccionCantidadView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct SeleccionCantidadView: View {
    let materia: String
    @State private var cantidadSeleccionada = 10 // Puedes inicializarlo en 10, 15 o 20
    @State private var mostrarVistaPregunta = false
    @State private var shouldPopToRoot = false

    @Environment(\.presentationMode) var presentationMode

    // Define un array con las cantidades permitidas
    let cantidadesDisponibles = [10, 15, 20]

    var body: some View {
        VStack {
            Text("Materia: \(materia)")
                .font(.title)

            Picker("Cantidad de preguntas", selection: $cantidadSeleccionada) {
                // Itera sobre el nuevo array de cantidadesDisponibles
                ForEach(cantidadesDisponibles, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Iniciar Cuestionario") {
                mostrarVistaPregunta = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Selecciona Cantidad")
        .sheet(isPresented: $mostrarVistaPregunta, onDismiss: {
            if self.shouldPopToRoot {
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            VistaPregunta(manager: PreguntaManager(materia: materia, cantidad: cantidadSeleccionada), volverAlInicio: $shouldPopToRoot)
        }
    }
}


