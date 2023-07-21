//
//  lottieAnimation.swift
//  StationInformation
//
//  Created by Clarabella Lius on 20/07/23.
//

import SwiftUI
import Lottie

struct LottieIcon: UIViewRepresentable{
    typealias UIViewType = UIView
    
    var animationName: String
    let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

