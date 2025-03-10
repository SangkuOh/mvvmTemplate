//
//  NetworkError.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//
import Foundation

import Foundation

enum NetworkError: Error, LocalizedError {
  case invalidURL
  case invalidResponse
  case httpError(statusCode: Int, data: Data)
  case decodingError(Error)
  case tokenExpired
  case underlying(Error)

  var errorDescription: String? {
    switch self {
      case .invalidURL:
        return "유효하지 않은 URL입니다."
      case .invalidResponse:
        return "유효하지 않은 응답을 받았습니다."
      case .httpError(let statusCode, _):
        return "HTTP 오류가 발생했습니다. 상태 코드: \(statusCode)"
      case .decodingError(let error):
        return "디코딩 중 오류가 발생했습니다: \(error.localizedDescription)"
      case .tokenExpired:
        return "토큰이 만료되었습니다."
      case .underlying(let error):
        return "알 수 없는 네트워크 오류가 발생했습니다: \(error.localizedDescription)"
    }
  }
}
