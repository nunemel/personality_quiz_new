//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Nune Melikyan on 04.09.22.
//

import UIKit

final class QuestionViewController: UIViewController {

  private var questions: [Question] = []
  private var questionIndex = 0
  private var myButtons: [String] = []
  private var myLabels: [String] = []
  private var mySwitches: [String] = []

  @IBOutlet private var questionLabel: UILabel!
  @IBOutlet private var singleStackView: UIStackView!
  @IBOutlet private var multipleStackView: UIStackView!
  @IBOutlet private var rangedStackView: UIStackView!
  @IBOutlet private var rangedLabel1: UILabel!
  @IBOutlet private var rangedLabel2: UILabel!
  @IBOutlet private var questionProgressView: UIProgressView!
  @IBOutlet private var rangedSlider: UISlider!

  @IBOutlet weak private var submitMultipleButton: UIButton!

  private var currentQuestion: Question?
  private var answersChosen: [Answer] = []
  private var currentAnswers: [Answer] = []

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    questions = QuestionData.questions.shuffled()
    currentQuestion = questions[questionIndex]
    currentAnswers = currentQuestion!.answers.shuffled()
    updateUI()
  }

  // MARK: - Update UI
  func updateUI() {
    singleStackView.isHidden = true
    multipleStackView.isHidden = true
    rangedStackView.isHidden = true

    navigationItem.title = "Question #\(questionIndex + 1)"
    currentQuestion = questions[questionIndex]
    currentAnswers = currentQuestion!.answers.shuffled()

    let totalProgress = Float(questionIndex) / Float(questions.count)
    questionLabel.text = currentQuestion!.text
    questionProgressView.setProgress(totalProgress, animated: true)

    switch currentQuestion!.type {
    case .single:
      updateSingleStack(using: currentAnswers)
    case .multiple:
      updateMutipleStack(using: currentAnswers)
    case .ranged:
      updateRangedStack(using: currentAnswers)
    }
  }

  func updateSingleStack(using answers: [Answer]) {
    singleStackView.isHidden = false

    for index in 0...answers.count - 1 {
      myButtons.append("\(answers[index].text)")
    }

    for (index, element) in myButtons.enumerated() {
      let oneBtn: UIButton = {
        let button = UIButton()
        button.setTitle(element, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.tag = index
        button.addTarget(self, action: #selector(singleAnswerButtonPressed), for: .touchUpInside)

        return button
      }()

      singleStackView.addArrangedSubview(oneBtn)
    }
  }

  func updateMutipleStack(using answers: [Answer]) {
    multipleStackView.isHidden = false

    // MARK: - Labels
    for index in 0...answers.count - 1 {
      myLabels.append("\(answers[index].text)")
    }

    for (index, element) in myLabels.enumerated() {
      let oneStackView: UIStackView = {
        let label = UILabel()
        let switche = UISwitch()

        switche.tag = index
        switche.addTarget(self, action: #selector(onSwitchValueChanged(_:)), for: .valueChanged)
        label.text = element
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.tag = index

        // MARK: - StackView horizontal
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 28
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        multipleStackView.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(switche)

        return stackView
      }()

      multipleStackView.addArrangedSubview(oneStackView)
    }
  }

  func updateRangedStack(using answers: [Answer]) {
    rangedStackView.isHidden = false
    rangedLabel1.text = answers.first?.text
    rangedLabel2.text = answers.last?.text
    rangedSlider.setValue(0.5, animated: false)
  }

  // MARK: - Actions
  @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
    return ResultsViewController(coder: coder, responses: answersChosen)
  }

  @IBAction func multipleAnswerButtonPressed() {
    nextQuestion()
  }

  @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
    answersChosen.append(currentAnswers[sender.tag])

    nextQuestion()
  }

  @IBAction func rangedAnswerButtonPressed() {
    currentQuestion = questions[questionIndex]

    let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
    answersChosen.append(currentAnswers[index])

    nextQuestion()
  }

  @objc private func onSwitchValueChanged(_ switc: UISwitch) {
    if switc.isOn {
      answersChosen.append(currentAnswers[switc.tag])
    }
  }

  // MARK: - Next question
  func nextQuestion() {
    questionIndex += 1
    if questionIndex < questions.count {
      updateUI()
    } else {
      performSegue(withIdentifier: "Results", sender: nil)
    }
  }
}
