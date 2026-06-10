//
//  ContentView.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var manager = FaceTrackingManager()
    
    var body: some View {
        ZStack {
            
            ARViewContainer(manager: manager)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
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
    
    private func iconName(for category: AccessoryCategory) -> String {
        switch category {
        case .glasses: return "eyeglasses"
        case .hats:    return "bowler hat"
        }
    }
}
