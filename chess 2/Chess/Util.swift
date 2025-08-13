//
//  Util.swift
//  chess 5
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation

// MARK: - Character Extensions

extension Character {
    /// Returns true if the character is a digit (0-9).
    var isDigit: Bool {
        return self >= "0" && self <= "9"
    }

    /// Returns true if the character is an alphabetic letter.
    var isAlpha: Bool {
        return self.isLetter
    }
}

// MARK: - String Extensions

extension String {
    /// Returns the character at the given integer index.
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    /// Returns a substring from `from` (inclusive) to `to` (exclusive) indices.
    func slice(from: Int, to: Int) -> String {
        guard from >= 0, to <= count, from < to else { return "" }
        let start = index(startIndex, offsetBy: from)
        let end = index(startIndex, offsetBy: to)
        return String(self[start..<end])
    }

    /// Attempts to convert the string to an Int, returns nil if conversion fails.
    func toIntOrNil() -> Int? {
        return Int(self)
    }
}

// MARK: - Clamp Function

/// Clamps a comparable value between a minimum and maximum.
func clamp<T: Comparable>(_ value: T, min minValue: T, max maxValue: T) -> T {
    return max(min(value, maxValue), minValue)
}
