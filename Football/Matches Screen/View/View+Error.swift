//
//  View+Error.swift
//  Football
//
//  Created by Shorouk Mohamed on 11/10/22.
//

import SwiftUI

extension View {
    func errorAlert(error: Binding<ResponseError?>, buttonTitle: String = Strings.ok) -> some View {
        var wrappedError = error.wrappedValue
        let isError = wrappedError != nil
        return alert(Strings.error, isPresented: .constant(isError)) {
            Button(buttonTitle) {
                wrappedError = nil
            }
        } message: {
            Text(ResponseError.unknown.localizedDescription)
        }

    }
}
