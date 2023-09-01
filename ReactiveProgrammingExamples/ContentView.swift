import SwiftUI

struct ContentView: View {
    var body: some View {
            
            List {
                Section("Combine") {
                    NavigationLink {
                        CombineSingleFieldView(viewModel: .empty)
                    } label: {
                        Text("Single Field Changes")
                    }
                    
                    NavigationLink {
                        CombineMultipleFieldView(viewModel: .empty)
                    } label: {
                        Text("Multiple Field Changes")
                    }
                    
                    NavigationLink {
                        CombineUserInputView(viewModel: .empty)
                    } label: {
                        Text("User Input")
                    }
                    
                    NavigationLink {
                        CombineInputValidationView()
                    } label: {
                        Text("Validation")
                    }
                }
            }
        .navigationTitle("Combine vs Closures")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
