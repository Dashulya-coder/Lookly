//
//  CatalogView.swift
//  Lookly
//
//  Created by Daria Ukshe on 06.06.2026.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var manager: FaceTrackingManager
    @Binding var isPresented: Bool
    @State private var selectedCategory: AccessoryCategory = .glasses
    
    // Filter items by category
    var filteredItems: [AccessoryItem] {
        AccessoryStore.items.filter { $0.category == selectedCategory }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Text("Catalog")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 12)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(AccessoryCategory.allCases, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category.rawValue)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    selectedCategory == category
                                        ? Color.blue
                                        : Color.white.opacity(0.15)
                                )
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 16)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredItems) { item in
                        Button {
                            manager.loadAccessory(item)
                            isPresented = false
                        } label: {
                            VStack(spacing: 8) {
                                // Then change to real photo
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.1))
                                        .aspectRatio(1, contentMode: .fit)
                                    
                                    Image(systemName: iconName(for: item.category))
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            manager.selectedItem?.id == item.id
                                                ? Color.blue
                                                : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                                
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.opacity(0.9))
    }
    
    private func iconName(for category: AccessoryCategory) -> String {
        switch category {
        case .glasses: return "eyeglasses"
        case .hats: return "bowlhat"
        }
    }
}
