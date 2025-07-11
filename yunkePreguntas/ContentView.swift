//
//  ContentView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

struct ContentView: View {
    
    var body: some View {
        VStack {
            MenuMateriasView()
            Spacer()
            let adSize = currentOrientationAnchoredAdaptiveBanner(width: 375)
            BannerViewContainer(adSize)
                .frame(width: adSize.size.width, height: adSize.size.height)
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                requestTrackingPermission()
            }
        }
    }
}


#Preview {
    ContentView()
}

private struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    
    init(_ adSize: AdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = "ca-app-pub-3533060432708868/3650213154"
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
}
func requestTrackingPermission() {
    ATTrackingManager.requestTrackingAuthorization { status in
        switch status {
        case .authorized:
            print("Permiso de rastreo AUTORIZADO")
            let idfa = ASIdentifierManager.shared().advertisingIdentifier
            print("IDFA: \(idfa)")
        case .denied:
            print("Permiso de rastreo DENEGADO")
        case .notDetermined:
            print("Permiso de rastreo NO DETERMINADO")
        case .restricted:
            print("Permiso de rastreo RESTRINGIDO")
        @unknown default:
            print("Estado desconocido de ATT")
        }
    }
}


