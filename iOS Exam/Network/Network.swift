//
//  Network.swift
//  Network

import Foundation
public protocol APIServiceCallProtocol: APIServiceProtocol {
    func getMockList(completion: @escaping APIParsedResponse)
}

class Network: APIService, APIServiceCallProtocol {
    func getMockList(completion: @escaping APIParsedResponse) {
        loadMockData(fileName: "Mock", modelType: HomeDataModel.self, completion: {(code, response, error) in
            completion(code, response, error)
        })
    }
}
