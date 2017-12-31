//
//  Level.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/23/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//

import Foundation

let NumColumns = 12
let NumRows = 12
// orig 9x9

    // This will hold the position of the spaceShip.
    var shipPosX: Int = 0, shipPosY: Int = 0

    // This var is inteded to be incremented when the board has been drawn once so that move isn't called at the wrong time.
    var timesRun = 0

class Level {
    
    // This var will be the running static score of how many tiles the spaceShip has flown over.
    static var tiles: Int = 0
    
    // This Bool will trigger the showing of the Game-Over screen.
    static var isGameOver : Bool = false
  
  // MARK: Properties
  
  // The 2D array that keeps track of where the Spaces are.
  fileprivate var spaces = Array2D<Space>(columns: NumColumns, rows: NumRows)
  
  // The 2D array that contains the layout of the level.
  fileprivate var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)
    
    var tileCounter = 0
    
    // Variable of viewController to call showGameOver()
    var viewController: GameViewController!
    
  // MARK: Initialization
  
    // Create a level by loading it from a file.
    init(filename: String) {
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
        // The dictionary contains an array named "tiles". This array contains
        // one element for each row of the level. Each of those row elements in
        // turn is also an array describing the columns in that row. If a column
        // is 1, it means there is a tile at that location, 0 means there is not.

        guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
        
        // Loop through the rows...
        for (row, rowArray) in tilesArray.enumerated() {
            // Note: In Sprite Kit (0,0) is at the bottom of the screen,
            // so we need to read this file upside down.
            let tileRow = NumRows - row - 1
            
            // Loop through the columns in the current r
            for (column, value) in rowArray.enumerated() {
                // If the value is 1, create a tile object.
                if value == 1 {
                    tiles[column, tileRow] = Tile()
                }
            }
        }
    }
  
  
  // MARK: Level Setup
  
  // Fills up the level with new Spaces objects
  func shuffle() -> Set<Space> {
    return createInitialSpaces()
  }
  
    // Added code so that one below the bottom left corner always is filled by the ship.
  fileprivate func createInitialSpaces() -> Set<Space> {
    var set = Set<Space>()
    
    for row in 0..<NumRows {
      for column in 0..<NumColumns {
        if tiles[column, row] != nil {
            
          let spaceType = SpaceType.random() // Keep 'var'. Will be mutated later
          
            let space = Space(column: column, row: row, spaceType: spaceType)
          spaces[column, row] = space
          
          set.insert(space)
        }
      }
    }
    //make xpos ypos
    let spaceShip = Space(column: shipPosX, row: shipPosY, spaceType: SpaceType.ship())
    if (timesRun > 0 && !Level.isGameOver) {
        Space.move(direction : Space.getDirection(), spaceShip: spaceShip)
        Level.tiles += 1
        self.viewController.updateLabels()
        if (!outBounds(spaceShip: spaceShip)) {
        shipPosY = spaceShip.row
        shipPosX = spaceShip.column
        } else {
            Level.isGameOver =  true
            self.viewController.showGameOver()
        }
        detectAsteroid(row: shipPosY, column: shipPosX)
        addAsteroid()
    }
    timesRun += 1
    self.spaces[shipPosX, shipPosY] = spaceShip
    set.insert(spaceShip)
    return set
  }
  
  // This method is designed to determine if the Spaceship's current coordinates are out of bounds.
    func outBounds(spaceShip : Space) -> Bool {
        if ((spaceShip.column < NumColumns - NumColumns) || (spaceShip.column >= NumColumns)) {
            return true
        }
        if ((spaceShip.row < NumRows - NumRows) || (spaceShip.row >= NumRows)) {
            return true
        }
        return false
    }
    
    //Checks the Dictionary to see if an Asteroid is at the given index of the spaceShip and triggers "Game Over" if so.
    func detectAsteroid(row: Int, column: Int) {
        if (tiles[column,row] != nil) {
            Level.isGameOver =  true
            self.viewController.showGameOver()
        }
    }
    
    func addAsteroid() {
        let randomX = Int(arc4random_uniform(12))
        let randomY = Int(arc4random_uniform(12))
        if !((randomX == shipPosX) && (randomY == shipPosY)) {
            tiles[randomX,randomY] = Tile()
        }
    }
    
    // UPDATE THIS JACOB
    // This method will recalculate the score at the restart of the game.
    static func calculateScore() {
        tiles = 0
    }

  // MARK: Query the level
  
  // Determines whether there's a tile at the specified column and row.
  func tileAt(column: Int, row: Int) -> Tile? {
    assert(column >= 0 && column < NumColumns)
    assert(row >= 0 && row < NumRows)
    return tiles[column, row]
  }
  
  // Returns the space at the specified column and row, or nil when there is none.
  func spaceAt(column: Int, row: Int) -> Space? {
    assert(column >= 0 && column < NumColumns)
    assert(row >= 0 && row < NumRows)
    return spaces[column, row]
  }
}

