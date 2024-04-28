//
//  KeyChainService.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import UIKit
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    func savePassword(username: String, password: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeyChainError.unknown
        }
    }
    
    func getPassword(username: String) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let passwordData = result as? Data else {
            throw KeyChainError.unknown
        }
        
        return passwordData
    }
}

enum KeyChainError: Error {
    case unknown
}
