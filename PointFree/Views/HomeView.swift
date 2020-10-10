//
//  ContentView.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-05.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var state: Store<AppState, AppAction>
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(state: state)) {
                    Text("Counter View")
                }
                NavigationLink(destination: FavouritePrimesView(state: state)) {
                    Text("Favorite Primes")
                }
            }
            .font(.title)
            .navigationTitle("State Management")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(state: Store<AppState, AppAction>(initialValue: AppState(), reducer: appReducer))
    }
}
