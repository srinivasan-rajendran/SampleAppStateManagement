//
//  PrimeModalView.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-05.
//

import SwiftUI

struct PrimeModalView: View {
    @ObservedObject var state: Store<AppState, AppAction>
    var body: some View {
        VStack {
            if isPrime(state.value.count) {
                Text("\(state.value.count) is a Prime 🥳")
                if state.value.favouritePrimes.contains(state.value.count) {
                    Button(action: {
                        state.send(.primeModal(PrimeModalAction.removeFavPrimesTapped))
                    }) {
                        Text("Remove from Favorite primes")
                    }
                } else {
                    Button(action: {
                        state.send(.primeModal(PrimeModalAction.saveFavPrimesTapped))
                    }) {
                        Text("Save to favourite primes")
                    }
                }

            } else {
                Text("\(state.value.count) is not a Prime 🚨")
            }
        }
        .font(.title2)
    }

    private func isPrime (_ p: Int) -> Bool {
      if p <= 1 { return false }
      if p <= 3 { return true }
      for i in 2...Int(sqrtf(Float(p))) {
        if p % i == 0 { return false }
      }
      return true
    }
}

struct PrimeModalView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeModalView(state: Store<AppState, AppAction>(initialValue: AppState(), reducer: appReducer))
    }
}
