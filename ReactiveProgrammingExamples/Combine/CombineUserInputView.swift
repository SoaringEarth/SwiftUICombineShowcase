import SwiftUI
import Combine

class CombineUserInputViewModel: ObservableObject {
    
    @Published var inputtedText: String
    @Published var debouncedText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        inputtedText = ""
        setupListeners()
    }
    
    private func setupListeners() {
        $inputtedText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.debouncedText = text
            } )
            .store(in: &cancellables)
    }
}

extension CombineUserInputViewModel {
    static var empty: CombineUserInputViewModel {
        .init()
    }
}

struct CombineUserInputView: View {
    
    @StateObject var viewModel: CombineUserInputViewModel

    var body: some View {
        
        VStack {
            Text("Inputted Text: \(viewModel.debouncedText)")
            TextField("Add text here!", text: $viewModel.inputtedText)
        }
        .padding()
    }
}

struct CombineUserInputView_Previews: PreviewProvider {
    static var previews: some View {
        CombineUserInputView(viewModel: .empty)
    }
}
