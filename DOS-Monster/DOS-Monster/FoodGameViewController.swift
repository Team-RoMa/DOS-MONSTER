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
    
    private let player = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
    private let leftButton = SKSpriteNode(color: .green, size: CGSize(width: 60, height: 60))
    private let rightButton = SKSpriteNode(color: .green, size: CGSize(width: 60, height: 60))
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let positionInScene = touch.location(in: self)
        let node = self.atPoint(positionInScene)
        if node.name == "left" {
            movePlayer(nodeKey: "left", moveBy: -40)
        } else if node.name == "right" {
            movePlayer(nodeKey: "right", moveBy: 40)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAction(forKey: "left")
        player.removeAction(forKey: "right")
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.white
        
        // button
        leftButton.name = "left"
        leftButton.position = CGPoint(x: 30, y: 30)
        addChild(leftButton)
        
        rightButton.name = "right"
        rightButton.position = CGPoint(x: size.width - 30, y: 30)
        addChild(rightButton)
        
        // player
        player.position = CGPoint(x: size.width * 0.5, y: 40/2)
        addChild(player)
        
        // food
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addFood),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
    }
    
    private func movePlayer(nodeKey: String, moveBy: CGFloat) {
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 1)
        let repeatForever = SKAction.repeatForever(moveAction)
        let sequence = SKAction.sequence([moveAction, repeatForever])
        player.run(sequence, withKey: nodeKey)
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
