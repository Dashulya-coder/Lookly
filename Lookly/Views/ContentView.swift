//
//  ContentView.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @StateObject private var manager = FaceTrackingManager()
    @State private var arView: ARView?
    @State private var showSavedBanner = false
    
    var body: some View {
        ZStack {
            
            ARViewContainer(manager: manager) { view in
                DispatchQueue.main.async {
                    arView = view
                }
            }
            .ignoresSafeArea()
            
            VStack {
                
                if showSavedBanner {
                    Text("Saved in gallery!")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .transition(.opacity)
                        .padding(.top, 60)
                }
                
                Spacer()
                
                HStack {
                    
                    Button {
                        takePhoto()
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                // Scrolling horizontally
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        
                        // Remove accessory
                        Button {
                            manager.removeAccessory()
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.white)
                                Text("Put off")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                            }
                            .padding(8)
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                        // Accessories
                        ForEach(AccessoryStore.items) { item in
                            Button {
                                manager.loadAccessory(item)
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: iconName(for: item.category))
                                        .font(.system(size: 36))
                                        .foregroundColor(.white)
                                    Text(item.name)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                .padding(8)
                                .background(
                                    manager.selectedItem?.id == item.id
                                        ? Color.blue.opacity(0.5)
                                        : Color.black.opacity(0.4)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    //snapshot is no longer done in main stream!!!
    
    private func takePhoto() {
        guard let arView else { return }
        
        arView.snapshot(saveToHDR: false) { image in
            guard let image else { return }
            
            // save in background
            DispatchQueue.global(qos: .background).async {
                PhotoSaver.save(image) { success in
                    // UI only in main
                    DispatchQueue.main.async {
                        if success {
                            withAnimation {
                                showSavedBanner = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSavedBanner = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func iconName(for category: AccessoryCategory) -> String {
        switch category {
        case .glasses: return "eyeglasses"
        case .hats:    return "bowler hat"
        }
    }
}
