//
//  Question.swift
//  Quizzler
//
//  Created by Катя on 20.06.2024.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}
