//
//  ARViewContainer.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var manager: FaceTrackingManager
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face Tracking is not supportes on this device")
            return arView
        }
        
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
        
        manager.setup(arView: arView)  
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
