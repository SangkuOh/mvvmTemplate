//
//  Endpoint.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//
import Foundation

protocol Endpoint {
    associatedtype Response: Decodable
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}
