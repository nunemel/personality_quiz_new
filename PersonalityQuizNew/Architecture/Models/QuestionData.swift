//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Nune Melikyan on 04.09.22.
//

import Foundation

struct QuestionData {
  static var questions: [Question] = [
    Question(
      text: "Which food do you like the most?",
      type: .single,
      answers: [
        Answer(text: "Steak", type: .dog),
        Answer(text: "Fish", type: .cat),
        Answer(text: "Carrots", type: .pig),
        Answer(text: "Corn", type: .frog),
        Answer(text: "Eggs", type: .dog),
        Answer(text: "Milk", type: .frog),
        Answer(text: "Sausage", type: .dog)
      ]
    ),
    Question(
      text: "Which activities do you enjoy?",
      type: .multiple,
      answers: [
        Answer(text: "Swimming", type: .pig),
        Answer(text: "Sleeping", type: .cat),
        Answer(text: "Cuddling", type: .frog),
        Answer(text: "Eating", type: .dog),
        Answer(text: "Cycling", type: .pig)
      ]
    ),
    Question(
      text: "How much do you enjoy car rides?",
      type: .ranged,
      answers: [
        Answer(text: "I dislike them", type: .cat),
        Answer(text: "I get a little nervous", type: .pig),
        Answer(text: "I barely notice them", type: .frog),
        Answer(text: "I love them", type: .dog)
      ]
    )
  ]
}
