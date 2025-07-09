//
//  ContentView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 30/05/25.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    var body: some View {
        MenuMateriasView()
        
        Spacer()
        let adSize = currentOrientationAnchoredAdaptiveBanner(width: 375)
          BannerViewContainer(adSize)
            .frame(width: adSize.size.width, height: adSize.size.height)
//        BannerViewContainer(AdSizeBanner)
//                        .frame(height: 50)
    }
}

#Preview {
    ContentView()
}

// UIViewRepresentable wrapper for AdMob banner view
private struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize

    init(_ adSize: AdSize) {
        self.adSize = adSize
    }

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        banner.load(Request())
        return banner
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}
}

