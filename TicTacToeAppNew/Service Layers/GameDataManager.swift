//
//  DataManager.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

import UIKit

class GameDataManager {

    static let shared = GameDataManager()
    
//    var winPatterns = [[0, 1, 2],
//                                [3, 4, 5],
//                                [6, 7, 8],
//                                [0, 3, 6],
//                                [1, 4, 7],
//                                [2, 5, 8],
//                                [0, 4, 8],
//                       [6, 4, 2]]
    
    let winPatterns: Set<Set<Int>> = [[0, 1, 2],
                                     [3, 4, 5],
                                     [6, 7, 8],
                                     [0, 3, 6],
                                     [1, 4, 7],
                                     [2, 5, 8],
                                     [0, 4, 8],
                                     [6, 4, 2]]
    
    let minimumMoveToWin = 5
    
    
    private init() {}
}



class SettingsDataManager {
    static let shared = SettingsDataManager()
    
    let computerParameters = ComputerParameter()
    
    let color: [UIColor] = [.systemGray,
                            .systemTeal,
                            .systemBrown,
                            .systemOrange]
    
    
    private init() {}
}



struct ComputerParameter {
    var change: [Int : Int] = [0 : 10,
                               40 : 5,
                               60 : 3,
                               78 : 2,
                               90 : 1,
                               100 : 0]
}



