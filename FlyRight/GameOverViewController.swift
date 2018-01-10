//
//  GameOverViewController.swift
//  FlyRight
//
//  Created by Jacob Patel on 1/5/18.
//  Copyright © 2018 Jacob Patel. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameOverController: UIViewController {

    var scene: GameOverScene!
    
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
    
    @IBAction func moveToMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "toMenuSegue", sender: nil)
    }
    
    //  self.performSegue(withIdentifier: "toGameSegue", sender: nil)
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameOverScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        // Present the scene.
        skView.presentScene(scene)
        
    }
}
