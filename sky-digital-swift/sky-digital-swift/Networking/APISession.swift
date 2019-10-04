//
//  APISession.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Foundation

class APISession {
    
    //MARK: - Properties
    private static let BaseUrl = "https://sky-exercise.herokuapp.com"
    
    static var APIEndPoint : String {
        get {
            let value = "\(APISession.BaseUrl)/api"
            return value
        }
    }
    
    //MARK: - Request
    struct HTTPHeaderField {
        static let AplicationJSON = "application/json"
        static let ContentType = "Content-Type"
        static let VersionUser = "VersionUser"
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
    }
    
}
