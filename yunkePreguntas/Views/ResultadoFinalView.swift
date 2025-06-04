//
//  ResultadoFinalView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 03/06/25.
//

import SwiftUI

struct ResultadoFinalView: View {
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
        }
        .padding()
    }
    
        

}
