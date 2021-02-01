import SwiftUI

public struct RecursiveTextField: View {
	@Binding var textList: [String]
	var index: Int
	var placeholder: String
	@State private var skipped: Bool = false
	@State private var nextRecursion: AnyView?
	
	public init(_ textList: Binding<[String]>) {
		self._textList = textList
		index = 0
		placeholder = "Placeholder"
	}
	
	public init(textList: Binding<[String]>,
				index: Int = 0,
				placeholder: String = "Placeholder") {
		self._textList = textList
		self.index = index
		self.placeholder = placeholder
	}
	
	public var body: some View {
		if !skipped {
			TextField(placeholder, text: $textList[index], onCommit: checkNextRecursion)
				.onAppear(perform: checkNextRecursion)
		}
		nextRecursion
	}
	
	func checkNextRecursion() {
		if !textList[index].isEmpty {
			if !(textList.last?.isEmpty ?? false) {
				textList.append(String())
			}
			nextRecursion = AnyView(RecursiveTextField(textList: $textList, index: index + 1, placeholder: placeholder))
		} else if index != textList.count - 1 {
			skipped = true
		}
	}
}
