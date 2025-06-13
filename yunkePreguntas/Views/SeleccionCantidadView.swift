//
//  SeleccionCantidadView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct SeleccionCantidadView: View {
    let materia: String
    let opciones = [10, 15, 20]
    @State private var volverAlInicio = false
    

    
    var body: some View {
        VStack(spacing: 20) {
            Text("¿Cuántas preguntas quieres responder?")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            ForEach(opciones, id: \.self) { cantidad in
                NavigationLink(
                    destination: VistaPregunta(
                        manager: PreguntaManager(materia: materia, cantidad: cantidad),
                        volverAlInicio: $volverAlInicio
                    )
                ) {
                    Text("\(cantidad) preguntas")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .navigationTitle(materia)
        
        .onChange(of: volverAlInicio) { nuevoValor in
            if nuevoValor {
                // Volver a la vista raíz
                volverAlInicio = false
                // Esta línea cierra esta vista (SeleccionCantidadView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }

    }
    
}
