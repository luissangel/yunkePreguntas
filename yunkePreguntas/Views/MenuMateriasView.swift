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
        NavigationView {
            List(materias, id: \.self) { materia in
                NavigationLink(destination: VistaPregunta(manager: PreguntaManager(materia: materia))) {
                    Text(materia)
                }
            }
            .navigationTitle("Elige una materia")
        }
    }
}

