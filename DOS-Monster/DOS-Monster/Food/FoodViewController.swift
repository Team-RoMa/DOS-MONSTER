//
//  FoodViewController.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import RxSwift

class FoodViewController: UIViewController, ViewType {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "음식 목록"
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        return label
    }()
    
    private let emptyFoodLabel: UILabel = {
        let label = UILabel()
        label.text = "음식 목록이 비었습니다."
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("주기", for: .normal) // TODO: Cell isSelected 아닐 땐 비활성화하기
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 60
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubviews([selectButton, exitButton])
        return stackView
    }()
    
//    private lazy var foodCollectionViewDelegate = FoodCollectionViewDelegate()
    private lazy var foodCollectionViewDataSource = FoodCollectionViewDataSource()
    private lazy var foodCollectionView: UICollectionView = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: foodCollectionViewDataSource.sectionProvider,
            configuration: config
        )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = foodCollectionViewDelegate
        collectionView.dataSource = foodCollectionViewDataSource
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()        
    }
    
    func bind(to viewModel: FoodViewModel) {
        let input = FoodViewModel.Input(
            viewDidLoad: rx.viewDidLoad.asObservable(),
            exitButtonDidTap: exitButton.rx.tap.asObservable(),
            selectedButtonDidTap: foodCollectionView.rx.itemSelected.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output
        
        
        
        
//        selectButton.rx.tap
//            .bind { [weak self] in
//                guard let index = self?.foodCollectionViewDelegate.selectedCellIndex.value,
//                      let food = self?.foodCollectionViewDataSource.searchFood(at: index) else { return }
//            }
//                viewModel.action.selectButtonTapped.accept(food.name)
//
////                self?.foodCollectionViewDataSource.removeFood(at: index)
////                self?.foodCollectionView.reloadData()
//                self?.dismiss(animated: true)
//            }.disposed(by: disposeBag)
//
//        exitButton.rx.tap
//            .bind { [weak self] in
//                self?.dismiss(animated: true)
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.state.foodCountMap
//            .bind { [weak self] foodCountMap in
//                if foodCountMap.isEmpty {
//                    self?.emptyFoodLabel.isHidden = false
//                    self?.selectButton.isHidden = true
//                } else {
//                    self?.emptyFoodLabel.isHidden = true
//                    self?.selectButton.isHidden = false
//                    self?.foodCollectionViewDataSource.append(foodCountMap: foodCountMap)
//                }
//            }
//            .disposed(by: disposeBag)
        
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(foodCollectionView)
        view.addSubview(emptyFoodLabel)
        view.addSubview(buttonStackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        foodCollectionView.translatesAutoresizingMaskIntoConstraints = false
        foodCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        foodCollectionView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -16).isActive = true
        foodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        foodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        emptyFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyFoodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyFoodLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
