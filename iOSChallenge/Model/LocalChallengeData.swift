//
//  LocalChallengeData.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import Foundation
import RealmSwift

class LocalChallengeData: Object {
    override init() {
    }
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var date = ""
    @objc dynamic var data = ""
}

extension LocalChallengeData {
    func toChallengeData(localDataArray: [LocalChallengeData]) -> [ChallengeData] {
        var challengeDataArray = [ChallengeData]()
        for localData in localDataArray {
            challengeDataArray.append(ChallengeData(id: localData.id, type: localData.type, date: localData.date, data: localData.data))
        }
        return challengeDataArray
    }
}
