//
//  MenuMateriasView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//
import SwiftUI

struct MenuMateriasView: View {
    let materias = ["Biología", "Historia de México", "Historia Universal", "Literatura", "Geografía"]
    
    // Un diccionario simple para asociar materias con colores (opcional, puedes usar un array de colores también)
    let coloresMaterias: [String: Color] = [
        "Biología": .green.opacity(0.7),
        "Historia de México": .brown.opacity(0.7),
        "Historia Universal": .orange.opacity(0.7),
        "Literatura": .purple.opacity(0.7),
        "Geografía": .blue.opacity(0.7)
    ]
    
    var body: some View {
        NavigationView {
            List { // Usamos List sin pasar un array para mayor control
                ForEach(materias, id: \.self) { materia in
                    NavigationLink(destination: SeleccionCantidadView(materia: materia)) {
                        HStack {
                            Text(materia)
                                .font(.title2)
                                .fontWeight(.medium) // Texto un poco más grueso
                                .foregroundColor(.white) // Texto blanco para contrastar con el fondo
                            Spacer() // Empuja el texto a la izquierda y la flecha a la derecha
                            Image(systemName: "chevron.right") // Flecha indicadora de navegación
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding()
                        .background(
                            // Usa el color del diccionario o un color por defecto
                            coloresMaterias[materia] ?? Color.gray.opacity(0.7)
                        )
                        .cornerRadius(15) // Esquinas más redondeadas
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Sombra sutil
                    }
                    .listRowSeparator(.hidden) // Oculta la línea divisoria
                    .listRowBackground(Color.clear) // Fondo transparente para la fila de la lista
                    .padding(.vertical, 5) // Espacio vertical entre tarjetas
                }
            }
            .listStyle(.plain) // Estilo de lista plano
            .navigationTitle("Elige una materia")
            .background(Color.blue.opacity(0.1).ignoresSafeArea()) // Fondo general de la vista
        }
    }
}

