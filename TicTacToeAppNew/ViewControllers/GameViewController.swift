//
//  ViewController.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 14.01.2023.
//

import UIKit

//MARK: - Protocols
protocol SettingsViewControllerDelegate {
    func setNewSettings(from setting: Setting)
}

protocol gameInfoViewControllerDelegate {
    func passDataThrough(from gameInfo: Game)
}



class GameViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var currentMoveLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var restartButton: UIButton!
    
    @IBOutlet var xWinsLabel: UILabel!
    @IBOutlet var oWinsLabel: UILabel!
    @IBOutlet var drawsLabel: UILabel!
    
    
    //MARK: - Public properties
    var gameRules = GameDataManager.shared
    var gameInfo = Game(gameStatus: .notStarted,
                        currentMove: 0,
                        currentSign: .x,
                        currentButtonNumber: nil,
                        movesHistory: [.x : [],
                                       .o : []],
                        winner: nil,
                        resultCount: Count(o: 0,
                                           x: 0,
                                           draw: 0),
                        currentWinPattern: [])
    
    
    //MARK: - Private Properties
    private var setting = Setting(backgroundColor: .gray,
                                  gameMode: .person,
                                  computer: CompSetting(manualDifficultyLevel: 70,
                                                        autoDifficultyLevel: 30,
                                                        autoDifficultyIsEnabled: true))
    
    
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons.forEach{ $0.layer.cornerRadius = 10 }
        restartButton.layer.cornerRadius = 10
        
        loadGameAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeBackgroundColor(to: setting.backgroundColor)
        
        appearGameAction()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.setting = setting
            settingsVC.delegate = self
        }
        if let statVC = segue.destination as? StatisticsViewController {
            statVC.setting = setting
            statVC.gameInfo = gameInfo
            statVC.delegate = self
        }
    }
    
    
    
    //MARK: - IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        gameLogicAction(forButton: sender)
    }
    
    @IBAction func restartButtonPressed() {
        restartGameLogic()
    }
    
    
}



//MARK: - Extensions for protocol delegation
extension GameViewController: SettingsViewControllerDelegate {
    func setNewSettings(from setting: Setting) {
        self.setting = setting
    }
}


extension GameViewController: gameInfoViewControllerDelegate {
    func passDataThrough(from gameInfo: Game) {
        self.gameInfo = gameInfo
        updateCountsLabels()
        restartButtonPressed()
    }
    
    private func updateCountsLabels() {
        xWinsLabel.text = "X: \(gameInfo.resultCount.x)"
        oWinsLabel.text = "O: \(gameInfo.resultCount.o)"
        drawsLabel.text = "Draws: \(gameInfo.resultCount.draw)"
    }
}
