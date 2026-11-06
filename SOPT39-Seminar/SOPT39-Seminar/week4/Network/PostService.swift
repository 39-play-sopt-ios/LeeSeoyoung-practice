//
//  PostService.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 11/6/26.
//

import Foundation

final class PostService {
    static let shared = PostService()
    
    private init() {}
    
    private func makeRequest(
        body: Data? = nil,
        method: String,
        postID: Int64? = nil,
        queryItems: [URLQueryItem] = []
    ) throws -> URLRequest {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: baseURL) else {
            throw NetworkError.urlError
        }
        
        let path = postID.map { "/api/v1/posts/\($0)" } ?? "/api/v1/posts"
        var endpointURL = url.appending(path: path)
        
        guard var components = URLComponents(
            url: endpointURL,
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.urlError
        }
        
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let requestURL = components.url else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method
        request.httpBody = body
        
        if body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    func fetchPosts(keyword: String) async throws -> PostListResponseDTO {
        let queryItems = keyword.isEmpty ? [] : [URLQueryItem(name: "keyword", value: keyword)]
        
        let request = try makeRequest(method: "GET", queryItems: queryItems)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(PostListResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
    
    func createPost(title: String, content: String, author: String, authorizationCode: String) async throws -> PostResponseDTO {
        let dto = PostCreateRequestDTO(
            title: title,
            content: content,
            author: author
        )
        let body = try JSONEncoder().encode(dto)
        var request = try makeRequest(body: body, method: "POST")
        request.setValue(authorizationCode, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(PostResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
    
    func deletePost(id: Int64?, authorizationCode: String) async throws -> PostDeleteResponseDTO {
        var request = try makeRequest(method: "DELETE", postID: id)
        request.setValue(authorizationCode, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(PostDeleteResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
