//
//  SurveyView.swift
//  chess 2
//
//  Created by Yasin Onur on 26.05.2025.
//

import SwiftUI

struct Question {
    let text: String
    let answers: [String]
    
    let type: QuestionType
    
    enum QuestionType: String {
        case rate, text
    }
}

struct SurveyView: View {
    let questions = [
        "Did you like the AI-Generated puzzles?",
        "Did you like the AI-Generated puzzles or regular puzzles better?",
        "Did you have any suggestions?"
    ]
    
    var body: some View {
        Text(questions.first!)
    }
}

#Preview {
    SurveyView()
}
