//
//  MenuMateriasView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//
import SwiftUI

struct MenuMateriasView: View {
    let materias = ["Biología", "Historia de México", "Historia Universal", "Literatura", "Geografía"]
    
    var body: some View {
//Crea un contenedor de navegación, lo cual permite: tener una barra de navegación arriba, y usar NavigationLink para moverse a otras vistas.
        NavigationView {
//Cada fila de la lista es un botón de navegación:
            List(materias, id: \.self) { materia in
                NavigationLink(destination: SeleccionCantidadView(materia: materia)) {
                    Text(materia)
                }

            }
            .navigationTitle("Elige una materia")
        }
    }
}

