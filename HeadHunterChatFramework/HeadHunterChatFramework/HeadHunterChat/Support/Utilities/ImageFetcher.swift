//
//  ImageFetcher.swift
//  HeadHunterChat
//
//  Created by 12345 on 02.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import SDWebImage

typealias CompletionBlock = (UIImage?, URL?) -> Swift.Void

final class ImageFetcher {

    static func fetch(with url: URL?,
                      to: UIImageView,
                      completed: CompletionBlock? = nil) {
        to.sd_setShowActivityIndicatorView(true)
        to.sd_setIndicatorStyle(.gray)
        to.sd_setImage(with: url, completed: { (image, _, _, url) in
            completed?(image, url)
        })
    }
}
