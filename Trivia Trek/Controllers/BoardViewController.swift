//
//  BoardViewController.swift
//  MAD 2018-19
//
//  Created by Arthur Lafrance on 1/27/19.
//  Copyright © 2019 Homestead FBLA. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class BoardViewController: UIViewController {

    @IBOutlet weak var boardView: SKView!
    @IBOutlet weak var tapTester: UITapGestureRecognizer!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseLabel: UILabel!
    
    var game: Game?
    var isPaused: Bool = false
    var currentTurn: DispatchWorkItem?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.pauseButton.layer.cornerRadius = 7
        self.quitButton.layer.cornerRadius = 7
        
        let board = SKScene(size: self.boardView.bounds.size)
        board.backgroundColor = UIColor(red: 18/255, green: 126/255, blue: 13/255, alpha: 1)
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: board.size.width / 2, y: board.size.height / 2 - 10)
        background.size = CGSize(width: board.size.width, height: board.size.height - 10)
        board.addChild(background)
        
        let player = SKSpriteNode(imageNamed: "avatar-sample")
        player.position = CGPoint(x: board.size.width / 2, y: board.size.height / 2 - 100)
        player.size = CGSize(width: 30, height: 30)
        board.addChild(player)
        
        self.boardView.presentScene(board)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.turnLabel.alpha = 1
        self.turnLabel.text = "Turn \(self.game!.turnsTaken)"
        
        self.scoreLabel.text = "Score: \(self.game!.player.numberCorrect)"
        
        self.fadeOutTurnLabel()

        self.takeTurn()
        
    }
    
    func takeTurn() {
        
        self.currentTurn = DispatchWorkItem(block: {
            self.performSegue(withIdentifier: "showQuestion", sender: self)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: self.currentTurn!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionViewController {
            
            let questionController = segue.destination as? QuestionViewController
            questionController?.game = self.game
            
        }
    }
    
    func fadeInTurnLabel() {
        
        self.turnLabel.alpha = 0
        
        UIView.animate(withDuration: 1.5, animations: {
            self.turnLabel.alpha = 1
        })
        
    }
    
    func fadeOutTurnLabel() {
        
        self.turnLabel.alpha = 1
        
        UIView.animate(withDuration: 1.5, animations: {
            self.turnLabel.alpha = 0
        })
        
    }
    
    @IBAction func moveRight(_ sender: Any) {
        
        let moveRight = SKAction(named: "moveLeft")
        let board = SKScene(fileNamed: "Board")
        
        if let player = board?.childNode(withName: "player") as? SKSpriteNode {
            
            player.run(moveRight!)
            
        }
        
    }

    @IBAction func pauseGame(_ sender: Any) {
        
        if self.isPaused {
            
            self.takeTurn()
            
        }
        else {
            
            self.currentTurn!.cancel()
            
        }
        
        UIView.animate(withDuration: 0.7, animations: {
            self.pauseLabel.isHidden = !self.pauseLabel.isHidden
        })

        self.pauseLabel.isHidden = !self.pauseLabel.isHidden

    }
    
    @IBAction func quitGame(_ sender: Any) {
        
        self.currentTurn!.cancel()
        
        let alertController = UIAlertController(title: "Quit Game?", message: "Are you sure you want to quit?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Quit", style: .default, handler: { action in
            self.performSegue(withIdentifier: "rewindToHome", sender: self)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.resume()
        })
        
    }
    
    @IBAction func backToBoard(segue: UIStoryboardSegue) {
        
        if segue.source is QuestionViewController {
            
            let srcController = segue.source as? QuestionViewController
            self.game = srcController?.game
            
        }
        
    }
    
}
