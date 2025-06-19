//
//  PreguntaManager.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

//Importa funcionalidades básicas como manejo de archivos, JSON, etc.
//(No se usa SwiftUI aquí porque esta clase no tiene vistas, solo lógica.)

import Foundation

class PreguntaManager: ObservableObject {
    
//Estas propiedades tienen @Published, lo que significa que:
//Cuando cambian, cualquier vista que las esté observando se actualizará automáticamente.
//State es diferente de published porque el primero es en una view y el segundo se usa en una clase, swiftui observa la clase mientras directamente observa el state, publisehd puede ser modificado por cualquier parte que tenga acceso al objeto mientras que state solo lo modifica la vista
    
    @Published var preguntas: [Pregunta] = []
    @Published var preguntaActual: Pregunta?
    @Published var preguntasContestadas = 0
    @Published var aciertos = 0
    var limitePreguntas: Int

    init(materia: String, cantidad: Int) {
        self.limitePreguntas = cantidad
        self.preguntas = cargarPreguntas().filter { $0.materia == materia }.shuffled().prefix(cantidad).map { $0 }
        print("✅ Preguntas encontradas para \(materia): \(preguntas.count)")
        siguientePregunta()
    }

    func siguientePregunta() {
        if preguntas.isEmpty {
            preguntaActual = nil
            return
        }
        preguntaActual = preguntas.removeFirst()
    }

    func responder(correcta: Bool) {
        preguntasContestadas += 1
        if correcta { aciertos += 1 }
    }

    private func cargarPreguntas() -> [Pregunta] {
        guard let url = Bundle.main.url(forResource: "preguntas", withExtension: "json") else {
            print("❌ Archivo no encontrado")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let preguntas = try JSONDecoder().decode([Pregunta].self, from: data)
            print("✅ Se cargaron \(preguntas.count) preguntas")
            return preguntas
        } catch {
            print("❌ Error al decodificar preguntas: \(error)")
            return []
        }
    }
}


