//
//  GameViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 3/13/18.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation

class RecordsViewController: UIViewController {

    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: RecordsScene!

    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: View Controller Functions

    // References to each of the high scores.
    @IBOutlet weak var tilesHigh: UILabel!
    @IBOutlet weak var scoreHigh: UILabel!
    @IBOutlet weak var turnsHigh: UILabel!

    // Shortened reference to userDefaults.
    let defaults = UserDefaults.standard

    //This method will update any labels with appropriate values.
    func updateLabels() {
        tilesHigh.text = String(format: "%ld", defaults.integer(forKey: "tiles"))
        scoreHigh.text = String(format: "%ld", defaults.integer(forKey: "score"))
        turnsHigh.text = String(format: "%ld", defaults.integer(forKey: "turns"))
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    @IBAction func moveToMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "toMenuSegue", sender: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Make sure high scores are current by updating labels.
        updateLabels()

        // Check if its the first launch to set default UserDefault values.
        UserDefaults.isFirstLaunch()

        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false

        // Create and configure the scene.
        scene = RecordsScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        // Present the scene.
        skView.presentScene(scene)

    }
}

// Extension to check when the first true start of the app is so defaults can be set.
extension UserDefaults {

    // Check for is first launch - only true on first invocation after app install, false on all further invocations.
    static func isFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")

            // Now set all the defaults values for the game.
            UserDefaults.standard.set(0, forKey: "tiles")
            UserDefaults.standard.set(0, forKey: "score")
            UserDefaults.standard.set(0, forKey: "turns")
        }
    }
}

