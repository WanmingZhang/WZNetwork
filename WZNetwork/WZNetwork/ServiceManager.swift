//
//  ServiceManager.swift
//  WZNetwork
//
//  Created by Zhang, Wanming on 4/30/20.
//  Copyright © 2020 WZ. All rights reserved.
//

import Foundation

public enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

public enum Result<String>{
    case success
    case failure(String)
}

@objc public class NetworkManager: NSObject {
    
    @objc public static let sharedManager = NetworkManager() //Singleton instance
    private override init() {} //This prevents others from using the default '()' initializer for this class.

    public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299:                 return .success
        case 401...500:                 return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:                 return .failure(NetworkResponse.badRequest.rawValue)
        case 600:                       return .failure(NetworkResponse.outdated.rawValue)
        default:                        return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
