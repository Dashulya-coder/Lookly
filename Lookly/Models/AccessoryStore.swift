//
//  AccessoryStore.swift
//  Lookly
//
//  Created by Daria Ukshe on 10.06.2026.
//

struct AccessoryStore {
    static let items: [AccessoryItem] = [
        AccessoryItem(
            name: "Sun",
            category: .glasses,
            content: .model(usdzFileName: "glasses_01"),
            thumbnailName: "glasses_01_thumb"
        ),
        AccessoryItem(
            name: "Transparent",
            category: .glasses,
            content: .model(usdzFileName: "glasses_02"),
            thumbnailName: "glasses_02_thumb"
        ),
        AccessoryItem(
            name: "Winter Hat",
            category: .hats,
            content: .model(usdzFileName: "hat_01"),
            thumbnailName: "hat_01_thumb"
        ),
    ]
}
