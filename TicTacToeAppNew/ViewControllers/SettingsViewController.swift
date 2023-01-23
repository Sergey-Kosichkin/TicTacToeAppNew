//
//  SettingsViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
//    Think about black color theme for background
//    Think about low power mode functions
//    Think about text color and background (auto ios theme changing)
    
    
    
    //MARK: - IBOutlets
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBOutlet var opponentSegmentedControl: UISegmentedControl!
    
    @IBOutlet var computerSettingsStack: UIStackView!
    
    @IBOutlet var difficultySlider: UISlider!
    @IBOutlet var autoDifficultySwitch: UISwitch!
    
    @IBOutlet var saveButton: UIButton!
    
    
    
    //MARK: - Public Properties
    var setting: Setting!
    var delegate: SettingsViewControllerDelegate!
    
    
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFeedback(withHapticType: .rigid, whenLowPower: setting.lowPower)
        
//                        setting.lowPower = ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBackgroundColor()
        
        // Color Buttons
        makeButtonShining(getCurrentButton())
        disableButton(getCurrentButton())
        
        // Segmented Control and Computer stack
        setGameModeSegment()
        hideOrShowComputerStack()
        
        // Computer difficulty switch and slider
        autoDifficultySwitch.isOn = setting.computer.autoDifficultyIsEnabled
        changeSliderMode()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupUI()
    }
    
    
    
    //MARK: - IBActions
    @IBAction func colorButtonAction(_ sender: UIButton) {
        unselectPreviousButton()
        makeButtonShining(sender)
        generateFeedback(withHapticType: .soft, whenLowPower: setting.lowPower)
        setColorToModel(fromCurrentButton: sender)
        setBackgroundColor()
        disableButton(sender)
    }
    
    @IBAction func changeOpponentSegment(_ sender: UISegmentedControl) {
        generateFeedback(withHapticType: .light, whenLowPower: setting.lowPower)
        changeGameMode(withSegment: sender)
        hideOrShowComputerStack()
    }
    
    @IBAction func difficultySliderAction() {
        setting.computer.manualDifficultyLevel = difficultySlider.value
    }
    
    @IBAction func difficultySwitchAction() {
        switchAutoDiffuculty()
        changeSliderMode()
    }
    
    @IBAction func saveButtonPressed() {
        generateFeedback(withHapticType: .rigid, whenLowPower: setting.lowPower)
        delegate.setNewSettings(from: setting)
        dismiss(animated: true)
    }
    
    
    
    //MARK: - Color button private functions
    private func getCurrentButton() -> UIButton {
        colorButtons[setting.backgroundColor.rawValue]
    }
    
    private func unselectPreviousButton() {
        getCurrentButton().layer.shadowOpacity = 0
        getCurrentButton().isEnabled = true
    }
    
    private func makeButtonShining(_ button: UIButton) {
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 15
    }
    
    private func setColorToModel(fromCurrentButton currentButton: UIButton) {
        for (currentIndex, colorButton) in colorButtons.enumerated() {
            guard colorButton == currentButton else { continue }
            ThemeColor.allCases.forEach {
                guard $0.rawValue == currentIndex  else { return }
                setting.backgroundColor = $0
            }
        }
    }
    
    private func disableButton(_ button: UIButton) {
        button.isEnabled = false
    }
    
    
    //MARK: - Segmented control private functions
    private func setGameModeSegment() {
        if setting.gameMode == .person {
            opponentSegmentedControl.selectedSegmentIndex = 0
        } else if setting.gameMode == .computer {
            opponentSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    private func changeGameMode(withSegment segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 1 {
            setting.gameMode = .computer
        } else {
            setting.gameMode = .person
        }
    }
    
    
    //MARK: - Computer Settings Stack private functions
    private func hideOrShowComputerStack() {
        if opponentSegmentedControl.selectedSegmentIndex == 1 {
            computerSettingsStack.isHidden = false
        } else {
            computerSettingsStack.isHidden = true
        }
    }
    
    
    //MARK: - Automatic difficulty switch private functions
    private func changeSliderMode() {
        if autoDifficultySwitch.isOn {
            difficultySlider.thumbTintColor = .clear
            difficultySlider.isEnabled = false
            difficultySlider.setValue(setting.computer.autoDifficultyLevel,
                                      animated: true)
        } else {
            difficultySlider.thumbTintColor = .white
            difficultySlider.isEnabled = true
            difficultySlider.setValue(setting.computer.manualDifficultyLevel,
                                      animated: true)
        }
    }
    
    private func switchAutoDiffuculty() {
        if autoDifficultySwitch.isOn {
            setting.computer.autoDifficultyIsEnabled = true
        } else {
            setting.computer.autoDifficultyIsEnabled = false
        }
    }
    
    
    //MARK: - Other private functions
    private func setBackgroundColor() {
        setBackgroundColor(setting.backgroundColor)
    }
    
//        Maybe create number of points for corner radius in model
    private func setupUI() {
        // Set buttons corner radius
        saveButton.layer.cornerRadius = 10
        
        for colorButton in colorButtons {
            colorButton.layer.cornerRadius = 10
        }
        
        // Set font size
        for colorButton in colorButtons {
            colorButton.titleLabel?.font = .systemFont(ofSize: colorButton.layer.bounds.height / 5)
        }
    }
    
    
}
