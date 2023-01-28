//
//  StatisticsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var resetProgressButton: UIButton!
    
    
    //MARK: - Public properties
    var setting: Setting!
    var gameInfo: Game!
    var delegate: gameInfoViewControllerDelegate!
    
    
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFeedback(withHapticType: .soft)
        resetProgressButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeBackgroundColor(to: setting.backgroundColor)
        checkForResultCounts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        generateFeedback(withHapticType: .soft)
    }
    
    
    
    //MARK: - IBActions
    @IBAction func resetButtonAction() {
        generateFeedback(withHapticType: .warning)
        showAlert(withTitle: "Reset current progress?", andMessage: "")
    }
    
    
    
    //MARK: - Private functions
    private func checkForResultCounts() {
        if gameInfo.resultCount.draw == 0,
           gameInfo.resultCount.x == 0,
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
    
    private func resetCurrentScoreCounts() {
        gameInfo.resultCount.draw = 0
        gameInfo.resultCount.x = 0
        gameInfo.resultCount.o = 0
        
        delegate.passDataThrough(from: gameInfo)
        
        checkForResultCounts()
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Cancel", style: .default)
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) {_ in
            self.resetCurrentScoreCounts()
        }
        alert.addAction(okAction)
        alert.addAction(resetAction)
        present(alert, animated: true)
    }
}


