//
//  Puzzle.swift
//  chess 2
//
//  Created by Yasin Onur on 23.05.2025.
//

import Foundation

struct Puzzle: Hashable {
    let FEN: String
    let move: String
    
    let theme: Theme
    let type: PuzzleType = .ai
    
    static func random() -> Puzzle {
        let puzzles = [
            Puzzle(FEN: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", move: "e3", theme: .doubleCheck),
        ]
        
        return puzzles.randomElement()!
    }

}
