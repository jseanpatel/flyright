//
//  GameScene.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import SpriteKit

extension UIImage {

    public func rotateImageByDegrees(_ degrees: CGFloat) -> UIImage {

        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }

        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size

        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))

        // Now, draw the rotated/scaled image into the context
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))

        let cgimage: CGImage = bitmap!.makeImage()!
        return UIImage(cgImage: cgimage)
    }
}

class GameScene: SKScene {

    var gameViewController: GameViewController?

    // MARK: Properties

    var level: Level!

    let TileWidth: CGFloat = 28
    let TileHeight: CGFloat = 28

    var currTime: Date? = Date()

    let gameLayer = SKNode()
    let spacesLayer = SKNode()
    let tilesLayer = SKNode()

    // MARK: Init

    // This variable will ensure a re-update every iteration.
    static var updateRequired = true

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }

    override func update(_ currentTime: TimeInterval) {
        if (currTime == nil) { currTime = Date() }
        if (NSDate().timeIntervalSince(currTime!) > 0.5) {
            shuffle()
            currTime = Date()
        }
    }

    func shuffle() {
        removeAllSpaces()

        // Fill up the level with new spaces, and create sprites for them.
        let newSpaces = level.shuffle()
        addSprites(for: newSpaces)
    }

    // This func clears the board of all nodes.
    func removeAllSpaces() {
        spacesLayer.removeAllChildren()
    }

    override init(size: CGSize) {
        super.init(size: size)

        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // orig 0.5-0.5

        // Put an image on the background. Because the scene's anchorPoint is
        // (0.5, 0.5), the background image will always be centered on the screen.
        let background = SKSpriteNode(imageNamed: "SpaceBackground")
        background.size = size
        addChild(background)

        // Add a new node that is the container for all other layers on the playing
        // field. This gameLayer is also centered in the screen.
        addChild(gameLayer)

        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)

        // The tiles layer represents the shape of the level. It contains a sprite
        // node for each square that is filled in.
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)

        // This layer holds the Space sprites. The positions of these sprites
        // are relative to the spacesLayer's bottom-left corner.
        spacesLayer.position = layerPosition
        gameLayer.addChild(spacesLayer)
    }


    // MARK: Level Setup

    // If there is a tile at this position, then create a new tile
    // sprite and add it to the mask layer
    func addTiles() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let tileNode = SKSpriteNode(imageNamed: "Tile")
                tileNode.size = CGSize(width: TileWidth, height: TileHeight)
                tileNode.position = pointFor(column: column, row: row)
                tilesLayer.addChild(tileNode)
            }
        }
    }
// Create a new sprite for the space and add it to the spacesLayer.
    func addSprites(for spaces: Set<Space>) {
        for space in spaces {
            let sprite = SKSpriteNode(imageNamed: space.spaceType.spriteName)
            sprite.size = CGSize(width: TileWidth, height: TileHeight)
            sprite.position = pointFor(column: space.column, row: space.row)
            if (space.getSpaceType() == SpaceType.Spaceship) {
                var shipImage = UIImage(cgImage: (sprite.texture?.cgImage())!)
                shipImage = shipImage.rotateImageByDegrees(CGFloat((level.getShipRef()?.getDegree())!))
                let shipRefTexture: SKTexture = SKTexture(image: shipImage)
                sprite.texture = shipRefTexture
            }
            spacesLayer.addChild(sprite)
            space.sprite = sprite

        }
    }

    // Add animations every time the game is restarted.
    func animateBeginGame(_ completion: @escaping () -> ()) {
        gameLayer.isHidden = false
        gameLayer.position = CGPoint(x: 0, y: size.height)
        let action = SKAction.move(by: CGVector(dx: 0, dy: -size.height), duration: 0.3)
        action.timingMode = .easeOut
        gameLayer.run(action, completion: completion)
    }

// MARK: Point conversion

// Converts a column,row pair into a CGPoint that is relative to the spaceLayer.
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * TileWidth + TileWidth / 2,
            y: CGFloat(row) * TileHeight + TileHeight / 2)
    }


}
