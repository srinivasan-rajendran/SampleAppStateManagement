//
//  CounterView.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-05.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var state: Store<AppState, AppAction>
    @State var isPrimeModalPresented = false
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    state.send(.counter(CounterAction.decrTapped))
                }) {
                    Text("-")
                }
                Text("\(state.value.count)")
                Button(action: {
                    state.send(.counter(CounterAction.incrTapped))
                }) {
                    Text("+")
                }
            }
            Button(action: { isPrimeModalPresented = true }) {
                Text("Is this Prime?")
            }
        }
        .font(.title)
        .navigationBarTitle("Counter View")
        .sheet(isPresented: $isPrimeModalPresented, content: {
            PrimeModalView(state: state)
        })
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(state: Store<AppState, AppAction>(initialValue: AppState(), reducer: appReducer))
    }
}

