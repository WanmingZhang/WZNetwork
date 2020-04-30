//
//  ThirdPartyServiceError.swift
//  WZNetwork
//
//  Created by Zhang, Wanming - (p) on 4/30/20.
//  Copyright © 2020 WZ. All rights reserved.
//

import Foundation

/**
Sample error response:
 
HTTP response code: 400
Response body:
{
    "code": 700,
    "error": "Not enough balance in your starbucks account."
}
**/

class ThirdPartyErrorResponse: NSObject, Decodable {
    private(set) var code: Int
    private(set) var error: String
    
    enum ThirdPartyErrorResponseCodingKeys: String, CodingKey {
        case code = "code"
        case error = "error"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ThirdPartyErrorResponseCodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        error = try container.decode(String.self, forKey: .error)
    }
}
