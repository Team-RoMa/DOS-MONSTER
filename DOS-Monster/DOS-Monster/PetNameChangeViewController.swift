//
//  PetNameChangeViewController.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/14.
//

import RxSwift
import RxRelay

class PetNameChangeViewController: UIViewController, ViewType {
    
    private lazy var renamingLabel: UILabel = {
        let label = UILabel()
//        label.text = "펫 이름 재설정"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var guidanceLabel: UILabel = { // TODO: 펫 이름 설정에 대한 제약사항 추가
        let label = UILabel()
        label.text = "8글자 이내"
        return label
    }()
    
    private lazy var renamingTextFieldDelegate = NamingTextFieldDelegate()
    private lazy var renamingTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 10
        textField.addLeftPadding(inset: 10)
//        textField.placeholder = "새로운 펫 이름"
        textField.becomeFirstResponder()
        textField.delegate = renamingTextFieldDelegate
        return textField
    }()
    
    private lazy var confirmChangeButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.setTitle("변경하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func bind(to viewModel: PetNameChangeViewModel) {
        
        let input = PetNameChangeViewModel.Input(
            petNameTextFieldDidEdit: renamingTextField.rx.text.asObservable(),
            nextButtonDidTap: confirmChangeButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.currentName
            .bind(to: renamingLabel.rx.text)
            .disposed(by: disposeBag)
         
//        renamingLabel.text = output.currentName.value
    }
    
    private func layout() {
        view.addSubview(renamingLabel)
        view.addSubview(renamingTextField)
        view.addSubview(confirmChangeButton)
        
        renamingLabel.translatesAutoresizingMaskIntoConstraints = false
        renamingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36).isActive = true
        renamingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        renamingTextField.translatesAutoresizingMaskIntoConstraints = false
        renamingTextField.topAnchor.constraint(equalTo: renamingLabel.bottomAnchor, constant: 24).isActive = true
        renamingTextField.centerXAnchor.constraint(equalTo: renamingLabel.centerXAnchor).isActive = true
        renamingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        renamingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        renamingTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        confirmChangeButton.translatesAutoresizingMaskIntoConstraints = false
        confirmChangeButton.topAnchor.constraint(equalTo: renamingTextField.bottomAnchor, constant: 48).isActive = true
        confirmChangeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmChangeButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        confirmChangeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
