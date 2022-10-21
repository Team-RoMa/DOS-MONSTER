//
//  FoodCollectionViewCell.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import RxSwift

class FoodCollectionViewCell: UICollectionViewCell, ViewType {
    
    private var disposeBag = DisposeBag()
    
    static var identifier: String {
        String(describing: self)
    }
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var satisfactionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubviews([nameLabel, satisfactionLabel, countLabel])
        return stackView
    }()
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor =  isSelected ? UIColor.systemBlue.cgColor : UIColor.black.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        layer.borderWidth = 3
        backgroundColor = .systemGray4
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func bind(to viewModel: FoodCollectionCellViewModel) {
        defer { viewModel.action.cellViewDidLoad.accept(()) }
        
        viewModel.state.loadedfood.bind { [weak self] food in
            self?.nameLabel.text = food.name
            self?.satisfactionLabel.text = "포만감 +\(food.satisfaction)"
            self?.emojiLabel.text = food.emoji
        }.disposed(by: disposeBag)
        
        viewModel.state.loadedCount
            .map { "남은 개수: \($0)개"}
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        addSubview(emojiLabel)
        addSubview(stackView)
        
//        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
//        emojiLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        emojiLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.centerYAnchor.constraint(equalTo: emojiLabel.centerYAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        emojiLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 16).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
