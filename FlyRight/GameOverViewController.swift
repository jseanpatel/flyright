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
        self.removeAnimate()
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

        // Transparent background for the pop-up.
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //Toggle the fade in/out animations for the pop-up.
        self.showAnimate()


    }
}
