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
    let type: PuzzleType = .regular
    
    static func random(type: PuzzleType, theme: Theme? = nil) -> Puzzle {
        let list = type == .regular ? Puzzle.regular : Puzzle.generated
        
        return list.filter({
            theme == nil ||
            $0.theme == theme
        }).randomElement()!
    }

}
