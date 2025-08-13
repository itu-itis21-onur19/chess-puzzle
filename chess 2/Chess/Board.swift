//
//  Board.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

struct Square: Hashable {
    let file: Int  // 0 = 'a', 1 = 'b', ..., 7 = 'h'
    let rank: Int  // 0 = rank 1, ..., 7 = rank 8

    init?(index: Int) {
        guard (0..<64).contains(index) else { return nil }
        self.file = index % 8
        self.rank = index / 8
    }
    
    init?(file: Int, rank: Int) {
        guard (0..<8).contains(file), (0..<8).contains(rank) else { return nil }
        self.file = file
        self.rank = rank
    }

    var index: Int {
        return rank * 8 + file
    }

    var notation: String {
        let fileChar = Character(UnicodeScalar(file + 97)!)  // 'a' = 97
        return "\(fileChar)\(rank + 1)"
    }

    init?(notation: String) {
        guard notation.count == 2,
              let fileChar = notation.first,
              let fileVal = fileChar.asciiValue,
              let rankVal = Int(String(notation.last!)) else {
            return nil
        }

        self.file = Int(fileVal) - 97
        self.rank = rankVal - 1

        guard (0..<8).contains(file), (0..<8).contains(rank) else {
            return nil
        }
    }
}

struct Board: Equatable {
    private var pieces: [Int: Piece] = [:]  // key = 0...63 (square index)

    subscript(square: Square) -> Piece? {
        get { pieces[square.index] }
        set { pieces[square.index] = newValue }
    }

    mutating func clear() {
        pieces.removeAll()
    }

    func allPieces() -> [(Square, Piece)] {
        return pieces.compactMap { (idx, piece) in
            guard let sq = Square(index: idx) else { return nil }
            return (sq, piece)
        }
    }
}
