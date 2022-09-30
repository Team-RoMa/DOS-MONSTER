//
//  FoodGameViewController.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/29.
//

import UIKit
import SpriteKit

class FoodGameViewController: UIViewController {

    private lazy var skView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        skView.backgroundColor = .yellow
        
        view.addSubview(skView)
        let size = CGSize(width: view.frame.width, height: view.frame.height * 0.84)
        skView.frame.size = size

        let scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .resizeFill
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
        setupViews()
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [moveLeftButton, moveRightButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.94)
        ])
    }
    
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    private let moveLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left.square.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 
    private let moveRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right.square.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

// MARK: - GameScene
class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        
        let playerSize = CGSize(width: 40, height: 40)
        let player = SKSpriteNode(color: .red, size: playerSize)
        player.position = CGPoint(x: size.width * 0.5, y: 40/2)
        addChild(player)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addFood),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
    }
    
    func addFood() {
        let foodSize = CGSize(width: 40, height: 40)
        let food = SKSpriteNode(color: .blue, size: foodSize)
        
        
        let randomX = CGFloat.random(in: (foodSize.width/2)...(size.width - foodSize.width/2))
        food.position = CGPoint(x: randomX, y: size.height)
        addChild(food)
        
        let randomDuration = CGFloat.random(in: 2.0...4.0)
        
        let actionMove = SKAction
            .move(
                to: CGPoint(x: randomX, y: -foodSize.height),
                duration: TimeInterval(randomDuration)
            )
        let actionMoveDone = SKAction.removeFromParent()
        food.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
