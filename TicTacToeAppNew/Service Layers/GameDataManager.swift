//
//  DataManager.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//


class GameDataManager {

    static let shared = GameDataManager()
    
    var winPatterns: [[Int] : WinnerState] = [[0, 1, 2] : .notChecked,
                                              [3, 4, 5] : .notChecked,
                                              [6, 7, 8] : .notChecked,
                                              [0, 3, 6] : .notChecked,
                                              [1, 4, 7] : .notChecked,
                                              [2, 5, 8] : .notChecked,
                                              [0, 4, 8] : .notChecked,
                                              [6, 4, 2] : .notChecked]
    
    
    private init() {}
}



class SettingsDataManager {
    static let shared = SettingsDataManager()
    
    let computerParameters = ComputerParameter()
    
    private init() {}
}




enum WinnerState {
    case notChecked
    case failed
    case win
}


struct ComputerParameter {
    var change: [Int : Int] = [0 : 10,
                               40 : 5,
                               60 : 3,
                               78 : 2,
                               90 : 1,
                               100 : 0]
}
