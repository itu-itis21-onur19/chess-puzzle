//
//  Attacks.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

struct Attack {
    static func knightAttacks(from square: Square) -> [Square] {
        let offsets = [
            (2, 1), (1, 2), (-1, 2), (-2, 1),
            (-2, -1), (-1, -2), (1, -2), (2, -1)
        ]
        return offsets.compactMap { dx, dy in
            let file = square.file + dx
            let rank = square.rank + dy
            guard (0..<8).contains(file), (0..<8).contains(rank) else { return nil }
            return Square(file: file, rank: rank)
        }
    }
    
    static func kingAttacks(from square: Square) -> [Square] {
        let offsets = [
            (1, 0), (1, 1), (0, 1), (-1, 1),
            (-1, 0), (-1, -1), (0, -1), (1, -1)
        ]
        return offsets.compactMap { dx, dy in
            let file = square.file + dx
            let rank = square.rank + dy
            guard (0..<8).contains(file), (0..<8).contains(rank) else { return nil }
            return Square(file: file, rank: rank)
        }
    }
    
    static func pawnAttacks(from square: Square, color: PieceColor) -> [Square] {
        let rankOffset = color == .white ? 1 : -1
        let files = [square.file - 1, square.file + 1]
        return files.compactMap { f in
            guard (0..<8).contains(f) else { return nil }
            let r = square.rank + rankOffset
            guard (0..<8).contains(r) else { return nil }
            return Square(file: f, rank: r)
        }
    }
    
    static func bishopAttacks(board: Board, from square: Square) -> [Square] {
        let directions = [(1,1), (-1,1), (-1,-1), (1,-1)]
        return slideAttacks(board: board, from: square, directions: directions)
    }
    
    static func rookAttacks(board: Board, from square: Square) -> [Square] {
        let directions = [(1,0), (-1,0), (0,1), (0,-1)]
        return slideAttacks(board: board, from: square, directions: directions)
    }
    
    static func queenAttacks(board: Board, from square: Square) -> [Square] {
        return bishopAttacks(board: board, from: square) + rookAttacks(board: board, from: square)
    }
    
    private static func slideAttacks(board: Board, from square: Square, directions: [(Int, Int)]) -> [Square] {
        var result: [Square] = []
        guard let piece = board[square] else { return result }
        
        for (dx, dy) in directions {
            var x = square.file + dx
            var y = square.rank + dy
            while (0..<8).contains(x) && (0..<8).contains(y) {
                guard let target = Square(file: x, rank: y) else { break }
                if let occupying = board[target] {
                    if occupying.color != piece.color {
                        result.append(target)
                    }
                    break
                } else {
                    result.append(target)
                }
                x += dx
                y += dy
            }
        }
        return result
    }
}
