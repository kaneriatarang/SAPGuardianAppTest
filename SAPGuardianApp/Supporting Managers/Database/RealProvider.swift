//
//  RealProvider.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import RealmSwift

//MARK: - RealmProvider
struct RealmProvider {
    
    //MARK: - Stored Properties
    let configuration: Realm.Configuration
    static let realmKeyChain = "Realm_Encryption_Key"
    
    //MARK: - Init
    internal init(config: Realm.Configuration) {
        configuration = config
    }
    
    //MARK: - Init
    private var realm: Realm? {
        do {
            return try Realm(configuration: configuration)
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Configuration
    // With Encryption Realm Configuration
    private static let defaultConfig = Realm.Configuration(encryptionKey: getRealmEncryptionKey(), schemaVersion: 1)
    // With out Encryption Realm Configuration with custom file URL
    private static let mainConfig = Realm.Configuration(
        fileURL:  URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 1)
    
    
    //MARK: - Realm Instances
    public static var `default`: Realm? = {
        return RealmProvider(config: RealmProvider.defaultConfig).realm
    }()
    public static var main: Realm? = {
        return RealmProvider(config: RealmProvider.mainConfig).realm
    }()
    
    //MARK: - Realm Instances
    static func getRealmEncryptionKey() -> Data {
        
        if let receivedData = KeyChainManager.load(key: realmKeyChain) {
            return receivedData
        }
        
        var encryptionKey = Data(count: 64)
        _ = encryptionKey.withUnsafeMutableBytes { bytes in
            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        }
        
        let _ = KeyChainManager.save(key: realmKeyChain, data: encryptionKey)
        
        return encryptionKey
    }
}

extension URL {
    
    // returns an absolute URL to the desired file in documents folder
    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
}
