//
//  BannerAdView.swift
//  yunkePreguntas
//
//  Created by Luis Hernandez on 06/07/25.
//

import GoogleMobileAds
import SwiftUI


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
    banner.delegate = context.coordinator
    return banner
  }

  func updateUIView(_ uiView: BannerView, context: Context) {}

  func makeCoordinator() -> BannerCoordinator {
    return BannerCoordinator(self)
  }
