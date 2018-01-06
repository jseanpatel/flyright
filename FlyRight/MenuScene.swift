//
//  GameScene.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import SpriteKit

class MenuScene: SKScene {

    let gameLayer = SKNode()
    let spacesLayer = SKNode()
    let tilesLayer = SKNode()

    // MARK: Init

    // This variable will ensure a re-update every iteration.
    static var updateRequired = true

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }

    override init(size: CGSize) {
        super.init(size: size)

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // orig 0.5-0.5

        // Put an image on the background. Because the scene's anchorPoint is
        // (0.5, 0.5), the background image will always be centered on the screen.
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)

        // Add a new node that is the container for all other layers on the playing
        // field. This gameLayer is also centered in the screen.
        addChild(gameLayer)
        
    }
}

