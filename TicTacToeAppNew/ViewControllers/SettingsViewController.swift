//
//  SettingsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var greyColorButton: UIButton!
    @IBOutlet var blueColorButton: UIButton!
    @IBOutlet var brownColorButton: UIButton!
    @IBOutlet var orangeColorButton: UIButton!
    
    @IBOutlet var opponentSegmentedControl: UISegmentedControl!
    
    @IBOutlet var computerSettingsStack: UIStackView!
    
    @IBOutlet var autoDifficultySwitch: UISwitch!
    @IBOutlet var difficultySlider: UISlider!
    @IBOutlet var autoProgressSlider: UISlider!
    
    @IBOutlet var saveButton: UIButton!
    
    
    private var lastPressedColorButton: UIButton!
    
    override func viewDidLoad() {
        generateFeedback(withHapticType: .rigid)
        super.viewDidLoad()
        
        computerSettingsStack.isHidden = true
        
        difficultySwitchAction()
        
        greyColorButton.layer.cornerRadius = 10
        blueColorButton.layer.cornerRadius = 10
        brownColorButton.layer.cornerRadius = 10
        orangeColorButton.layer.cornerRadius = 10
        
        
        saveButton.layer.cornerRadius = 10
        
        greyColorButton.layer.shadowColor = UIColor.white.cgColor
        greyColorButton.layer.shadowOpacity = 5
        greyColorButton.layer.shadowOffset = .zero
        greyColorButton.layer.shadowRadius = 15
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        greyColorButton.titleLabel?.font = .systemFont(ofSize: greyColorButton.layer.bounds.height / 5)
        blueColorButton.titleLabel?.font = .systemFont(ofSize: blueColorButton.layer.bounds.height / 5)
        brownColorButton.titleLabel?.font = .systemFont(ofSize: brownColorButton.layer.bounds.height / 5)
        orangeColorButton.titleLabel?.font = .systemFont(ofSize: orangeColorButton.layer.bounds.height / 5)
        
        
        
    }
    

    @IBAction func changeOpponentSegment(_ sender: UISegmentedControl) {
        
        generateFeedback(withHapticType: .light)
        
        if 1 == sender.selectedSegmentIndex {
            computerSettingsStack.isHidden = false
        } else {
            computerSettingsStack.isHidden = true
        }
    }
    
    
    @IBAction func difficultySwitchAction() {
        if autoDifficultySwitch.isOn {
            
            difficultySlider.isHidden = true
            difficultySlider.setValue(0.2, animated: false)
            
            autoProgressSlider.isHidden = false
            autoProgressSlider.setValue(0.2, animated: true)
            
        } else if !autoDifficultySwitch.isOn {
            
            autoProgressSlider.isHidden = true
            autoProgressSlider.setValue(0.8, animated: false)
            
            difficultySlider.isHidden = false
            difficultySlider.setValue(0.8, animated: true)
            
        }
        
    }
    
    @IBAction func difficultySliderAction() {
        
        
    }
    
    
    
    
    @IBAction func colorButtonAction(_ sender: UIButton) {
        
        if lastPressedColorButton != sender {
            generateFeedback(withHapticType: .soft)
        }
        lastPressedColorButton = sender
        
        
        
        let buttons = [greyColorButton,
                       blueColorButton,
                       brownColorButton,
                       orangeColorButton]
        
        sender.layer.shadowColor = UIColor.white.cgColor
        sender.layer.shadowOpacity = 5
        sender.layer.shadowOffset = .zero
        sender.layer.shadowRadius = 15
        
        
        view.backgroundColor = sender.backgroundColor
        
        for button in buttons {
            if button != sender {
                button?.layer.shadowOpacity = 0
            }
        }
        
    }
    
    
    @IBAction func saveButtonPressed() {
        generateFeedback(withHapticType: .rigid)
        dismiss(animated: true)
    }
    
    
    
}
