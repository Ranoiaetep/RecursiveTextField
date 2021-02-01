import SwiftUI

public struct RecursiveTextField: View {
	@Binding public var textList: [String]
	public var index: Int = 0
	public var placeholder: String = "Placeholder"
	@State private var skipped: Bool = false
	@State private var nextRecursion: AnyView?
	
	public var body: some View {
		if !skipped {
			TextField(placeholder, text: $textList[index], onCommit: {
				if !textList[index].isEmpty {
					if !(textList.last?.isEmpty ?? false) {
						textList.append(String())
					}
					nextRecursion = AnyView(RecursiveTextField(textList: $textList, index: index + 1, placeholder: placeholder))
				} else if index != textList.count - 1 {
					skipped = true
				}
			})
		}
		nextRecursion
	}
}
