//
//  yunkePreguntasApp.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 29/05/25.
//

import SwiftUI
import GoogleMobileAds

@main
struct yunkePreguntasApp: App {
    
    init() {
        MobileAds.shared.start(completionHandler: nil)
        }
    
    var body: some Scene {
        WindowGroup {
            MenuMateriasView()
        }
    }
}


