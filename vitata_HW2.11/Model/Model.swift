//
//  Model.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

struct Cell {
    
    let row: String?
    let col: String?
    let inputValue: String?
    
    init(dictCell: [String: Any]) {
        row = dictCell["row"] as? String
        col = dictCell["col"] as? String
        inputValue = dictCell["inputValue"] as? String
    }
    
    static func getCells(from entryData: [[String: Any]]) -> [Cell]? {
        
        var cells: [Cell] = []
        
        for entryDataItem in entryData {
            guard let dictCell = entryDataItem["gs$cell"] as? [String: Any] else { return nil }
            let cell = Cell(dictCell: dictCell)
            cells.append(cell)
        }
        return cells
    }
}

struct Record {
    let item: String
    let description: String?
    let image: String?
}
