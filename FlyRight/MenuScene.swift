//
//  MenuScene.swift
//  FlyRight
//
//  Created by Jacob Patel on 9/24/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene : SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // orig 0.5-0.5
        
        // Put an image on the background. Because the scene's anchorPoint is
        // (0.5, 0.5), the background image will always be centered on the screen.
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

