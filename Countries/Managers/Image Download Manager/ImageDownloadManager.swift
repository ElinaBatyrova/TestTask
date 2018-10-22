//
//  ImageDownloadManager.swift
//  Countries
//
//  Created by Elina Batyrova on 15.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import SDWebImage

class ImageDownloadManager: ImageDownloadManagerProtocol {
    
    private let errorMessage = "Ошибка при загрузке изображения"
    let cacheNamespace = "cacher"
    
    func downloadImage(from url: URL, success: @escaping (UIImage?) -> Void, failure: @escaping (String) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var loadedImage: UIImage?
        var loadError: Error?
        
        dispatchGroup.enter()
        getFromCache(for: url.absoluteString) { (image) in
            loadedImage = image
            dispatchGroup.leave()
        }
        
        if loadedImage == nil {
            let manager = SDWebImageManager.shared()
            
            dispatchGroup.enter()
            manager.imageDownloader?.downloadImage(with: url, options: .highPriority, progress: nil, completed: { [weak self] (image, data, error, finished) in
                guard let strongSelf = self else { return }
                if (error == nil && (image != nil) && finished) {
                    loadedImage = image
                    strongSelf.saveToCache(image: image, for: url.absoluteString)
                    dispatchGroup.leave()
                } else {
                    loadError = error
                    dispatchGroup.leave()
                }
            })
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else { return }
            if loadError != nil {
                failure(strongSelf.errorMessage)
            } else {
                success(loadedImage)
            }
        }
    }
    
    func getFromCache(for key: String, completion: @escaping (UIImage?) -> Void) {
        SDImageCache.shared().queryCacheOperation(forKey: key) { (image, _, _) in
            completion(image)
        }
    }
    
    func saveToCache(image: UIImage?, for key: String) {
        SDImageCache.shared().store(image, forKey: key, toDisk: true, completion: nil)
    }
}
