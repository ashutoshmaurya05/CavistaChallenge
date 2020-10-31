//
//  ChallengeTypeFilterView.swift
//  iOSChallenge
//
//  Created by Ashutosh Maurya on 31/10/20.
//

import SwiftUI

struct ChallengeTypeFilterView: View {
    @ObservedObject var challengeApi = ChallenegeApi()
    @State private var selected = 0
    var body: some View {
        Section {
            Picker(selection: $selected, label: Text("Types")) {
                ForEach(0 ..< challengeApi.challengeType.count) {
                    Text(self.challengeApi.challengeType[$0])
                }
            }.onChange(of: selected, perform: { value in
                challengeApi.filterBy(name: challengeApi.challengeType[value])
            })
                .padding()
        }.pickerStyle(SegmentedPickerStyle())
    }
}

struct ChallengeTypeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeTypeFilterView()
    }
}
