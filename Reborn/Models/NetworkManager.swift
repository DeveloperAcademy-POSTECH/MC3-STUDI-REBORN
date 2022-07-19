//
//  NetworkManager.swift
//  Animals
//
//  Created by 정호윤 on 2022/07/12.
//

import Foundation

// MARK: - 네트워크에서 발생할 수 있는 에러 정의
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

// MARK: - 네트워킹 클래스
final class NetworkManager {
    
    // 여러 화면에서 통신하면 일반적으로 싱글톤으로 구현
    static let shared = NetworkManager()

    // 여러 객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    // Result 타입 typealias 설정
    typealias NetworkCompletion = (Result<[Item], NetworkError>) -> Void
    
    // 지역으로 유기동물 데이터 받아오기
    func fetchAnimal(locationQuery: String = Location.none, completion: @escaping NetworkCompletion) {
        let urlString = "\(AnimalApi.requestUrl)&\(AnimalApi.key)&\(AnimalApi.stateQuery)&\(AnimalApi.pageNumberQuery)&\(AnimalApi.numberOfRowsQuery)&\(locationQuery)"
        
        performRequest(with: urlString) { result in
            completion(result)
        }
    }

    
    // request 하는 함수(비동기)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            // 1. 에러 확인
            if let error = error {
                print(error)
                completion(.failure(.networkingError))
                return
            }
            
            // 2. 데이터 확인
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            // 3. 메서드 실행해서 결과를 받음
            if let animals = self.parseJSON(safeData) {
                completion(.success(animals))
            } else {
                completion(.failure(.parseError))
            }
        }
        
        // 4. task 시작
        task.resume()
    }
    
    // 받은 데이터 parse 하는 함수(동기)
    private func parseJSON(_ animalData: Data) -> [Item]? {
        do {
            // JSON 데이터 -> AnimalData 구조체
            let animalData = try JSONDecoder().decode(Animal.self, from: animalData)
            return animalData.response.body.items.item
        } catch {
            print(error)
            return nil
        }
    }

}
