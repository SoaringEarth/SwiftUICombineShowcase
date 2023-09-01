import SwiftUI
import Combine

class CombineInputValidationViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var isValid = false
    @Published var errorMessage = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $userInput
            .map { input in
                return !input.isEmpty && input.count >= 5
            }
            .assign(to: &$isValid)
        
        $isValid
            .map { isValid in
                return isValid ? "" : "Input must be at least 5 characters long"
            }
            .assign(to: &$errorMessage)
    }
    
    func validateInput() {
        // This function can be used to trigger validation manually if needed.
    }
}

struct CombineInputValidationView: View {
    @StateObject private var viewModel = CombineInputValidationViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $viewModel.userInput)
                .padding()
            
            Text(viewModel.errorMessage)
                .padding()
                .foregroundColor(.red)
            
            Button("Check Validation") {
                viewModel.validateInput()
            }
            .padding()
        }
        .onAppear {
            
        }
    }
}

struct CombineInputValidationView_Previews: PreviewProvider {
    static var previews: some View {
        CombineInputValidationView()
    }
}
