//
//  Game.swift
//  TicTacToeAppNew
//
//  Created by Sergey Kosichkin on 15.01.2023.
//

struct Game {
    var gameStatus: GameStatus
    var currentMove: Int
    var currentSign: GameSign
    
    var resultCount: Count
    var currentWinPattern: [Int]
    
}

struct Count {
    var o: Int
    var x: Int
    var draw: Int
}

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

