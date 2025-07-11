//
//  yunkePreguntasApp.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 29/05/25.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

@main
struct yunkePreguntasApp: App {
    
    init() {
          MobileAds.shared.start(completionHandler: nil)
          
          MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [
                      "SIMULATOR", // para simulador
                      "5276a284b12e3bcc36daba2e75aa680a"  // para tu dispositivo físico
                  ]
           }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MenuMateriasView()
        }
    }
}


