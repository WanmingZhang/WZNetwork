//
//  ParameterEncoding.swift
//  WZNetwork
//
//  Created by Zhang, Wanming on 4/29/20.
//  Copyright © 2020 WZ. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public enum ParameterEncoding {
    
    case urlEncoding
    case stringWithSpaceUrlEncoding
    case jsonEncoding
    case keyValueEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encodeWithComponent(urlRequest: &urlRequest, with: urlParameters)
           
            case .stringWithSpaceUrlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encodeStringWithSpaceComponent(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try BodyParameterEncoder().encodeToJson(urlRequest: &urlRequest, with: bodyParameters)
            
            case .keyValueEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try BodyParameterEncoder().encodeAsKeyValuePairs(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encodeWithComponent(urlRequest: &urlRequest, with: urlParameters)
                try BodyParameterEncoder().encodeToJson(urlRequest: &urlRequest, with: bodyParameters)
            }
        }catch {
            throw error
        }
    }
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

