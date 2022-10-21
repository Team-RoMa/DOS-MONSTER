//
//  PetNameSetupViewController.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/12.
//

import RxSwift
import RxRelay

class PetNameSetupViewController: UIViewController, ViewType {
    private lazy var namingLabel: UILabel = {
        let label = UILabel()
        label.text = "펫의 이름은 무엇인가요?"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var guidanceLabel: UILabel = { // TODO: 펫 이름 설정에 대한 제약사항 추가
        let label = UILabel()
        label.text = "8글자 이내"
        return label
    }()
    
    private lazy var namingTextFieldDelegate = NamingTextFieldDelegate()
    private lazy var namingTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.addLeftPadding(inset: 10)
        textField.placeholder = "펫 이름"
        textField.becomeFirstResponder()
        textField.delegate = namingTextFieldDelegate
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
//        button.setTitleColor(.systemGray3, for: .disabled)
//        button.isEnabled = false
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        
    }
    
    func bind(to viewModel: PetNameSetupViewModel) {
        let input = PetNameSetupViewModel.Input(
            petNameTextFieldDidEdit: namingTextField.rx.text.asObservable(),
            nextButtonDidTap: nextButton.rx.tap.asObservable()
        )
        
        viewModel.transform(from: input)
    }
    
    private func layout() {
        view.addSubview(namingLabel)
        view.addSubview(namingTextField)
        view.addSubview(nextButton)
        
        namingLabel.translatesAutoresizingMaskIntoConstraints = false
        namingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36).isActive = true
        namingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        namingTextField.translatesAutoresizingMaskIntoConstraints = false
        namingTextField.topAnchor.constraint(equalTo: namingLabel.bottomAnchor, constant: 24).isActive = true
        namingTextField.centerXAnchor.constraint(equalTo: namingLabel.centerXAnchor).isActive = true
        namingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        namingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        namingTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: namingTextField.bottomAnchor, constant: 48).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
