//
import Foundation

actor NetworkService {
  private let session: URLSession
  private let decoder: JSONDecoder

  init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
    self.session = session
    self.decoder = decoder
  }

  func request<E: Endpoint>(for endpoint: E) async throws -> E.Response {
    var urlComponents = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: false)
    if let items = endpoint.queryItems {
      urlComponents?.queryItems = items
    }
    guard let finalURL = urlComponents?.url else {
      throw NetworkError.invalidURL
    }

    var request = URLRequest(url: finalURL)
    request.httpMethod = endpoint.method.rawValue
    if let token = await AuthManager.shared.token {
      var headers = endpoint.headers ?? [:]
      headers["Authorization"] = "Bearer \(token)"
      request.allHTTPHeaderFields = headers
    }
    request.httpBody = endpoint.body

    return try await perform(request: request, for: endpoint)
  }

  private func perform<E: Endpoint>(request: URLRequest, for endpoint: E) async throws -> E.Response {
    do {
      let (data, response) = try await session.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse else {
        throw NetworkError.invalidResponse
      }

      if httpResponse.statusCode == 401 {
        let newToken = try await AuthManager.shared.refreshToken()
        var retryRequest = request
        var headers = retryRequest.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Bearer \(newToken)"
        retryRequest.allHTTPHeaderFields = headers

        let (retryData, retryResponse) = try await session.data(for: retryRequest)
        guard let retryHTTPResponse = retryResponse as? HTTPURLResponse else {
          throw NetworkError.invalidResponse
        }

        if retryHTTPResponse.statusCode == 401 {
          throw NetworkError.tokenExpired
        }

        guard (200...299).contains(retryHTTPResponse.statusCode) else {
          throw NetworkError.httpError(statusCode: retryHTTPResponse.statusCode, data: retryData)
        }

        return try decoder.decode(E.Response.self, from: retryData)
      }

      guard (200...299).contains(httpResponse.statusCode) else {
        throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
      }

      return try decoder.decode(E.Response.self, from: data)
    } catch {
      throw NetworkError.underlying(error)
    }
  }
}
