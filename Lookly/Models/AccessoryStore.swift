//
//  AccessoryStore.swift
//  Lookly
//
//  Created by Daria Ukshe on 10.06.2026.
//

import RealityKit

struct AccessoryStore {
    static let items: [AccessoryItem] = [
        AccessoryItem(
            // Done
            name: "Heart",
            category: .glasses,
            content: .model(usdzFileName: "glasses_01"),
            thumbnailName: "glasses_01_thumb",
            position: [0, -0.01, 0.05],
            scale: [0.15, 0.15, 0.15],
            orientation: simd_quatf(angle: .pi * 3/2, axis: [0, 1, 0])
        ),
        AccessoryItem(
            // Done
            name: "Pixel",
            category: .glasses,
            content: .model(usdzFileName: "glasses_02"),
            thumbnailName: "glasses_02_thumb",
            position: [0, 0.02, 0.04],
            scale: [0.062, 0.062, 0.062],
            orientation: simd_quatf(angle: 0, axis: [0, 1, 0])
        ),
        AccessoryItem(
            name: "Aviator",
            category: .glasses,
            content: .model(usdzFileName: "glasses_03"),
            thumbnailName: "glasses_03_thumb",
            position: [0, 0.01, 0.07],
            scale: [0.0005, 0.0005, 0.0005],
            orientation: simd_quatf(angle: 0, axis: [0, 1, 0])
        ),
        AccessoryItem(
            // Done
            name: "Round",
            category: .glasses,
            content: .model(usdzFileName: "glasses_04"),
            thumbnailName: "glasses_04_thumb",
            position: [0, 0.02, 0.05],
            scale: [0.075, 0.075, 0.075],
            orientation: simd_quatf(angle: 0, axis: [0, 1, 0])
        ),
        AccessoryItem(
            // Done
            name: "Rect",
            category: .glasses,
            content: .model(usdzFileName: "glasses_05"),
            thumbnailName: "glasses_05_thumb",
            position: [0, 0.02, 0.05],
            scale: [0.075, 0.075, 0.075],
            orientation: simd_quatf(angle: 0, axis: [0, 1, 0])
        ),
        AccessoryItem(
            // Done
            name: "Sport",
            category: .glasses,
            content: .model(usdzFileName: "glasses_06"),
            thumbnailName: "glasses_06_thumb",
            position: [0, 0.02, 0.05],
            scale: [0.07, 0.07, 0.07],
            orientation: simd_quatf(angle: 0, axis: [0, 1, 0])
        ),
        
        AccessoryItem(
            // Done
            name: "Lashes",
            category: .glasses,
            content: .model(usdzFileName: "glasses_07"),
            thumbnailName: "glasses_07_thumb",
            position: [0, -0.01, 0],
            scale: [0.011, 0.011, 0.011],
            orientation: simd_quatf(angle: .pi*3/2, axis: [1, 0, 0])
        ),
        
        AccessoryItem(
            name: "Winter Hat",
            category: .hats,
            content: .model(usdzFileName: "hat_01"),
            thumbnailName: "hat_01_thumb",
            position: [0, -0.01, 0.05],
            scale: [0.15, 0.15, 0.15],
            orientation: simd_quatf(angle: .pi * 3/2, axis: [0, 1, 0])
        ),
    ]
}
