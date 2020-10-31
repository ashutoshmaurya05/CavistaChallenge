//
//  ChallengeDataManager.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import Foundation
import RealmSwift
import Alamofire

protocol ChallengeDataObserver {
    func onSuccess(challengeData: [ChallengeData])
    func onFailure(errorMessage: String)
}

class ChallengeDataManager {
    private let SERVICE_URL = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    var challenegData: [ChallengeData]?
    let dbManager = LocalDatabaseManager()

    func registerForDataChange(observer: ChallengeDataObserver) {
        DispatchQueue.global(qos: .background).async {

            // Case 1: Data available inApp.
            if self.challenegData != nil && self.challenegData!.count > 0 {
                DispatchQueue.main.async {
                    observer.onSuccess(challengeData: self.challenegData!)
                }
                return
            }

            // Case 2: Data available in DB.
            if self.isChallengeDataAvailable() {
                self.registerForDataChange(observer: observer)
                return
            }

            // Case 3: Fetch Data from Server.
            guard let url = URL(string: self.SERVICE_URL) else {
                DispatchQueue.main.async {
                    observer.onFailure(errorMessage: NSLocalizedString("url_error", comment: "Error Message when URL is invalid."))
                }
                return
            }

            AF.request(url).response { response in
                if let data = response.data {
                    if let decodedResponse = try? JSONDecoder().decode([ChallengeData].self, from: data) {
                        if self.dbManager.storeData(challengeData: decodedResponse) {
                            self.registerForDataChange(observer: observer)
                        } else {
                            DispatchQueue.main.async {
                                observer.onFailure(errorMessage: NSLocalizedString("db_storage_error", comment: "When failed to write to DB."))
                            }
                        }
                        return
                    }
                }
                DispatchQueue.main.async {
                    observer.onFailure(errorMessage: NSLocalizedString("db_server_error", comment: "When failed to get data from Server."))
                }
            }.resume()
        }
    }

    func isChallengeDataAvailable() -> Bool {
        challenegData = dbManager.getDataFromDB()
        return challenegData != nil && challenegData!.count > 0
    }
}


