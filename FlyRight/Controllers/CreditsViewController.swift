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
import Firebase
import GoogleMobileAds

class CreditsViewController: UIViewController {
    
    // The scene draws the tiles and space sprites, and handles actions (swipes for CC).
    var scene: CreditsScene!
    
    // For recognizing gestures.
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: View Controller Functions
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func moveToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }
    
    @IBAction func moveToOptions(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = ""
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = CreditsScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        // Present the scene.
        skView.presentScene(scene)
        
    }
}


