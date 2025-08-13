//
//  State.swift
//  chess 2
//
//  Created by Çiğdem Onur on 26.05.2025.
//

import Foundation
import SwiftUI

enum AppState {
    case welcome
    case pickType
    case pickLevel
    case pickTheme
    case puzzle
}

enum PuzzleState {
    case start
    case wrong
    case solution
    case correct
}

enum Theme: CaseIterable {
    case captureTheDefender
    case discoveredAttack
    case doubleCheck
    case kingHunt
    case fork
    case pin
    case skewer
    case trappedPiece
    case mate
    case endgame
    case unknown

    var text: String {
        switch self {
        case .captureTheDefender: "Capture the Defender"
        case .discoveredAttack: "Discovered Attack"
        case .doubleCheck: "Double Check"
        case .kingHunt: "King Hunt"
        case .fork: "Fork"
        case .pin: "Pin"
        case .skewer: "Skewer"
        case .trappedPiece: "Trapped Piece"
        case .mate: "Mate"
        case .endgame: "Endgame"
        case .unknown:
            "Unknown"
        }
    }

    var color: Color {
        switch self {
        case .captureTheDefender: .blue
        case .discoveredAttack: .indigo
        case .doubleCheck: .orange
        case .kingHunt: .red
        case .fork: .mint
        case .pin: .teal
        case .skewer: .yellow
        case .trappedPiece: .pink
        case .mate: .purple
        case .endgame: .cyan
        case .unknown:
                .gray
        }
    }
}

enum PuzzleType {
    case regular, generated
}

enum ChessColor {
    case white
    case black
    
    var text: String {
        switch self {
        case .white:
            return "White"
        case .black:
            return "Black"
        }
    }
}
