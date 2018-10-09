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
    
    func getImages(from urls: [String], onSuccess: @escaping ([UIImage?]) -> Void, onFailure: @escaping (LoadError?) -> Void) {
        var loadedImages: [UIImage?] = []
        
        let dispatchGroup = DispatchGroup()
        
        for imageStringURL in urls {
            dispatchGroup.enter()
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: imageStringURL), options: [], progress: nil, completed: { (image, data, error, finished) in
                
                loadedImages.append(image)
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            onSuccess(loadedImages)
        }
    }
}
