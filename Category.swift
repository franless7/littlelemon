//
//  Category.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 7.02.2023.
//

import Foundation

struct Category: Identifiable {
    var id: String = UUID().uuidString
    var title: String
}

var categories = [

    Category(title: "Starters"),
    Category(title: "Mains"),
    Category(title: "Desserts"),
    Category(title: "Drinks")

]
