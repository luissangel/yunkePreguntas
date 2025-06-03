//
//  PreguntaManager.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//
import Foundation

class PreguntaManager: ObservableObject {
    @Published var preguntas: [Pregunta] = []
    @Published var preguntaActual: Pregunta?
    
    init(materia: String) {
        self.preguntas = cargarPreguntas().filter { $0.materia == materia }
        print("✅ Preguntas encontradas para \(materia): \(preguntas.count)")
        siguientePregunta()
    }
    
    func siguientePregunta() {
        if preguntas.isEmpty { return }
        preguntaActual = preguntas.randomElement()
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

