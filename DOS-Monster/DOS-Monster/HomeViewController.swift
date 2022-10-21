//
//  ViewController.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/20.
//

import RxSwift
import RxRelay
import RxAppState

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}

class HomeViewController: UIViewController, ViewType {
    
    private let disposeBag = DisposeBag()
//    let pet = Pet(name: "임의의 펫이름")
    
    private lazy var feedButton: UIButton = {
        let button = UIButton()
        button.setTitle("음식주기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private lazy var petNameChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("펫이름변경", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let petNameLabel = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "pencil"), tag: 0)
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.background
        setupViews()
        
//        pet.updateSatietyLevel { satietyLevel in
//            satietyFigureLabel.text = "\(satietyLevel)"
//        }
//
//        pet.updateClosenessLevel { closenessLevel in
//            moodFigureLabel.text = "\(closenessLevel)"
//        }
    }
    
    func bind(to viewModel: HomeViewModel) {
        
        // MARK: From ViewModel
        
//        navigationItem.title = "asd"
        
//        viewModel.state.loadedFoods.bind { [weak self] foodCountMap in
//            let foodViewController = FoodViewController()
//            let foodViewModel = FoodViewModel(foodCountMap: foodCountMap)
//            foodViewController.viewModel = foodViewModel
//            self?.bindFoodViewModel(foodViewModel)
//            self?.present(foodViewController, animated: true)
//        }.disposed(by: disposeBag)
        
        // MARK: To ViewModel
        
        let input = HomeViewModel.Input(
            feedButtonDidTap: feedButton.rx.tap.asObservable(),
            petNameChangeButtonDidTap: petNameChangeButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.petName
            .bind(to: petNameLabel.rx.text)
            .disposed(by: disposeBag)
            
        
//        viewModel.state.presentFoodView.bind { [weak self] foodViewModel in
//            let foodViewController = FoodViewController()
//            foodViewController.viewModel = foodViewModel
////            self?.bindFoodViewModel(foodViewModel)
//            self?.present(foodViewController, animated: true)
//        }
//        .disposed(by: disposeBag)
//
//        viewModel.state.petName
//            .bind(to: petNameLabel.rx.text)
//            .disposed(by: disposeBag)
        
        
        
    }
    
//    private func bindFoodViewModel(_ viewModel: FoodViewModel) {
//        viewModel.action.exitButtonTapped.bind { [weak self] in
//            self?.dismiss(animated: true)
//        }.disposed(by: disposeBag)
//    }
    
    private func setupViews() {
        let dateStackView = makeStackView(views: [dateLabel, dateCountLabel], axis: .vertical)
        let moodStackView = makeStackView(views: [moodLabel, moodFigureLabel], axis: .vertical)
        let satietyStackView = makeStackView(views: [satietyLabel, satietyFigureLabel], axis: .vertical)
        
        let statusView = makeStackView(views: [dateStackView, moodStackView, satietyStackView], axis: .horizontal)
        
        view.addSubview(statusView)
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            statusView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        view.addSubview(logBackgroundView)
        NSLayoutConstraint.activate([
            logBackgroundView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 20),
            logBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            logBackgroundView.heightAnchor.constraint(equalTo: logBackgroundView.widthAnchor, multiplier: 1.0)
        ])

        logBackgroundView.addSubview(logTextView)
        NSLayoutConstraint.activate([
            logTextView.topAnchor.constraint(equalTo: logBackgroundView.topAnchor, constant: 0),
            logTextView.bottomAnchor.constraint(equalTo: logBackgroundView.bottomAnchor, constant: 0),
            logTextView.leadingAnchor.constraint(equalTo: logBackgroundView.leadingAnchor, constant: 0),
            logTextView.trailingAnchor.constraint(equalTo: logBackgroundView.trailingAnchor, constant: 0)
        ])
        
        view.addSubview(monsterView)
        NSLayoutConstraint.activate([
            monsterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monsterView.widthAnchor.constraint(equalToConstant: 60),
            monsterView.heightAnchor.constraint(equalTo: monsterView.widthAnchor),
            monsterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        view.addSubview(feedButton)
        feedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            feedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
        
        view.addSubview(petNameChangeButton)
        petNameChangeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petNameChangeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            petNameChangeButton.bottomAnchor.constraint(equalTo: feedButton.topAnchor, constant: -15)
        ])
        
        view.addSubview(petNameLabel)
        petNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            petNameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
    
    private let monsterView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logTextView: UITextView = {
        let text = """
        system> "진돌이"에게 밥을 주었습니다.
        system> "진돌이"가 기뻐합니다. 만복도가 1 오릅니다.
        """
        let textView = UITextView()
        textView.text = text
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let attributes = [
            NSAttributedString.Key.paragraphStyle: style,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: ColorPalette.panelContents
        ]
        textView.typingAttributes = attributes
        textView.attributedText = NSAttributedString(string: text, attributes: attributes)
        textView.isUserInteractionEnabled = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.justified
        textView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let logBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.panelBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logLabel: UILabel = {
        let label = UILabel()
        label.text = """
system> "진돌이" 에게 밥을 주었습니다
"""
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateCountLabel: UILabel = {
        let label = UILabel()
        label.text = "99"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "친밀도"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moodFigureLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let satietyLabel: UILabel = {
        let label = UILabel()
        label.text = "포만감"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let satietyFigureLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.textColor = ColorPalette.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func makeStackView(views: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.alignment = .center
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
