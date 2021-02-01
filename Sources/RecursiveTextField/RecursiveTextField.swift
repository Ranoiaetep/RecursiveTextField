import SwiftUI

// MARK: - Description
/**
Create a group of ``TextField``  that will recursively grow as new data are entered.

The following example shows a `RecursiveTextField` was created with an empty `textList`, one `TextField` will be created with *"Placeholder"* being the description:
```
@State var textList: [String]
RecursiveTextField($textList)
```
The following example shows a `RecursiveTextField`, where three `TextField` will be created, with the first two pre-filled with `"foo"` and `"bar"`:
```
@State var textList: [String] = ["foo", "bar"]
RecursiveTextField(textList: $textList, placeholder: "Input...")
```

- Author: Ranoiaetep
*/

public struct RecursiveTextField: View {
	// MARK: - Body
	public var body: some View {
		if !skipped {
			TextField(placeholder, text: $textList[index], onCommit: checkNextRecursion)
				.onAppear(perform: checkNextRecursion)
		}
		nextRecursion
	}
	
	// MARK: - Variables
	@Binding var textList: [String]
	var index: Int
	var placeholder: String
	@State private var skipped: Bool = false
	@State private var nextRecursion: AnyView?
}
	// MARK: - Init functions
public extension RecursiveTextField {
	/**
	- parameters:
		- textList: An array of `String` that will be modified through `TextField`.
	*/
	init(_ textList: Binding<[String]>) {
		self._textList = textList
		index = 0
		placeholder = "Placeholder"
		if self.textList.isEmpty {
			self.textList.append(String())
		}
	}

	/**
	- parameters:
		- textList: An array of `String` that will be modified through `TextField`.
		- placeholder: Default text to be displayed when no text was entered to `TextField` yet.
	*/
	init(textList: Binding<[String]>,
				placeholder: String = "Placeholder") {
		self._textList = textList
		index = 0
		self.placeholder = placeholder
		if self.textList.isEmpty {
			self.textList.append(String())
		}
	}
}

// MARK: Helper functions
extension RecursiveTextField {
	/// Helper function to check if next recursioned `TextField` shall be skipped.
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
