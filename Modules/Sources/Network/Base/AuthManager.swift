//
//  AuthManager.swift
//  Modules
//
//  Created by 오상구 on 3/10/25.
//


import Foundation

actor AuthManager {
  static let shared = AuthManager()
  private(set) var token: String?

  private var isRefreshing = false
  private var refreshContinuations: [CheckedContinuation<String, Error>] = []

  func refreshToken() async throws -> String {
    if isRefreshing {
      return try await withCheckedThrowingContinuation { continuation in
        refreshContinuations.append(continuation)
      }
    }

    isRefreshing = true
    defer { isRefreshing = false }

    do {
      let newToken = try await callRefreshTokenAPI()
      token = newToken
      refreshContinuations.forEach { $0.resume(returning: newToken) }
      refreshContinuations.removeAll()
      return newToken
    } catch {
      refreshContinuations.forEach { $0.resume(throwing: error) }
      refreshContinuations.removeAll()
      throw error
    }
  }

  // 실제 토큰 갱신 API 호출 (여기서는 예시로 네트워크 딜레이만 주고 새 토큰 반환)
  private func callRefreshTokenAPI() async throws -> String {
    // 실제 구현에서는 URLSession을 이용하여 refresh token API 호출
    try await Task.sleep(nanoseconds: 1_000_000_000) // 1초 딜레이 시뮬레이션
    return "newAccessToken"
  }
}
