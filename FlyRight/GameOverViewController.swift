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

class GameOverViewController: UIViewController {

    var scene: GameOverScene!
    
    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: View Controller Functions
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func restartGame(_ sender: Any) {
        
        // Old way without any animations.
        self.view.removeFromSuperview()
    }
    
    func showGameOver() {
        let gameOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameOverID") as! GameOverViewController
        self.addChildViewController(gameOverVC)
        gameOverVC.view.frame = self.view.frame
        self.view.addSubview(gameOverVC.view)
        gameOverVC.didMove(toParentViewController: self)
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Toggle the fade in/out animations for the pop-up.
        self.showAnimate()
        
        // Transparent background for the pop-up.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
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
