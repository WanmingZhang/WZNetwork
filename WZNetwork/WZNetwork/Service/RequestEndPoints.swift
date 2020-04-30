//
//  RequestEndPoints.swift
//  WZNetwork
//
//  Created by Zhang, Wanming on 4/30/20.
//  Copyright © 2020 WZ. All rights reserved.
//

import Foundation

public protocol RequestEndPoints {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
