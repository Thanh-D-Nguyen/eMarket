//
//  StoreInteractor.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

protocol StoreInteractorProtocol: AnyObject {
    func getStoreInfomation(completion: @escaping (Result<Store?, RequestError>) -> Void)
    func getProducts(completion: @escaping (Result<[Product]?, RequestError>) -> Void)
    func order(_ item: Order, completion: @escaping (Result<Bool, RequestError>) -> Void)
}

class StoreInteractor {
    private var urlSession = URLSession(configuration: .default)
    
    var decoder = JSONDecoder()
    
    private func request(method: HTTPMethod, components: URLComponents, headers: [HTTPHeader], body: Data?, completion: @escaping (Result<Data?, RequestError>) -> Void) {
        guard let url = components.url else {
            completion(.failure(.init(message: "Invalid URL")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        for header in headers {
            request.add(header: header)
        }
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.init(message: "Can't get response")))
                return
            }
            if let error = error as NSError? {
                completion(.failure(.init(message: "\(response.statusCode): \(error.localizedDescription)")))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    private func get(path: String, queryItems: [URLQueryItem]? = nil, completion: @escaping (Result<Data?, RequestError>) -> Void) {
        var components = components(path: path)
        components.queryItems = queryItems
        request(method: .get, components: components, headers: defaultHeaders(), body: nil, completion: completion)
    }
    
    private func post(path: String, body: Data? = nil, completion: @escaping (Result<Data?, RequestError>) -> Void) {
        let components = self.components(path: path)
        let header = [HTTPHeader(field: .contentType, value: "text/plain")]
        request(method: .post, components: components, headers: header, body: body, completion: completion)
    }
    
    private func components(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.baseURL
        components.path = path
        return components
    }
    
    private func defaultHeaders() -> [HTTPHeader] {
        var headers: [HTTPHeader] = []
        headers.append(HTTPHeader(field: .contentType, value: "application/json"))
        return headers
    }
}
extension StoreInteractor: StoreInteractorProtocol {
    
    func getStoreInfomation(completion: @escaping (Result<Store?, RequestError>) -> Void) {
        get(path: "/storeInfo", queryItems: nil) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.init(message: "Can't get store data")))
                    return
                }
                let store = try? self.decoder.decode(Store.self, from: data)
                completion(.success(store))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProducts(completion: @escaping (Result<[Product]?, RequestError>) -> Void) {
        //storeID: Int -> Which store have Products
        get(path: "/products", queryItems: nil) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.init(message: "Can't get products data")))
                    return
                }
                let products = try? self.decoder.decode([Product].self, from: data)
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func order(_ item: Order, completion: @escaping (Result<Bool, RequestError>) -> Void) {
        let body = try? item.jsonData()
        #if DEBUG
        if let body = body {
            let dataToPostJson = String(data: body, encoding: .utf8)
            print(dataToPostJson ?? "")
        }
        #endif
        post(path: "/order", body: body) { result in
            switch result {
            case .success(let data):
                guard data != nil else {
                    completion(.failure(.init(message: "Sorry, Order failed, please try again later!")))
                    return
                }
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
