//
//  RequestManager.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import Alamofire

class RequestManager {
    
    // MARK: - Singleton
    static let shared = RequestManager()
    
    // MARK: - GET
    public func get<T:Codable>(_ url: String, model: T.Type, headers: HTTPHeaders = [:], completion: @escaping (T?) -> Void, onFailure: @escaping (Error) -> Void ) {
        
        guard let isInternet = NetworkReachabilityManager()?.isReachable else{ return }
        
        if (!isInternet){
            let error = NSError.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Dispositivo sem internet"])
            onFailure(error)
            return
        }
        
        var h = headers
        if let bundleVersion = Bundle.main.infoDictionary?[APISession.HTTPHeaderField.CFBundleShortVersionString] as? String {
            h[APISession.HTTPHeaderField.VersionUser] = bundleVersion
        }
        
        Alamofire.request(url, headers: h).validate().responseJSON { response in
            let statusCode = response.response?.statusCode
            print("statusCode: \(String(describing: statusCode))")
            if statusCode == 401 {
                let unauthorizeError = NSError(domain: "unauthorize.error", code: 401, userInfo:[NSLocalizedDescriptionKey : "Authorization has been denied for this request."])
                onFailure(unauthorizeError)
                return
            }
            
            switch response.result {
            case .success:
                do {
                    if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                        let json = try JSONDecoder().decode(model.self, from: data)
                        completion(json)
                    } else {
                        completion(nil)
                    }
                } catch {
                    onFailure(error)
                }
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
}
