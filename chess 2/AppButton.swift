//
//  AppButton.swift
//  chess 2
//
//  Created by Çiğdem Onur on 4.08.2025.
//

import Foundation
import SwiftUI

struct AppButton: View {
    let text: String
    let colors: [Color]
    
    let short: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, short ? 8 : 12)
                .background(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.horizontal)
    }
}
