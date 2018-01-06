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

    // This outlet will keep track of the calculated score.

    // This outlet counts number of turns to factor into the score.
    @IBOutlet weak var turnLabel: UILabel!

    // This outlet logs tiles crossed to factor into the score.
    @IBOutlet weak var tilesLabel: UILabel!

    // This outlet will periodically calculate scores using the vales of tilesLabel and turnLabel.
    @IBOutlet weak var scoreLabel: UILabel!

    // This var will be a running count of all turns.
    var turns: Int = 0

    //This method will update any labels with appropriate values.
    func updateLabels() {
        tilesLabel.text = String(format: "%ld", Level.tiles)
        turnLabel.text = String(format: "%ld", turns)
        //here the genScore() func is dynamically called to continually update the displayed total score
        scoreLabel.text = String(format: "%ld", genScore())
    }

    // This func will correctly relate the turns and tiles to generate a score.
    func genScore() -> Int {
        return (Level.tiles * 4 / 10) * (turns * 12 / 10) * 10
    }

    // The outlet to make a turn.
    @IBAction func turn(_ sender: UIButton) {
        level.getShipRef()?.changeDirection()
        turns += 1
    }

    // Game-Over panel if asteroid is hit.
    @IBOutlet weak var gameOverPanel: UIImageView!

    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: Properties

    // Controls the display of the Game-Over panel. No interaction enabled.
    func showGameOver() {
        gameOverPanel.isHidden = false
        scene.isUserInteractionEnabled = false

        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideGameOver))
        self.view.addGestureRecognizer(self.tapGestureRecognizer)
    }

    // Hides the Game-Over panel and then restarts the game.
    @objc func hideGameOver() {
        view.removeGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer = nil

        gameOverPanel.isHidden = true
        scene.isUserInteractionEnabled = true
        beginGame()
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false

        //Hide the Game-Over panel before the game starts.
        gameOverPanel.isHidden = true

        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

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
    }

    func shuffle() {
        // Fill up the level with new spaces, and create sprites for them.
        let newSpace = level.shuffle()
        scene.addSprites(for: newSpace)
    }

}

