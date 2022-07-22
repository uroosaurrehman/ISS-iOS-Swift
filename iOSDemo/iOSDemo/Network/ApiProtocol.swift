//
//  ApiProtocol.swift
//  iOSDemo
//
//  Created by Uroosa on 07/22/22.
//

import Foundation
import UIKit

protocol ApiProtocol {
    func makeUrlRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case badURL
    case errorData
}
