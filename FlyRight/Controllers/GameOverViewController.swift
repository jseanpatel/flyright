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
import Firebase
import GoogleMobileAds

class GameOverViewController: UIViewController {

    weak var gVC: GameViewController!
    
    var scene: GameOverScene!
    
    var interstitial: GADInterstitial!
    
    // MARK: View Controller Functions

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func moveToOptions(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }
    
    @IBAction func restartGame(_ sender: Any) {
        self.removeAnimate()
        if self.view.isDescendant(of: gVC.view) {
            self.view.removeFromSuperview()
        }
        self.removeFromParentViewController()
        gVC.refreshGame()
         AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    @IBAction func moveToMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
         AVAudioPlayer.playSpecAudio(audioPiece: "Back", volume: 0.7)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) in
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }

        // Transparent background for the pop-up.
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //Toggle the fade in/out animations for the pop-up.
        self.showAnimate()


    }
}
