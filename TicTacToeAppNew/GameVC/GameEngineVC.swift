//
//  GameEngineVC.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 26.01.2023.
//

import UIKit


extension GameViewController {
    
    //MARK: - Public functions for GameViewController
    func loadGameAction() {
        displayText(getIngameText())
    }
    
    func appearGameAction() {
        switch gameInfo.gameStatus {
            
        case .notStarted, .inGame:
            break
        case .win:
            colorWinButtons()
        case .draw:
            colorAllButtons(toColor: .gray)
        }
    }
    
    func gameLogicAction(forButton button: UIButton) {
        gameInfo.currentMove += 1
        
        changeGameStatus()
        changeSelectedButton(button)
        findCurrentButtonNumber(fromButton: button)
        addMoveToHistory()
        checkForWinner()
        checkForDraw()
        updateResultsCount()
        
        endMoveActions()
    }
    
    func restartGameLogic() {
        gameInfo.currentMove = 0
        
        gameInfo.gameStatus = .notStarted
        changeCurrentSign()
        colorAllButtons(toColor: .black)
        
        generateFeedback(withHapticType: .heavy)
        
        activateButtons()
        resetWinPattern()
        resetMoveHistory()
        
        displayText(getIngameText())
    }
    
    
    
    //MARK: - Main Game logic private functions
    private func changeGameStatus() {
        if gameInfo.currentMove == 1 {
            gameInfo.gameStatus = .inGame
        }
    }
    
    private func changeSelectedButton(_ button: UIButton) {
        button.setTitle(gameInfo.currentSign.rawValue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: button.layer.bounds.height)
        button.isEnabled = false
    }
    
    private func findCurrentButtonNumber(fromButton sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            if sender == button {
                gameInfo.currentButtonNumber = index
                return
            }
        }
    }
    
    private func addMoveToHistory() {
        var doneMoves = gameInfo.movesHistory[gameInfo.currentSign]
        doneMoves?.insert(gameInfo.currentButtonNumber)
        
        gameInfo.movesHistory[gameInfo.currentSign] = doneMoves
    }
    
    private func checkForWinner() {
        guard gameInfo.currentMove >= gameRules.minimumMoveToWin else { return }
        
        for pattern in gameRules.winPatterns {
            if pattern.isSubset(of: gameInfo.movesHistory[gameInfo.currentSign] ?? [0]) {
                gameInfo.winner = gameInfo.currentSign
                gameInfo.gameStatus = .win
                gameInfo.currentWinPattern = pattern
                return
            }
        }
    }
    
    private func checkForDraw() {
        if gameInfo.currentMove == 9 && gameInfo.gameStatus == .inGame {
            gameInfo.gameStatus = .draw
        }
    }
    
    private func updateResultsCount() {
        if gameInfo.gameStatus == .win {
            switch gameInfo.currentSign {
            case .o:
                gameInfo.resultCount.o += 1
            case .x:
                gameInfo.resultCount.x += 1
            }
        } else if gameInfo.gameStatus == .draw {
            gameInfo.resultCount.draw += 1
        }
    }
    
    //MARK: Game ending actions private function
    private func endMoveActions() {
        switch gameInfo.gameStatus {
            
        case .notStarted:
            break
            
        case .inGame:
            generateFeedback(withHapticType: .light)
            changeCurrentSign()
            displayText(getIngameText())
            
        case .win:
            disactivateButtons()
            colorWinButtons()
            updateWinLabels()
            displayText(getWinText())
            generateFeedback(withHapticType: .success)
            
        case .draw:
            disactivateButtons()
            colorAllButtons(toColor: .gray)
            updateDrawLabels()
            displayText(getDrawText())
            generateFeedback(withHapticType: .warning)
            
        }
    }
    
    //MARK: - Switching buttons private functions
    private func activateButtons() {
        for button in buttons {
            button.setTitle(" ", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.isEnabled = true
        }
    }
    
    private func disactivateButtons() {
        buttons.forEach{ $0.isEnabled = false }
    }
    
    //MARK: - Reset Data private functions
    private func resetWinPattern() {
        gameInfo.currentWinPattern = []
    }
    
    private func resetMoveHistory() {
        gameInfo.movesHistory[.x] = []
        gameInfo.movesHistory[.o] = []
    }
    
    //MARK: - Change buttons color private functions
    private func colorAllButtons(toColor color: UIColor) {
        buttons.forEach { $0.setTitleColor(color, for: .normal) }
    }
    
    private func colorWinButtons() {
        gameInfo.currentWinPattern.forEach {
            buttons[$0].setTitleColor(.green, for: .normal)
        }
    }
    
    //MARK: - Change labels private functions
    private func updateWinLabels() {
        xWinsLabel.text = "X: \(gameInfo.resultCount.x)"
        oWinsLabel.text = "O: \(gameInfo.resultCount.o)"
    }
    
    private func updateDrawLabels() {
        drawsLabel.text = "Draws: \(gameInfo.resultCount.draw)"
    }
    
    private func displayText(_ text: String) {
        currentMoveLabel.text = text
    }
    
    private func getIngameText() -> String {
        "Current move - \(gameInfo.currentSign.rawValue)"
    }
    
    private func getDrawText() -> String {
        "It's a draw!"
    }
    
    private func getWinText() -> String {
        "\(gameInfo.currentSign.rawValue) Won!"
    }
    
    //MARK: - Other game logic private functions
    private func changeCurrentSign() {
        if gameInfo.currentSign == .x {
            gameInfo.currentSign = .o
        } else {
            gameInfo.currentSign = .x
        }
    }
    
    
    
}
