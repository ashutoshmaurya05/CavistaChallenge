//
//  ChallengeDetailView.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChallengeDetailView: View {
    var challengeData: ChallengeData

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(challengeData.id).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.green)
                Text(challengeData.date!).font(.title2).foregroundColor(.blue).padding(.top, 2)
                if(challengeData.type == "image") {
                    WebImage(url: URL(string: challengeData.data!))
                        .resizable()
                        .placeholder(Image("placeholder_image"))
                        .scaledToFit()
                } else {
                    Text(challengeData.data!).font(.body)
                }
            }.padding()
        }
    }
}

struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeRowView(challengeData: ChallengeData(id: NSLocalizedString("id", comment: ""), type: NSLocalizedString("type", comment: ""), date: NSLocalizedString("date", comment: ""), data: NSLocalizedString("data", comment: "")))
    }
}
