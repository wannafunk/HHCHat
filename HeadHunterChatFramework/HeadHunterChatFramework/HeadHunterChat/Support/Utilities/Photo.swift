//
//  Photo.swift
//  HeadHunterChat
//
//  Created by 12345 on 16.07.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import Foundation
import NYTPhotoViewer

final class Photo: NSObject, NYTPhoto {

    var image: UIImage?

    var imageData: Data?

    var placeholderImage: UIImage?

    var attributedCaptionTitle: NSAttributedString?

    var attributedCaptionSummary: NSAttributedString?

    var attributedCaptionCredit: NSAttributedString?

}
