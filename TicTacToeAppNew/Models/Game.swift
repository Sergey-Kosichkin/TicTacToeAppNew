//
//  Game.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

//MARK: - Main Game model structure
struct Game {
    var gameStatus: GameStatus
    var currentMove: Int
    var currentSign: GameSign
    
    var currentButtonNumber: Int!
    var movesHistory: [GameSign : Set<Int>]
    var winner: GameSign?
    
    var resultCount: Count
    var currentWinPattern: Set<Int>
}


//MARK: - Supporting structures
struct Count {
    var o: Int
    var x: Int
    var draw: Int
}


//MARK: - Supporting enumerations
enum GameStatus {
    case notStarted
    case inGame
    case win
    case draw
}

enum GameSign: String {
    case o = "O"
    case x = "X"
}


