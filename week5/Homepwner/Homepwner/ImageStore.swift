//
//  ImageStore.swift
//  Homepwner
//
//  Created by JU HO YOON on 2017. 7. 31..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

class ImageStore {
    
    private let cache = NSCache<NSString, UIImage>()
    
    private func imageURL(forKey key: String) -> URL? {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentsDirectories.first else { return nil }
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    @discardableResult func setImage(_ image: UIImage, forKey key: String) -> Bool {
        cache.setObject(image, forKey: key as NSString)
        
        guard let imageURL = self.imageURL(forKey: key) else { return false }
        
        // 동메달 과제: PNG
        if let data = UIImagePNGRepresentation(image) {
            do {
                try data.write(to: imageURL, options: Data.WritingOptions.atomic)
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
        
        /* Default
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL, options: Data.WritingOptions.atomic)
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
        */
        
    }
    
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        guard let imageURL = self.imageURL(forKey: key),
            let imageFromDisk = UIImage(contentsOfFile: imageURL.path)
        else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        self.cache.removeObject(forKey: key as NSString)
        
        guard let imageURL = imageURL(forKey: key) else { return }
        
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
}
