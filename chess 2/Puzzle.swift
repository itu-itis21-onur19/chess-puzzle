//
//  Puzzle.swift
//  chess 2
//
//  Created by Çiğdem Onur on 23.05.2025.
//

import Foundation

struct Puzzle: Hashable {
    let FEN: String
    let move: String
    
    let theme: Theme
    let type: PuzzleType = .ai
    
    static func random(theme: Theme? = nil) -> Puzzle {
        return Puzzle.all.filter({
            theme == nil ||
            $0.theme == theme
        }).randomElement()!
    }

}
