//
//  DetailCountryWorker.swift
//  Countries
//
//  Created by Elina Batyrova on 03.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import Foundation
import SDWebImage

final class DetailCountryWorker {
    
    var imageDownloadManager: ImageDownloadManagerProtocol!
    
    init() {
        self.imageDownloadManager = ImageDownloadManager()
    }
    
    func getImages(from urls: [String], onSuccess: @escaping ([UIImage]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        var loadedImages: [UIImage] = []
        
        let dispatchGroup = DispatchGroup()
        
        for imageStringURL in urls {
            dispatchGroup.enter()
            self.imageDownloadManager.downloadImage(from: URL(string: imageStringURL)!, success: { (image) in
                if let image = image {
                    loadedImages.append(image)
                }
                
                dispatchGroup.leave()
            }) { (error) in
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            onSuccess(loadedImages)
        }
    }
}
