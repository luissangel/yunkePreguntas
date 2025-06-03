//
//  Pregunta.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

import Foundation

struct Pregunta: Codable, Identifiable {
    let materia: String
    let pregunta: String
    let opciones: [String: String]
    let respuesta_correcta: String
    var id: UUID { UUID() } 
}

