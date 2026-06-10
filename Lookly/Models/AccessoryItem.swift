//
//  AccessoryItem.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI
import RealityKit

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
    
    let position: SIMD3<Float>
    let scale: SIMD3<Float>
    let orientation: simd_quatf
}
