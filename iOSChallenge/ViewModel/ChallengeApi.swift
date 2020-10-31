//
//  ChallengeApi.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import Foundation

class ChallenegeApi: ObservableObject, ChallengeDataObserver {
    @Published var dataHasLoaded = false
    @Published var challengeData: [ChallengeData] = [ChallengeData]()
    @Published var message: String = NSLocalizedString("loading", comment: "Initial Message.")
    @Published var challengeType: [String] = [String]()

    let challenegeDataManager = ChallengeDataManager()
    let localDBManager = LocalDatabaseManager()

    func loadDataFromAPi() {
        dataHasLoaded = false
        challenegeDataManager.registerForDataChange(observer: self)
    }

    func onSuccess(challengeData: [ChallengeData]) {
        self.challengeData = challengeData
        challengeType.append(NSLocalizedString("all", comment: ""))
        for challenge in self.challengeData {
            if !challengeType.contains(challenge.type) {
                challengeType.append(challenge.type)
            }
        }
        dataHasLoaded = true
    }

    func onFailure(errorMessage: String) {
        dataHasLoaded = false
        self.message = errorMessage
    }

    func filterBy(name: String) {
        DispatchQueue.global(qos: .background).async {
            var challengeDataWithName = [ChallengeData]()
            var challengeDataWithoutName = [ChallengeData]()
            let challengeDataFromDB = self.localDBManager.getDataFromDB()

            guard challengeDataFromDB != nil && challengeDataFromDB!.count > 0 else {
                print("No Data Present in DB.")
                return
            }

            for challenge in challengeDataFromDB! {
                if challenge.type == name {
                    challengeDataWithName.append(challenge)
                } else {
                    challengeDataWithoutName.append(challenge)
                }
            }
            challengeDataWithName.append(contentsOf: challengeDataWithoutName)
            DispatchQueue.main.async {
                self.dataHasLoaded = true
                self.challengeData = challengeDataWithName
            }
        }
    }
}
