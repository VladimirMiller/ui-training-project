//
//  RatingView.swift
//  ui-training-project
//
//  Created by Vladimir Miller on 13.06.2022.
//

import Foundation
import SwiftUI

struct RatingUIKitView: UIViewControllerRepresentable {
    typealias UIViewControllerType = RatingViewController
    
    func makeUIViewController(context: Context) -> RatingViewController {
        return RatingViewController()
    }
    
    func updateUIViewController(_ uiViewController: RatingViewController, context: Context) {
        
    }
}
