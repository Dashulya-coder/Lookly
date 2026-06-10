//
//  FaceTrackingManager.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//


import ARKit
import RealityKit
import SwiftUI
import Combine

class FaceTrackingManager: NSObject, ObservableObject, ARSessionDelegate {
    
    @Published var selectedItem: AccessoryItem? = nil
    
    private weak var arView: ARView?
    private var faceAnchorEntity: AnchorEntity?
    private var currentEntity: ModelEntity?
    
    
    func setup(arView: ARView) {
        self.arView = arView
        arView.session.delegate = self
    }
    
    
    func loadAccessory(_ item: AccessoryItem) {
        // remove previous accessory
        currentEntity?.removeFromParent()
        currentEntity = nil
        
        guard case .model(let fileName) = item.content else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "usdz") else {
            print("File not found: \(fileName).usdz")
            return
        }
        
        do {
            let entity = try Entity.loadModel(contentsOf: url)
            
            // Position depends on category
            switch item.category {
            case .glasses:
                entity.position = [0, -0.01, 0.07]
                entity.scale = [1, 1, 1]
            case .hats:
                entity.position = [0, 0.18, -0.02]
                entity.scale = [1, 1, 1]
            }
            
            faceAnchorEntity?.addChild(entity)
            currentEntity = entity
            selectedItem = item
            
        } catch {
            print("Error downloading model: \(error)")
        }
    }
    
    func removeAccessory() {
        currentEntity?.removeFromParent()
        currentEntity = nil
        selectedItem = nil
    }
    
    // When ARKit finds face
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let arView else { return }
        
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else { continue }
            
            let anchorEntity = AnchorEntity(anchor: faceAnchor)
            arView.scene.addAnchor(anchorEntity)
            faceAnchorEntity = anchorEntity
            
            // If accessory was selected then put on
            if let item = selectedItem {
                loadAccessory(item)
            }
        }
    }
}
