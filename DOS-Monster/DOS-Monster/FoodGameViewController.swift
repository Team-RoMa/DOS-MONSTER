//
//  FoodGameViewController.swift
//  DOS-Monster
//
//  Created by Sujin Jin on 2022/09/29.
//

import UIKit
import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = .max
    static let player: UInt32 = 0b1 // 1
    static let obstacle: UInt32 = 0b10 // 2
}

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
    private var obstaclePassed = 0
    
    private let player = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
    private let leftButton = SKSpriteNode(color: .green, size: CGSize(width: 60, height: 60))
    private let rightButton = SKSpriteNode(color: .green, size: CGSize(width: 60, height: 60))
    private let scoreLabel = SKLabelNode(fontNamed: "DungGeunMo")
    
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
        
        scoreLabel.text = "0000"
        scoreLabel.fontSize = 18
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: 60, y: size.height - 60)
        addChild(scoreLabel)
        
        // buttons
        leftButton.name = "left"
        leftButton.position = CGPoint(x: 30, y: 30)
        addChild(leftButton)
        
        rightButton.name = "right"
        rightButton.position = CGPoint(x: size.width - 30, y: 30)
        addChild(rightButton)
        
        
        // 1.충돌감지를 위해 환경설정
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // player
        player.position = CGPoint(x: size.width * 0.5, y: 40/2)
        addChild(player)
        // 2. player 에 대한 충돌 감지 설정
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        // obstacle
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addObstacle),
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
    
    func addObstacle() {
        let obstacleSize = CGSize(width: 40, height: 40)
        let obstacle = SKSpriteNode(color: .blue, size: obstacleSize)
        
        // 충돌체크를 위한 코드
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacleSize)
        // 물리엔진이 food의 움직임을 제어하지 않게 한다
        obstacle.physicsBody?.isDynamic = true
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        // 이 객체와 부딪혔을떄 contact listener 에게 알려야 하는 객체의 category
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.player
        // 서로를 튕기게 하지 않고 통과하게 하고싶으므로 none 으로 설정
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let randomX = CGFloat.random(in: (obstacleSize.width/2)...(size.width - obstacleSize.width/2))
        obstacle.position = CGPoint(x: randomX, y: size.height)
        addChild(obstacle)
        
        let randomDuration = CGFloat.random(in: 2.0...4.0)
        
        let actionMove = SKAction
            .move(
                to: CGPoint(x: randomX, y: -obstacleSize.height),
                duration: TimeInterval(randomDuration)
            )
        let actionMoveDone = SKAction.removeFromParent()
        let updateScore = SKAction.run { [weak self] in
            guard let `self` = self else { return }
            self.obstaclePassed += 1
            self.scoreLabel.text = "\(self.obstaclePassed)"
        }
        obstacle.run(SKAction.sequence([actionMove, actionMoveDone, updateScore]))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        // 충돌하는 두개의 body 는 순서를 보장하지 않으므로, bitmask 에 의해 정렬하고
        // food, player 인지 확인한다
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.obstacle != 0)) {
            if let player = firstBody.node as? SKSpriteNode,
               let food = secondBody.node as? SKSpriteNode {
                foodDidCollideWithPlayer(food: food, player: player)
            }
        }
    }
    
    func foodDidCollideWithPlayer(food: SKSpriteNode, player: SKSpriteNode) {
        food.removeFromParent()
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size, score: self.obstaclePassed)
        view?.presentScene(gameOverScene, transition: reveal)
    }
}

// MARK: - GameOverScene
class GameOverScene: SKScene {
  init(size: CGSize, score: Int) {
    super.init(size: size)
    
    backgroundColor = SKColor.white
      let message = "SCORE: \(score)"
    
    let label = SKLabelNode(fontNamed: "DungGeunMo")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.black
    label.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(label)
    
    run(SKAction.sequence([
      SKAction.wait(forDuration: 3.0),
      SKAction.run { [weak self] in
        guard let `self` = self else { return }
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition: reveal)
      }
      ]))
   }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
