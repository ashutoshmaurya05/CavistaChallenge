//
//  LocalDatabaseManager.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import Foundation
import RealmSwift

class LocalDatabaseManager {
    func getDataFromDB() -> [ChallengeData]? {
        let config = Realm.Configuration(schemaVersion: 1)
        do {
            let realm = try Realm(configuration: config)

            let result = realm.objects(LocalChallengeData.self)

            if result.count > 0 {
                let localData: [LocalChallengeData] = result.toArray()
                return LocalChallengeData().toChallengeData(localDataArray: localData)
            } else {
                return nil
            }
        } catch {
            print("Error in DB Fetch \(error.localizedDescription)")
            return nil
        }
    }

    func storeData(challengeData: [ChallengeData]) -> Bool {
        let config = Realm.Configuration(schemaVersion: 1)
        do {
            let realm = try Realm(configuration: config)

            for data in challengeData {
                let localData = LocalChallengeData()
                localData.id = data.id
                localData.type = data.type
                localData.date = data.date ?? NSLocalizedString("unknown", comment: "")
                localData.data = data.data ?? NSLocalizedString("unknown", comment: "")
                try realm.write({
                    realm.add(localData)
                })
            }
            return true
        } catch {
            print("Error in DB Storage \(error.localizedDescription)")
            return false
        }
    }
}

extension Results {
    func toArray() -> [LocalChallengeData] {
        return compactMap {
            $0 as? LocalChallengeData
        }
    }
}
