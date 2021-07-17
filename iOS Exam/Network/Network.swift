//
//  Network.swift
//  Network

import Foundation
public protocol APIServiceCallProtocol: APIServiceProtocol {
    func getIntroductionList(completion: @escaping APIParsedResponse)
    func getPaymentTypeList(completion: @escaping APIParsedResponse)
}

class Network: APIService, APIServiceCallProtocol {
    func getIntroductionList(completion: @escaping APIParsedResponse) {
        loadMockData(fileName: "Introduction", modelType: IntroductionModel.self, completion: {(code, response, error) in
            completion(code, response, error)
        })
    }
    func getPaymentTypeList(completion: @escaping APIParsedResponse) {
        loadMockData(fileName: "PaymentTypeListInfo", modelType: PaymentType.self, completion: {(code, response, error) in
            completion(code, response, error)
        })
    }
}
