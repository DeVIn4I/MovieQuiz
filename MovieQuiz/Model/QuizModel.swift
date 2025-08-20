//
//  QuizModel.swift
//  MovieQuiz
//
//  Created by Razumov Pavel on 20.08.2025.
//

import UIKit

struct QuizStepViewModel {
    let question: String
    let questionNumber: String
    let image: UIImage
}

struct QuizResultsViewModel {
    let title: String
    let text: String
    let buttonText: String
}

struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}
