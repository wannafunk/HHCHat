//
//  NetworkServiceImpl.swift
//  HeadHunterChat
//
//  Created by 12345 on 19.06.2018.
//  Copyright © 2018 Stanislav Kramarenko. All rights reserved.
//

import UIKit
import Photos

typealias PhotoLibraryGranted = (_ status: PHAuthorizationStatus) -> Void

class PhotosServices: NSObject {

    func requestAccess(completion: @escaping PhotoLibraryGranted) {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .authorized:
            completion(status)
        case .notDetermined, .restricted:
            PHPhotoLibrary.requestAuthorization({ autorizationStatus in
                if autorizationStatus == .authorized {
                    completion(autorizationStatus)
                }
            })
        case .denied:
            completion(status)
        }
    }

}
