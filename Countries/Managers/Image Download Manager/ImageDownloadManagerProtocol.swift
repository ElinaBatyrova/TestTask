//
//  ImageDownloadManagerProtocol.swift
//  Countries
//
//  Created by Elina Batyrova on 15.10.2018.
//  Copyright © 2018 Elina. All rights reserved.
//

import UIKit

protocol ImageDownloadManagerProtocol: class {
    func downloadImage(from url: URL, success: @escaping (UIImage?) -> Void, failure: @escaping (String) -> Void)
}
