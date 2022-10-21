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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Game", image: UIImage(systemName: "pencil"), tag: 1)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(skView)
        
        skView.translatesAutoresizingMaskIntoConstraints = false
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        skView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        skView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        print(skView.frame.size)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - GameScene
class GameScene: SKScene {
    private var obstaclePassed = 0
    
    // SKScene에 나타낼 수 있는 것은 모두 Node 형태
    // addChild로 Node를 추가하면 화면에 보일 수 있음
    private let player = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
    private let leftButton = SKSpriteNode(imageNamed: "arrow_left")
    private let rightButton = SKSpriteNode(imageNamed: "arrow_right")
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
    
    override func didMove(to view: SKView) { // 초기화코드
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
        let obstacle = SKSpriteNode(imageNamed: "skype_alien")
        let obstacleSize = obstacle.size
        
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
        // 운석 하나 피했을 때 실행되는 시퀀스
        obstacle.run(SKAction.sequence([actionMove, actionMoveDone, updateScore]))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) { // 노드 간 충돌시 실행되는 delegate 메소드
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
