//
//  Extension UIViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit


extension UIViewController {
    
    enum TapticEngine {
        case selection
        
        case light
        case medium
        case heavy
        case soft
        case rigid
        
        case success
        case warning
        case error
        
    }
    
    
    func generateFeedback(withHapticType haptic: TapticEngine) {

        switch haptic {
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        case .rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
    
}
