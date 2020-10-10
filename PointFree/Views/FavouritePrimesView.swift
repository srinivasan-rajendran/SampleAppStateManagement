//
//  FavouritePrimesView.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-05.
//

import SwiftUI

struct FavouritePrimesView: View {
    @ObservedObject var state: Store<AppState, AppAction>
    var body: some View {
        List {
            ForEach(state.value.favouritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete(perform: { indexSet in
                state.send(.favPrimes(.deleteFavPrimes(indexSet)))
            })
        }
        .font(.title)
        .navigationTitle("Favorites Prime")
    }
}

struct FavouritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePrimesView(state: Store<AppState, AppAction>(initialValue: AppState(), reducer: appReducer))
    }
}
