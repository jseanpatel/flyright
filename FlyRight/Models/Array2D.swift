//
//  Array2D.swift
//  FlyRight
//
//  Created by Jacob Patel on 7/1/17.
//  Copyright © 2017 Jacob Patel. All rights reserved.
//

struct Array2D<T> {

    let columns: Int
    let rows: Int
    fileprivate var array: Array<T?>

    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows * columns)
    }

    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }

}


