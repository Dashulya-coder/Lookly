//
//  PhotoSaver.swift
//  Lookly
//
//  Created by Daria Ukshe on 11.06.2026.
//

import UIKit
import Photos

class PhotoSaver: NSObject {
    
    static func save(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            guard status == .authorized else {
                DispatchQueue.main.async { completion(false) }
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            DispatchQueue.main.async { completion(true) }
        }
    }
}
