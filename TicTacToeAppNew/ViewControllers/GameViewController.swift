//
//  ViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var currentMoveLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var restartButton: UIButton!
    
    @IBOutlet var xWinsLabel: UILabel!
    @IBOutlet var oWinsLabel: UILabel!
    @IBOutlet var drawsLabel: UILabel!
    
    
    private var gameInfo = Game(gameStatus: .notStarted,
                            currentMove: 1,
                            currentSign: .x,
                            resultCount: Count(o: 0,
                                             x: 0,
                                             draw: 0),
                            currentWinPattern: [])
    
    private var gameRules = GameDataManager.shared
    
    private var hapticType = TapticEngine.light
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            button.layer.cornerRadius = 10
        }
        
        restartButton.layer.cornerRadius = 10
        
        displayCurrentMoveText()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resizeDoneButton()
        
        colorFigures()
        
        
    }
    
    
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        hapticType = .light
        
        checkGameStart()
        setupMove(forButton: sender)
        
        gameInfo.currentMove += 1
        
        setupSign()
        displayCurrentMoveText()
        
        checkForWinner()
        showDrawMessage()
        
        colorFigures()
        updateCountsLabels()
        
        
        generateFeedback(withHapticType: hapticType)
    }
    
    @IBAction func restartButtonPressed() {
        gameInfo.currentMove = 1
        gameInfo.gameStatus = .notStarted
        
        setupSign()
        displayCurrentMoveText()
        
        resetButtons()
        resetPatterns()
//        cleanWinNumbers()
        
        generateFeedback(withHapticType: .heavy)
    }
    
    
    // MARK: - Functions for Play Buttons
    
    private func checkGameStart() {
        if gameInfo.currentMove == 2 {
            gameInfo.gameStatus = .inGame
        }
    }
    
    private func setupMove(forButton button: UIButton) {
        button.setTitle(gameInfo.currentSign.rawValue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: button.layer.bounds.height)
        button.isEnabled = false
    }
    
    
    
    
    private func setupSign() {
        if gameInfo.currentSign == .x {
            gameInfo.currentSign = .o
        } else {
            gameInfo.currentSign = .x
        }
    }
    
    
    
    
    private func displayCurrentMoveText() {
        currentMoveLabel.text = "Current move - \(gameInfo.currentSign.rawValue)"
    }
    
    
    
    
    private func checkForWinner() {
        
//        print("-------\n\(buttons[0].titleLabel?.text ?? "-") \(buttons[1].titleLabel?.text ?? "-") \(buttons[2].titleLabel?.text ?? "-")\n\(buttons[3].titleLabel?.text ?? "-") \(buttons[4].titleLabel?.text ?? "-") \(buttons[5].titleLabel?.text ?? "-")\n\(buttons[6].titleLabel?.text ?? "-") \(buttons[7].titleLabel?.text ?? "-") \(buttons[8].titleLabel?.text ?? "-")\n-------")

        guard gameInfo.currentMove >= 6 else { return }

        for (numbers, state) in gameRules.winPatterns {
            
            guard state == .notChecked else { continue }
            
            guard checkCombination(ofNumbers: numbers) else { continue }
            
            findWinner()
            disactivateGame()
            return
            
        }
    }
    
    
    private func findWinner() {
        for (numbers, state) in gameRules.winPatterns {
            if state == .win {
                for number in numbers {
//                    gameInfo.currentWinPattern = []
                    gameInfo.currentWinPattern.append(number)
//                    print("appended \(number) to win patterns")
//                    print("My appended numbers are \(gameInfo.currentWinPattern)")
                    
                    
                    gameInfo.gameStatus = .win
                }
                return
            }
        }
        
    }
    
    private func colorFigures() {
        if gameInfo.gameStatus == .draw {
            
            for button in buttons {
                button.setTitleColor(.gray, for: .normal)
            }
            
        } else if gameInfo.gameStatus == .win {
//            print("In win pattern for coloring figures")
//                print("Can cast numbers")
//            print(gameInfo.currentWinPattern)
                
            for number in gameInfo.currentWinPattern {
                    buttons[number].setTitleColor(.green, for: .normal)
                }
        } else {
            
            for button in buttons {
                button.setTitleColor(.black, for: .normal)
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
    
    
    private func countWin() {
        
        if gameInfo.currentSign == .x {
            gameInfo.resultCount.o += 1
        } else {
            gameInfo.resultCount.x += 1
        }
        
        hapticType = .success
    }
    
    
    private func updateLabels() {
        setupSign()
        currentMoveLabel.text = "\(gameInfo.currentSign.rawValue) Won!"
        
        
    }
    
//    private func cleanWinNumbers() {
//        gameInfo.currentWinPattern = []
//    }
    
    
    
    private func showDrawMessage() {
        var itIsDraw = true
        
        for (_, pattern) in gameRules.winPatterns {
            if pattern == .win {
                itIsDraw = false
            }
            
        }
        
        if gameInfo.currentMove == 10 && itIsDraw{
            currentMoveLabel.text = "It's a draw!"
            
            gameInfo.gameStatus = .draw
            
            gameInfo.resultCount.draw += 1
            
            hapticType = .warning
            
            
            
        }
    }
    
    
    private func updateCountsLabels() {
        if gameInfo.gameStatus == .win {
            xWinsLabel.text = "X: \(gameInfo.resultCount.x)"
            oWinsLabel.text = "O: \(gameInfo.resultCount.o)"
        } else if gameInfo.gameStatus == .draw {
            drawsLabel.text = "Draws: \(gameInfo.resultCount.draw)"
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

        }

        if texts.count == 3 {
            if (texts[0] == texts[1]) && (texts[2] == texts[1]) {
//                print(numbers)
//                print(texts)
                gameRules.winPatterns[numbers] = .win
                return true
            }
        }
        
        return false
    }
    
    private func resetPatterns() {
        for (numbers, _) in gameRules.winPatterns {
            gameRules.winPatterns[numbers] = .notChecked
        }
        
        gameInfo.currentWinPattern = []
    }
    
    private func resetButtons() {
        for button in buttons {
            button.setTitle(" ", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.isEnabled = true
        }
    }
    
    
    
   
    
    
    
    private func resizeDoneButton() {
        restartButton.titleLabel?.font = .systemFont(ofSize: buttons[0].layer.bounds.height / 4)
    }
    
    
    
}


