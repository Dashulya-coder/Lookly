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
    @State private var flashOpacity: Double = 0
    @State private var showCatalog = false
    
    var body: some View {
        ZStack {
            
            ARViewContainer(manager: manager) { view in
                DispatchQueue.main.async {
                    arView = view
                }
            }
            .ignoresSafeArea()
            
            // Flash
            Color.white
                .opacity(flashOpacity)
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
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
                
                // Three buttons
                HStack(spacing: 24) {
                    
                    // Put off
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
                    }
                    
                    // Camera
                    Button {
                        takePhoto()
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    
                    // Catalog
                    Button {
                        showCatalog = true
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: "square.grid.2x2.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                            Text("Catalog")
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .sheet(isPresented: $showCatalog) {
            CatalogView(manager: manager, isPresented: $showCatalog)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        
    }
    
    //snapshot is no longer done in main stream!!!
    
    private func takePhoto() {
        guard let arView else { return }
        
        // Flash immediately
        withAnimation(.easeIn(duration: 0.1)) {
            flashOpacity = 1
        }
        withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
            flashOpacity = 0
        }
        
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
        case .hats:    return "bowlhat"
        }
    }
}
