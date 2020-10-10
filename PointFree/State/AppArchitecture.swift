//
//  AppArchitecture.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-06.
//

import Foundation
import Combine

final class Store<Value, Action>: ObservableObject {
    @Published var value: Value
    let reducer: (inout Value, Action) -> Void

    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.value = initialValue
        self.reducer = reducer
    }

    func send(_ action: Action) {
        self.reducer(&value, action)
    }
}

// func pullback<LocalValue, GlobalValue, Action>(_ reducer: @escaping (inout LocalValue, Action) -> Void,
//                                               value: WritableKeyPath<GlobalValue, LocalValue>) -> (inout GlobalValue, Action) -> Void {
//    return { globalValue, action in
//        reducer(&globalValue[keyPath: value], action)
//    }
//}

func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(_ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
                                              value: WritableKeyPath<GlobalValue, LocalValue>,
                                              action: WritableKeyPath<GlobalAction, LocalAction?>) -> (inout GlobalValue, GlobalAction) -> Void {
   return { globalValue, globalAction in
        guard let localAction = globalAction[keyPath: action] else { return }
        reducer(&globalValue[keyPath: value], localAction)
   }
}

struct EnumKeyPath<Root, Value> {
    let extract: (Root) -> Value?
    let embed: (Value) -> Root
}

func counterReducer(state: inout Int, action: CounterAction) {
    switch action {
    case .incrTapped:
        state += 1
    case .decrTapped:
        state -= 1
    }
}

 func primeModalReducer(state: inout AppState, action: PrimeModalAction) {
    switch action {
    case .saveFavPrimesTapped:
        state.favouritePrimes.append(state.count)
        state.activityFeed.append(AppState.Activity(type: .addedFavorites(state.count)))
    case .removeFavPrimesTapped:
        state.favouritePrimes.removeAll(where: { $0 == state.count
        })
        state.activityFeed.append(AppState.Activity(type: .removedFavorites(state.count)))
    }
}

 func favoritePrimesReducer(state: inout FavouritePrimesState, action: FavPrimesAction) {
    switch action {
    case .deleteFavPrimes(let indexSet):
        for index in indexSet {
            let prime = state.favouritePrimes[index]
            state.favouritePrimes.remove(at: index)
            state.activityFeed.append(AppState.Activity(type: .removedFavorites(prime)))
        }
    }
}

 func combine<Value, Action>(_ reducers: (inout Value, Action) -> Void...) -> (inout Value, Action) -> Void {
    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}

let appReducer: (inout AppState, AppAction) -> Void = combine(
    pullback(counterReducer, value: \.count, action: \.counter),
    pullback(primeModalReducer, value: \.self, action: \.primeModal),
    pullback(favoritePrimesReducer, value: \.favouritePrimesState, action: \.favPrimes)
)

