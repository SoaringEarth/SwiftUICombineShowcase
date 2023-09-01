import SwiftUI
import Combine

class CombineMultipleFieldViewModel: ObservableObject {
    
    @Published var aString: String
    @Published var bString: String
    @Published var cString: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        aString = ""
        bString = ""
        cString = ""
        setupListeners()
    }
    
    private func setupListeners() {
        Publishers.CombineLatest($aString, $bString)
            .receive(on: DispatchQueue.main)
            .map { a, b in
                guard let a = Int(a), let b = Int(b) else { return "" }
                return "\(a + b)"
            }
            .sink { [weak self] total in
                self?.cString = total
            }
            .store(in: &cancellables)
    }
    
    func generateA() {
        aString = "\(Int.random(in: 0..<100))"
    }
    
    func generateB() {
        bString = "\(Int.random(in: 0..<100))"
    }
    
    func clear() {
        aString = ""
        bString = ""
        cString = ""
    }
}

extension CombineMultipleFieldViewModel {
    static var empty: CombineMultipleFieldViewModel {
        .init()
    }
}

struct CombineMultipleFieldView: View {

    @StateObject var viewModel: CombineMultipleFieldViewModel

    var body: some View {
        VStack {
            HStack {
                Text("a: \(viewModel.aString)")
                Text(" + ")
                Text("b: \(viewModel.bString)")
                Text(" = ")
                Text("c: \(viewModel.cString)")
            }
            
            HStack() {
                Button("Generate A", action: {
                    viewModel.generateA()
                })
                .buttonStyle(.borderedProminent)
                
                Button("Generate B", action: {
                    viewModel.generateB()
                })
                .buttonStyle(.borderedProminent)
                
                Button("Clear", action: {
                    viewModel.clear()
                })
                .buttonStyle(.borderless)
            }
        }
    }
}

struct CombineMultipleFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CombineMultipleFieldView(viewModel: .empty)
    }
}
