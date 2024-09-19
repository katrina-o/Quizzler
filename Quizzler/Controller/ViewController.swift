//
//  ViewController.swift
//  Quizzler
//
//  Created by Катя on 19.06.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    var quizBrain = QuizBrain()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .fill
        stack.distribution = .fillProportionally
       
        return stack
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score : 0"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Quizzler Time"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    var trueButton: UIButton = {
        let button = UIButton()
        button.setTitle("True", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var falseButton: UIButton = {
        let button = UIButton()
        button.setTitle("False", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    let progressView: UIView = {
        let progress = UIView()
        return progress
    }()
    
    var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.0
        progress.backgroundColor = .red
        return progress
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }

    @objc func answerButtonPressed (_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:#selector(updateUI), userInfo:nil, repeats:false)
        
    }
    @objc func updateUI () {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score : \( quizBrain.getScore())"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        
    }
    
    func initialize () {
        view.backgroundColor = .blue
        view.addSubview(stackView)
        stackView.addArrangedSubview(scoreLabel)
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(trueButton)
        stackView.addArrangedSubview(falseButton)
        stackView.addArrangedSubview(progressView)
        progressView.addSubview(progressBar)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
        }
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        
        trueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(questionLabel).inset(250)
        }
        
        falseButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(questionLabel).inset(300)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(falseButton).inset(50)
            make.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(falseButton).inset(50)
            
        }
    }

}

