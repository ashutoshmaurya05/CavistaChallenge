//
//  ChallengeRowView.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import SwiftUI

struct ChallengeRowView: View {
    var challengeData: ChallengeData

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(challengeData.id).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.green).bold()
                Spacer()
                Text(challengeData.date!).font(.title3).foregroundColor(.blue)
                Text(challengeData.data!).font(.body).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ChallengeRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChallengeRowView(challengeData: ChallengeData(id: NSLocalizedString("id", comment: ""), type: NSLocalizedString("type", comment: ""), date: NSLocalizedString("date", comment: ""), data: NSLocalizedString("data", comment: "")))

            ChallengeRowView(challengeData: ChallengeData(id: NSLocalizedString("id", comment: ""), type: NSLocalizedString("type", comment: ""), date: NSLocalizedString("date", comment: ""), data: NSLocalizedString("data", comment: "")))
        }.previewLayout(.fixed(width: 400, height: 110))
    }
}
