//
//  AnimalType.swift
//  PersonalityQuiz
//
//  Created by Nune Melikyan on 04.09.22.
//

import Foundation

enum AnimalType: Character {
  case dog = "🐶"
  case cat = "🐱"
  case pig = "🐷"
  case frog = "🐸"

  var definition: String {
    switch self {
    case .dog:
        return "You are incredibly outgoing. You surround yourself with the people you love."
    case .cat:
        return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
    case .pig:
      return "You love everything that’s soft. You are healthy and full of energy."
    case .frog:
      return
        "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
    }
  }
}
