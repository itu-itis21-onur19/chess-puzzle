//
//  Types.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

enum PieceColor: String, Equatable {
    case white = "White"
    case black = "Black"
    
    var opposite: PieceColor {
        self == .white ? .black : .white
    }
    
    var text: String { rawValue }
}

enum Role: String, Equatable {
    case king, queen, rook, bishop, knight, pawn
}

struct Piece: Equatable {
    let role: Role
    let color: PieceColor
}
