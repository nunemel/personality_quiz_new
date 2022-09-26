//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Nune Melikyan on 04.09.22.
//

import UIKit

final class ResultsViewController: UIViewController {

  @IBOutlet private var resultAnswerLabel: UILabel!
  @IBOutlet private var resultDefinitionLabel: UILabel!

  private var responses: [Answer]

  init?(
    coder: NSCoder,
    responses: [Answer]
  ) {
    self.responses = responses
    super.init(coder: coder)
  }

  required init?(
    coder: NSCoder
  ) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.hidesBackButton = true
    calculatePersonalityResult()
  }

  func calculatePersonalityResult() {
    let frequencyOfAnswers = responses.reduce(into: [:]) { (counts, answer) in
      counts[answer.type, default: 0] += 1
    }

    let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key

    resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
    resultDefinitionLabel.text = mostCommonAnswer.definition
  }
}
