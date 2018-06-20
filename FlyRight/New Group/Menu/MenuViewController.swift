//
//  GameViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 1/4/18.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation

// Variable to control playing of music.
var audioPlayer: AVAudioPlayer!

class MenuViewController: UIViewController {

    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: MenuScene!

    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: View Controller Functions

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    @IBAction func moveToGame(_ sender: Any) {
        self.performSegue(withIdentifier: "toGameSegue", sender: nil)
    }

    @IBAction func moveToCredits(_ sender: Any) {
        self.performSegue(withIdentifier: "toCreditsSegue", sender: nil)
    }

    @IBAction func moveToOptions(_ sender: Any) {
        self.performSegue(withIdentifier: "toOptionsSegue", sender: nil)
    }


    @IBAction func moveToRecords(_ sender: Any) {
        self.performSegue(withIdentifier: "toRecordsSegue", sender: nil)
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.isFirstLaunchMenu()

        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false

        // Create and configure the scene.
        scene = MenuScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        // Present the scene.
        skView.presentScene(scene)

    }
}

// Extension to check when the first true start of the app is so defaults can be set.
extension UserDefaults {

    // Check for is first launch - only true on first invocation after app install, false on all further invocations.
    static func isFirstLaunchMenu() {

        let launchedBeforeMenu = UserDefaults.standard.bool(forKey: "launchedBeforeMenu")
        if launchedBeforeMenu {
            if (UserDefaults.standard.bool(forKey: "shouldPlay")) {
                let audioPlayerDict = UserDefaults.standard.value(forKey: "players") as? NSDictionary
                let audioPlayer = audioPlayerDict!["one"] as? AVAudioPlayer
                if !((audioPlayer?.isPlaying)!) {
                    audioPlayer?.play()
                }
            }
        } else {
            
            // Set path to music.
            let url = Bundle.main.url(forResource: "Chimera", withExtension: "mp3")
            
            // Instantiate the musicPlayer object and catch errors if they arise.
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url!)
                audioPlayer.prepareToPlay()
            } catch let error as NSError {
                print(error.debugDescription)
            }
    
    
            let players = ["one": audioPlayer]
            UserDefaults.standard.set(players, forKey: "players")

            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBeforeMenu")
            UserDefaults.standard.set(true, forKey: "shouldPlay")

            // Play the music.
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            UserDefaults.standard.set(true, forKey: "isPlaying")

        }
    }
}


