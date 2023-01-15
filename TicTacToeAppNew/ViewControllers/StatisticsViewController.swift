//
//  StatisticsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    
    @IBOutlet var resetProgressButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFeedback(withHapticType: .soft)

        resetProgressButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        generateFeedback(withHapticType: .soft)
    }
    
    @IBAction func resetButtonAction() {
        
        generateFeedback(withHapticType: .warning)
        
    }
    
    
    
    
}


