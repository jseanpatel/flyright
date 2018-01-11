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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


