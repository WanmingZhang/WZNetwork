//
//  JSONParameterEncoder.swift
//  WZNetwork
//
//  Created by Zhang, Wanming on 4/29/20.
//  Copyright © 2020 WZ. All rights reserved.
//

import Foundation

public protocol BodyParameterEncodingProtocol {
    func encodeToJson(urlRequest: inout URLRequest, with parameters: Parameters) throws
    func encodeAsKeyValuePairs(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public struct BodyParameterEncoder: BodyParameterEncodingProtocol {
    public func encodeToJson(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
    
    public func encodeAsKeyValuePairs(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let str = self.percentEscaped(parameters: parameters)
        let data = str.data(using: .utf8)
        urlRequest.httpBody = data
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func percentEscaped(parameters: [String:Any]) -> String {
        var arr = [String]()
        for (key, value) in parameters {
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let joined = escapedKey + "=" + escapedValue
            arr.append(joined)
        }
        return arr.joined(separator: "&")
    }
    
}
