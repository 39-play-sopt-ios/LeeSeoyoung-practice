//
//  SignupService.swift
//  SOPT39-Seminar
//
//  Created by Seoyoung Lee on 10/31/26.
//

import Foundation

final class SignupService {
    static let shared = SignupService()
    
    private init() {}
    
    private func makeRequestBody(part: String) throws -> Data {
        do {
            return try JSONEncoder().encode(SignupRequestDTO(part: part))
        } catch {
            throw NetworkError.requestEncodingError
        }
    }
    
    private func makeRequest(body: Data) throws -> URLRequest {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: baseURL) else {
            throw NetworkError.urlError
        }
        
        var request = URLRequest(
            url: url.appending(path: "/api/v1/members/authorization-code")
        )
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        
        return request
    }
    
    func postSignup(part: String) async throws -> SignupResponseDTO {
        let body = try makeRequestBody(part: part)
        let request = try makeRequest(body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseError
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(SignupResponseDTO.self, from: data)
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
