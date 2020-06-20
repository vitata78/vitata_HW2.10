//
//  Model.swift
//  vitata_HW2.10
//
//  Created by Andrew on 6/19/20.
//  Copyright © 2020 APNET HQ LLC. All rights reserved.
//

struct Cell: Decodable {
    let row: String?
    let col: String?
    let inputValue: String?
}

struct Entry: Decodable {
    let gs$cell: Cell?
}

struct Content: Decodable {
    let entry: [Entry]?
}

struct Feed: Decodable {
    let feed: Content?
}

struct Record {
    let item: String
    let description: String?
    let image: String?
}
