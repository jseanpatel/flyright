//
//  Space.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/2/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//
import SpriteKit

// MARK: - SpaceType

// Added shipType here.
enum SpaceType: Int, CustomStringConvertible {
    case unknown = 0, Asteroid, Spaceship

    //  These sprite names have not been chosen yet because the mutli-tile features have not been implemented yet.
    var spriteName: String {
        let spriteNames = [
            "Asteroid",
            "Spaceship"
        ]

        return spriteNames[rawValue - 1]
    }

    var description: String {
        return spriteName
    }


    static func random() -> SpaceType {
        return SpaceType(rawValue: Int(arc4random_uniform(1)) + 1)!
    }


    // Including this so that the type ship can be called only once.
    static func ship() -> SpaceType {
        return SpaceType(rawValue: 2)!
    }

}


// MARK: - Space

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}

class Space: CustomStringConvertible, Hashable {

    var column: Int
    var row: Int
    let spaceType: SpaceType
    var sprite: SKSpriteNode?
    var direction: String = "north"

    init(column: Int, row: Int, spaceType: SpaceType) {
        self.column = column
        self.row = row
        self.spaceType = spaceType
    }

    init(spaceType: SpaceType) {
        self.spaceType = spaceType
        row = -1
        column = 0
    }

    var description: String {
        return "type:\(spaceType) square:(\(column),\(row))"
    }

    var hashValue: Int {
        return row * 10 + column
    }

    func move() {
        switch(direction) {
        case "north":
            row += 1
        case "south":
            row -= 1
        case "east":
            column += 1
        case "west":
            column -= 1
        default: break
        }
    }

    func getSpaceType() -> SpaceType {
        return spaceType
    }

    func changeDirection() {
        switch(direction) {
        case "north":
            direction = "east"
        case "east":
            direction = "south"
        case "south":
            direction = "west"
        case "west":
            direction = "north"
        default: break
        }
    }

    func getDegree() -> Int? {
        switch(direction) {
        case "north":
            return 0
        case "east":
            return 90
        case "south":
            return 180
        case "west":
            return 270
        default: return 0
        }
    }

    func getDirection() -> String {
        return direction
    }

    func getRow() -> Int {
        return row
    }

    func getColumn() -> Int {
        return column
    }

    func getType() -> SpaceType {
        return spaceType
    }
}
