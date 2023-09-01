import SwiftUI
import Combine

class CombineSingleFieldViewModel: ObservableObject {
    
    @Published var randomNumber: Int
    @Published var singleFieldString: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        randomNumber = 0
        singleFieldString = ""
        setupListeners()
    }
    
    private func setupListeners() {
        $randomNumber
            .sink { [weak self] randomNumber in
                self?.singleFieldString = "\(randomNumber / 2)"
            }
            .store(in: &cancellables)
    }
    
    func generateRandomNumber() {
        randomNumber = Int.random(in: 0..<100)
    }
    
    func clear() {
        randomNumber = 0
        singleFieldString = ""
    }
}

extension CombineSingleFieldViewModel {
    static var empty: CombineSingleFieldViewModel {
        .init()
    }
}

struct CombineSingleFieldView: View {
    
    @StateObject var viewModel: CombineSingleFieldViewModel
    
    var body: some View {
        VStack {
            Text("Current Random Number: \(viewModel.randomNumber)")
            Text("Random number divided by 2: \(viewModel.singleFieldString)")
            Button {
                viewModel.generateRandomNumber()
            } label: {
                Text("Generate Random Number and divide it by 2")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                viewModel.clear()
            } label: {
                Text("Clear")
            }
            .buttonStyle(.borderless)
        }
    }
}

struct CombineSingleFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CombineSingleFieldView(viewModel: .empty)
    }
}
