//
//  Setting.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

struct Setting {
    var backgroundColor: UIColor
    var gameMode: GameMode
    var computerSettings: ComputerSettings
}


enum GameMode {
    case person
    case computer
}

struct ComputerSettings {
    var manualDifficultyLevel: Int
    var autoDifficultyLevel: Int
    var autoDifficultyStatus: State
    
}


enum State {
    case enabled
    case disabled
}
