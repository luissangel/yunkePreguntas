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


