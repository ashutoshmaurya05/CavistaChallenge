//
//  ContentView.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var challengeApi = ChallenegeApi()
    @State private var selected = 0

    var body: some View {
        NavigationView {
            if (challengeApi.dataHasLoaded) {
                VStack {
                    ChallengeTypeFilterView(challengeApi: challengeApi)
                    List(challengeApi.challengeData) { challengeData in
                        NavigationLink(destination: ChallengeDetailView(challengeData: challengeData)) {
                            ChallengeRowView(challengeData: challengeData)
                        }
                            .navigationBarTitle(Text(NSLocalizedString("navigation_title", comment: "Navigation Title")))
                    }
                }

            } else {
                Text(challengeApi.message)
            }
        }.onAppear(perform: {
            self.challengeApi.loadDataFromAPi()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
