//
//  NetworkService.swift
//  HomeLight
//
//  Created by Vitaly on 07.01.2025.
//

import Foundation

struct StatusResult: Codable {
    let status : Int
}



// TODO: добавить контроль активного запроса. Не отправлять второй, если еще выполняется первый

struct NetworkService {
    
    enum NetworkError: Error {
        case invalidURL
        case missingData
    }

   private func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return data
    }
    
    func turnOnLight() async throws{
        print("NET turnOnLight")
        guard let url = URL(string: "http://192.168.0.137/on1") else {
            throw NetworkError.invalidURL
        }

        // send request
        print("NET turnOnLight")
        _ = try await fetchData(from: url)
        print("NET turnOnLight")
    }
    
    func turnOffLight()  async throws {
        print("NET turnOffLight")
        guard let url = URL(string: "http://192.168.0.137/off1") else {
            throw NetworkError.invalidURL
        }

        // send request
        print("NET turnOffLight")
        _ = try await fetchData(from: url)
        print("NET turnOffLight")
    }
    
    func getLightStatus() async throws -> Int {
        print("NET getLightStatus")
        guard let url = URL(string: "http://192.168.0.137/status") else {
            throw NetworkError.invalidURL
        }

        // send request
        let data = try await fetchData(from: url)
        print("NET getLightStatus")
        // Parse the JSON data
        let statusResult = try JSONDecoder().decode(StatusResult.self, from: data)
        print("NET getLightStatus \(statusResult)")
        return statusResult.status
    }
}
