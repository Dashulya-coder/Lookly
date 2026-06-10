//
//  AccessoryItem.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI

enum AccessoryCategory: String, CaseIterable {
    case glasses = "Glasses"
    case hats = "Hats"
}

enum AccessoryContent {
    case model(usdzFileName: String)
}

struct AccessoryItem: Identifiable {
    let id = UUID()
    let name: String
    let category: AccessoryCategory
    let content: AccessoryContent
    let thumbnailName: String
}
