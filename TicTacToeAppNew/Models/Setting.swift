//
//  Setting.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

struct Setting {
    var backgroundColor: ThemeColor
    var gameMode: GameMode
    var computer: CompSetting
    var lowPower: Bool
}


enum GameMode {
    case person
    case computer
}

struct CompSetting {
    var manualDifficultyLevel: Float
    var autoDifficultyLevel: Float
    var autoDifficultyIsEnabled: Bool
    
}


enum ThemeColor: Int, CaseIterable {
    
    case gray = 0
    case blue = 1
    case brown = 2
    case orange = 3
    
}
