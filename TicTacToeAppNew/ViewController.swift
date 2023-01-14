//
//  ViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var currentMoveLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var xWinsLabel: UILabel!
    @IBOutlet var oWinsLabel: UILabel!
    
    private var currentMove = 1
    private var sign = "X"
    private var oWinCount = 0
    private var xWinCount = 0
    
    private var i = 5
    
    private var winPatterns: [[Int] : WinnerState] = [[0, 1, 2] : .notChecked,
                                                      [3, 4, 5] : .notChecked,
                                                      [6, 7, 8] : .notChecked,
                                                      [0, 3, 6] : .notChecked,
                                                      [1, 4, 7] : .notChecked,
                                                      [2, 5, 8] : .notChecked,
                                                      [0, 4, 8] : .notChecked,
                                                      [6, 4, 2] : .notChecked]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
        
        resetButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        resetButton.layer.cornerRadius = 10
        
        displayCurrentMoveText()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resizeDoneButton()
        
        for button in buttons {
//            button.setTitle(" ", for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: button.layer.bounds.height)
            button.setTitleColor(.black, for: .normal)
        }
        
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        i = 4
        
        setupMove(forButton: sender)
        
        currentMove += 1
        
        setupSign()
        displayCurrentMoveText()
        
//        print(currentMove)
        checkForWinner()
        
        showDrawMessage()
        
        
    }
    
    @IBAction func resetButtonPressed() {
        i = 1
        
        currentMove = 1
        setupSign()
        displayCurrentMoveText()
        
        resetButtons()
        resetPatterns()
        
    
//        resizeDoneButton()
        
        
        
    }
    
    private func checkForWinner() {
        
//        print("-------\n\(buttons[0].titleLabel?.text ?? "-") \(buttons[1].titleLabel?.text ?? "-") \(buttons[2].titleLabel?.text ?? "-")\n\(buttons[3].titleLabel?.text ?? "-") \(buttons[4].titleLabel?.text ?? "-") \(buttons[5].titleLabel?.text ?? "-")\n\(buttons[6].titleLabel?.text ?? "-") \(buttons[7].titleLabel?.text ?? "-") \(buttons[8].titleLabel?.text ?? "-")\n-------")

        guard currentMove >= 6 else { return }

        for (numbers, state) in winPatterns {
            
            guard state == .notChecked else { continue }
            
            guard checkCombination(ofNumbers: numbers) else { continue }
            
            colorWinner()
            disactivateGame()
            return
            
        }
    }
    
    private func checkCombination(ofNumbers numbers: [Int]) -> Bool {
        var texts: [String] = []

        for number in numbers {
            guard let buttonNumber = buttons[number].titleLabel?.text  else {
                return false
            }

            if buttonNumber == " " {
                return false
            } else {
                texts.append(buttonNumber)
            }

//            print(buttonNumber)
        }

        if texts.count == 3 {
            if (texts[0] == texts[1]) && (texts[2] == texts[1]) {
                print(numbers)
                print(texts)
                winPatterns[numbers] = .win
                return true
            }
        }
        
        return false
    }
    
    
    private func colorWinner() {
        for (numbers, state) in winPatterns {
            if state == .win {
                for number in numbers {
                    buttons[number].setTitleColor(.green, for: .normal)
                }
                return
            }
        }
        
    }
    
    private func disactivateGame() {
        for button in buttons {
            button.isEnabled = false
        }
        countWin()
        updateLabels()
    }
    
    private func resetPatterns() {
        for (numbers, _) in winPatterns {
            winPatterns[numbers] = .notChecked
        }
    }
    
    private func resetButtons() {
        for button in buttons {
            button.setTitle(" ", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.isEnabled = true
        }
    }
    
    private func setupSign() {
        if sign == "X" {
            sign = "O"
        } else {
            sign = "X"
        }
    }
    
    private func setupMove(forButton button: UIButton) {
        button.setTitle(sign, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: button.layer.bounds.height)
        button.isEnabled = false
    }
    
    private func displayCurrentMoveText() {
        currentMoveLabel.text = "Current move - \(sign)"
    }
    
    private func countWin() {
        
        if sign == "X" {
            oWinCount += 1
        } else {
            xWinCount += 1
        }
        
        i = 2
    }
    
    private func updateLabels() {
        setupSign()
        currentMoveLabel.text = "\(sign) Won!"
        xWinsLabel.text = "X: \(xWinCount)"
        oWinsLabel.text = "O: \(oWinCount)"
    }
    
    private func resizeDoneButton() {
        resetButton.titleLabel?.font = .systemFont(ofSize: buttons[0].layer.bounds.height / 4)
    }
    
    private func showDrawMessage() {
        var itIsDraw = true
        
        for (_, pattern) in winPatterns {
            if pattern == .win {
                itIsDraw = false
            }
        }
        
        if currentMove == 10 && itIsDraw{
            currentMoveLabel.text = "It's a draw!"
        }
    }
    
}

extension ViewController {
    enum WinnerState {
        case notChecked
        case failed
        case win
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
