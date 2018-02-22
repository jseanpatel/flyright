//
//  GameViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//

// static move method
import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {

    // This outlet counts number of turns to factor into the score.
    @IBOutlet weak var turnLabel: UILabel!

    // This outlet logs tiles crossed to factor into the score.
    @IBOutlet weak var tilesLabel: UILabel!

    // This outlet will periodically calculate scores using the vales of tilesLabel and turnLabel.
    @IBOutlet weak var scoreLabel: UILabel!

    // This var will be a running count of all turns.
    var turns: Int = 0

    // Variable of gameOverViewController to call showGameOver()
    var gameOverViewController: GameOverViewController!
    
    // Variable to keep track of score.
    var score : Int = 0
    
    // Allow access of scores for highscores.
    func getHighScore() -> Int {
        return score
    }
    
    //This method will update any labels with appropriate values.
    func updateLabels() {
        tilesLabel.text = String(format: "%ld", scene.level.tileCount)
        turnLabel.text = String(format: "%ld", turns)
        //here the genScore() func is dynamically called to continually update the displayed total score
        scoreLabel.text = String(format: "%ld", genScore())
    }

    // This func will correctly relate the turns and tiles to generate a score.
    func genScore() -> Int {
        var score = (scene.level.tileCount * 4 / 10) * (turns * 12 / 10) * 10
        return score
    }

    // The outlet to make a turn.
    @IBAction func turn(_ sender: UIButton) {
        level.getShipRef()?.changeDirection()
        turns += 1
    }

    //End the game and transition over the GameOverViewController.
    func gameOver() {
        let gameOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameOverID") as! GameOverViewController
        gameOverVC.gVC = self
        gameOverVC.view.tag = 100
        gameOverVC.view.frame = self.view.frame
        
        self.addChildViewController(gameOverVC)
        self.view.addSubview(gameOverVC.view)
        gameOverVC.didMove(toParentViewController: self)
    }
    
    // Reset all labels to 0 when restarting game.
    func resetLabels() {
        tilesLabel.text = String(format: "%ld", 0)
        //reinitialize turns to 0
        turns = 0
        turnLabel.text = String(format: "%ld", 0)
        //here the genScore() func is dynamically called to continually update the displayed total score
        scoreLabel.text = String(format: "%ld", 0)
    }

    // Refresh the game when restartGame() is called in GameOverViewController
    func refreshGame() {
        setUpLevel()
    }
    
    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: Properties

    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: GameScene!

    // The level contains the tiles, the spaces, and most of the gameplay logic.
    // Needs to be ! because it's not set in init() but in viewDidLoad().
    var level: Level!

    // MARK: View Controller Functions

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    func setUpLevel() {
        super.viewDidLoad()
        // Configure the view.
        print("Going to sul")
        let skView = self.view as! SKView
       
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.gameViewController = self
        
        // Load the level.
        level = Level(filename: "Level_1", scene: scene)
        scene.level = level
        level.viewController = self
        
        scene.addTiles()
        
        //Sync the starting score with the game.
        updateLabels()
        
        // Present the scene.
        skView.presentScene(scene)
        
        // Start the game.
        beginGame()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        print("Going to vdl")
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.gameViewController = self

        // Load the level.
        level = Level(filename: "Level_1", scene: scene)
        scene.level = level
        level.viewController = self 

        scene.addTiles()

        //Sync the starting score with the game.
        updateLabels()

        // Present the scene.
        skView.presentScene(scene)

        // Start the game.
        beginGame()
    }

    // MARK: Game functions

    func beginGame() {
        shuffle()
        // scene.animateBeginGame()
    }

    func shuffle() {
        // Fill up the level with new spaces, and create sprites for them.
        let newSpace = level.shuffle()
        scene.addSprites(for: newSpace)
        resetLabels()
    }

}

