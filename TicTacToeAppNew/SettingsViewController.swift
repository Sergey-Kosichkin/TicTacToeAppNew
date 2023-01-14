//
//  SettingsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var computerSettingsStack: UIStackView!
    @IBOutlet var difficultySlider: UISlider!
    @IBOutlet var autoDifficultySwitch: UISwitch!
    @IBOutlet var namePicker: UIPickerView!
    
    @IBOutlet var opponentSegmentedControl: UISegmentedControl!
    
    @IBOutlet var resetProgressButton: UIButton!
    
    @IBOutlet var greyColorButton: UIButton!
    @IBOutlet var blueColorButton: UIButton!
    @IBOutlet var brownColorButton: UIButton!
    @IBOutlet var orangeColorButton: UIButton!
    
    @IBOutlet var saveButton: UIButton!
    
    private var i = 5
    
    private let names = ["Michael", "Elliot", "John", "Christine", "Eva", "Alexey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        computerSettingsStack.isHidden = true
        
        
        if autoDifficultySwitch.isOn {
            difficultySlider.isEnabled = false
        }
        
        greyColorButton.layer.cornerRadius = 10
        blueColorButton.layer.cornerRadius = 10
        brownColorButton.layer.cornerRadius = 10
        orangeColorButton.layer.cornerRadius = 10
        
        
        
        greyColorButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        blueColorButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        brownColorButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        orangeColorButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        resetProgressButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        opponentSegmentedControl.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        resetProgressButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        
        greyColorButton.layer.shadowColor = UIColor.white.cgColor
        greyColorButton.layer.shadowOpacity = 5
        greyColorButton.layer.shadowOffset = .zero
        greyColorButton.layer.shadowRadius = 15
        
//        namePicker.dataSource = names as! any UIPickerViewDataSource
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        greyColorButton.titleLabel?.font = .systemFont(ofSize: greyColorButton.layer.bounds.height / 4)
        blueColorButton.titleLabel?.font = .systemFont(ofSize: blueColorButton.layer.bounds.height / 4)
        brownColorButton.titleLabel?.font = .systemFont(ofSize: brownColorButton.layer.bounds.height / 4)
        orangeColorButton.titleLabel?.font = .systemFont(ofSize: orangeColorButton.layer.bounds.height / 4)
        
        
        
    }
    

    @IBAction func changeOpponentSegment(_ sender: UISegmentedControl) {
        
        if 1 == sender.selectedSegmentIndex {
            computerSettingsStack.isHidden = false
            namePicker.isHidden = true
        } else {
            computerSettingsStack.isHidden = true
            namePicker.isHidden = false
        }
    }
    
    @IBAction func difficultySwitchAction() {
        if autoDifficultySwitch.isOn {
            autoDifficultySwitch.isOn = false
            difficultySlider.isEnabled = true
        } else if !autoDifficultySwitch.isOn {
            autoDifficultySwitch.isOn = true
            difficultySlider.isEnabled = false
        }
        
    }
    
    @IBAction func colorButtonAction(_ sender: UIButton) {
        
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
            } else {
                
            }
        }
        
        
    }
    
    
    @IBAction func saveButtonPressed() {
        dismiss(animated: true)
    }
    
    
    
    
    
    
    
    @objc func tapped() {
//        i += 1
        print("Running \(i)")
        
        
        
        switch i {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
    
    
    
    
    
    
}
