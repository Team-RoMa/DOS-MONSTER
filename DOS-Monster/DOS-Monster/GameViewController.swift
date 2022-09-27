//
//  GameViewController.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/27.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        setupViews()
        submitButton.addTarget(self, action: #selector(touchInputScoreButton), for: .touchUpInside)
    }
    
    @objc func touchInputScoreButton() {
        guard scoreField.text != nil,
                let score = Int(scoreField.text!) else {
            return
        }
        print("입력 점수: ", score)
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [scoreField, submitButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private let scoreField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "score 입력"
        textfield.keyboardType = .numberPad
        textfield.backgroundColor = .white
        return textfield
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("점수입력하기", for: .normal)
        return button
    }()
}
