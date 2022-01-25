//
//  Copyright 2022 Google LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI
import Firebase

struct AddNumbers: View {
  @State private var num1: String = ""
  @State private var num2: String = ""
  @State private var outcome: String = ""
  private var functions = Functions.functions()
  var body: some View {
    ZStack {
      BackgroundFrame(title: "AddNumbers", description: "Add two integers and output the sum.") {
        VStack {
          HStack {
            Spacer()
            TextField("", text: $num1).multilineTextAlignment(.center)
              .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray5)))
              .frame(width: ScreenDimensions.width * 0.2)
              .keyboardType(.numberPad)
            Text("+")
            TextField("", text: $num2).multilineTextAlignment(.center)
              .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray5)))
              .frame(width: ScreenDimensions.width * 0.2)
              .keyboardType(.numberPad)
            Spacer()
          }
          VStack {
            Text("\(outcome)")
            Button(action: {
              didTapCalculate()
            }) {
              Text("Calculate")
                .padding()
                .foregroundColor(.white)
                .background(Color("Amber400"))
            }
            .cornerRadius(16)
          }
        }
      }
    }
    .padding()
  }

  func didTapCalculate() {
    // [START function_add_message]
    functions.httpsCallable("addNumbers")
      .call(["firstNumber": $num1.wrappedValue,
             "secondNumber": $num2.wrappedValue]) { result, error in

        // [START function_error]
        if let error = error as NSError? {
          if error.domain == FunctionsErrorDomain {
            let code = FunctionsErrorCode(rawValue: error.code)
            let message = error.localizedDescription
            let details = error.userInfo[FunctionsErrorDetailsKey]
            print("Error Code: \(code!)")
            print("Error Message: \(message)")
            print("Error Details: \(details!)")
          }
          // [START_EXCLUDE]
          print(error)

          return
            // [END_EXCLUDE]
        }

        // [END function_error]
        print("The result is \(result?.data ?? "null")...")

        if let operationResult = (result?.data as? [String: Any])?["operationResult"] as? Int {
          self.outcome = String(operationResult)
        }
      }
  }
}

struct AddNumbers_Previews: PreviewProvider {
  static var previews: some View {
    AddNumbers()
  }
}