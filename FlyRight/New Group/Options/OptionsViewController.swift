//
//  GameViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 3/3/18.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation

class OptionsViewController: UIViewController {

    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: OptionsScene!

    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!

    // MARK: View Controller Functions

    @IBAction func controlMusic(_ sender: Any) {
        if ((sender as AnyObject).isOn) {
            print("on")
            UserDefaults.standard.set(true, forKey: "shouldPlay")
            UserDefaults.standard.set(false, forKey: "isPlaying")
            UserDefaults.isFirstLaunchMenu()
        } else {
            print("off")
            UserDefaults.standard.set(false, forKey: "shouldPlay")
            UserDefaults.standard.set(false, forKey: "isPlaying")
            UserDefaults.isFirstLaunchMenu()
        }
    }
    
    @IBAction func controlSoundEffects(_ sender: Any) {
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

    // Must be touched multiple times to records to original values.
    @IBAction func resetRecords(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "tiles")
        UserDefaults.standard.set(0, forKey: "score")
        UserDefaults.standard.set(0, forKey: "turns")
    }
    
    @IBAction func moveToMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "toMenuSegue", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false

        // Create and configure the scene.
        scene = OptionsScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill

        // Present the scene.
        skView.presentScene(scene)

    }
}

