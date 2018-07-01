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

    // Reference for getting and setting records.
    weak var recordsVC: RecordsViewController!

    var gameAudioPlayer: AVAudioPlayer!

    // This var will be a running count of all turns.
    var turns: Int = 0

    // Variable of gameOverViewController to call showGameOver().
    var gameOverViewController: GameOverViewController!

    // Variable to keep track of score.
    var score: Int = 0

    // Variable to keep track of tiles.
    var tiles: Int = 0

    // Shortened reference to userDefaults.
    let defaults = UserDefaults.standard

    // Allow access for turns for highScores
    func getTurns() -> Int {
        return turns
    }

    //This method will update any labels with appropriate values.
    func updateLabels() {
        tilesLabel.text = String(format: "%ld", getNumTiles())
        turnLabel.text = String(format: "%ld", turns)
        //here the genScore() func is dynamically called to continually update the displayed total score
        scoreLabel.text = String(format: "%ld", genScore())

    }

    // This func sets the amout of tiles and then returns that number.
    func getNumTiles() -> Int {
        tiles = scene.level.tileCount
        return tiles
    }

    // This func will correctly relate the turns and tiles to generate a score.
    func genScore() -> Int {
        score = (scene.level.tileCount * 4 / 10) * (turns * 12 / 10) * 10
        return score
    }

    // The outlet to make a turn.
    @IBAction func turn(_ sender: UIButton) {
        level.getShipRef()?.changeDirection()
        turns += 1
        AVAudioPlayer.playSpecAudio(audioPiece: "FlyRight", volume: 0.55)
        
    }

    //End the game and transition over the GameOverViewController.
    func gameOver() {

        AVAudioPlayer.playSpecAudio(audioPiece: "End", volume: 0.7)

        let gameOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameOverID") as! GameOverViewController
        gameOverVC.gVC = self
        gameOverVC.view.tag = 100
        gameOverVC.view.frame = self.view.frame

        self.addChildViewController(gameOverVC)
        self.view.addSubview(gameOverVC.view)
        gameOverVC.didMove(toParentViewController: self)

        // Check for new records.
        compHighScores()
    }
    // A method that checks if the current class variables of the finished game are larger than the high scores.
    func compHighScores() {

        // Submit new scores for comparison from the recently finished game.
        defaults.set(tiles, forKey: "newTiles")
        defaults.set(score, forKey: "newScore")
        defaults.set(turns, forKey: "newTurns")

        // Compare stored and new values.
        if (defaults.integer(forKey: "newTiles") > defaults.integer(forKey: "tiles")) {
            defaults.set(defaults.integer(forKey: "newTiles"), forKey: "tiles")
        }

        if (defaults.integer(forKey: "newScore") > defaults.integer(forKey: "score")) {
            defaults.set(defaults.integer(forKey: "newScore"), forKey: "score")
        }

        if (defaults.integer(forKey: "newTurns") > defaults.integer(forKey: "turns")) {
            defaults.set(defaults.integer(forKey: "newTurns"), forKey: "turns")
        }
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

