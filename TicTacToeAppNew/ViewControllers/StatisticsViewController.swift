//
//  StatisticsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    
    @IBOutlet var resetProgressButton: UIButton!
    
    
    var setting: Setting!
    var gameInfo: Game!
    var delegate: gameInfoViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFeedback(withHapticType: .soft, whenLowPower: setting.lowPower)

        resetProgressButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBackgroundColor(setting.backgroundColor)
        checkForResultCounts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        generateFeedback(withHapticType: .soft, whenLowPower: setting.lowPower)
    }
    
    @IBAction func resetButtonAction() {
        generateFeedback(withHapticType: .warning, whenLowPower: false)
        
        showAlert(withTitle: "Reset current progress?",
                  andMessage: "")
        
//        gameInfo.resultCount.draw = 0
//        gameInfo.resultCount.x = 0
//        gameInfo.resultCount.o = 0
//
//        delegate.passDataThrough(from: gameInfo)
//
//        checkForResultCounts()
        
    }
    
//    private func changeBackgroundColor() {
//        view.backgroundColor = setting.backgroundColor
//
//        setBackgroundColor(setting.backgroundColor)
//    }
    
    private func checkForResultCounts() {
        if gameInfo.resultCount.draw == 0 &&
            gameInfo.resultCount.x == 0 &&
            gameInfo.resultCount.o == 0 {
            resetProgressButton.isEnabled = false
            resetProgressButton.layer.opacity = 0.3
            resetProgressButton.setTitle("The progress reseted!", for: .normal)
        } else {
            
            resetProgressButton.isEnabled = true
            resetProgressButton.layer.opacity = 1
            resetProgressButton.setTitle("Reset current progress", for: .normal)
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Cancel", style: .default)
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) {_ in
            self.gameInfo.resultCount.draw = 0
            self.gameInfo.resultCount.x = 0
            self.gameInfo.resultCount.o = 0
            
            self.delegate.passDataThrough(from: self.gameInfo)
            
            self.checkForResultCounts()
        }
        alert.addAction(okAction)
        alert.addAction(resetAction)
        present(alert, animated: true)
    }
}


