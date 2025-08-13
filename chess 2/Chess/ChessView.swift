//
//  ContentView.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import SwiftUI

struct ChessView: View {
    @EnvironmentObject var viewModel: ChessViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach((0..<8).reversed(), id: \.self) { rank in
                HStack(spacing: 0) {
                    ForEach(0..<8, id: \.self) { file in
                        let square = Square(file: file, rank: rank)!
                        ZStack {
                            Rectangle()
                                .fill((square.file + square.rank) % 2 == 0 ? .white : .gray)
                                .fill(
                                    viewModel.selectedSquare == square ?
                                        .green.opacity(0.5) :
                                        viewModel.from == square || viewModel.to == square ?
                                        .red.opacity(0.5) :
                                        viewModel.legalTargets.contains(where: { $0.index == square.index }) ?
                                        .yellow.opacity(0.5) :
                                            .clear)
                            if let piece = viewModel.piece(at: square) {
                                Text(symbol(for: piece))
                                    .font(.system(size: 36))
                            }
                        }
                        .frame(width: 44, height: 44)
                        .onTapGesture {
                            viewModel.select(square: square)
                        }
                    }
                }
            }
        }
    }

    func symbol(for piece: Piece) -> String {
        let symbols: [Role: (String, String)] = [
            .pawn: ("♙", "♟︎"), .rook: ("♖", "♜"), .knight: ("♘", "♞"),
            .bishop: ("♗", "♝"), .queen: ("♕", "♛"), .king: ("♔", "♚")
        ]
        return piece.color == .white ? symbols[piece.role]!.0 : symbols[piece.role]!.1
    }
}

#Preview {
    ChessView()
}
