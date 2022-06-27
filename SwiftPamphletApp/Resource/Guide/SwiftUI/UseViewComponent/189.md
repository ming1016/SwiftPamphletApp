Form 今年也得到了增强，示例如下：
```swift
Form {
    Section {
        LabeledContent("Location") {
            AddressView(location)
        }
        DatePicker("Date", selection: $date)
        TextField("Description", text: $eventDescription, axis: .vertical)
            .lineLimit(3, reservesSpace: true)
    }
    
    Section("Vibe") {
        Picker("Accent color", selection: $accent) {
            ForEach(Theme.allCases) { accent in
                Text(accent.rawValue.capitalized).tag(accent)
            }
        }
        Picker("Color scheme", selection: $scheme) {
            Text("Light").tag(ColorScheme.light)
            Text("Dark").tag(ColorScheme.dark)
        }
#if os(macOS)
        .pickerStyle(.inline)
#endif
        Toggle(isOn: $extraGuests) {
            Text("Allow extra guests")
            Text("The more the merrier!")
        }
        if extraGuests {
            Stepper("Guests limit", value: $spacesCount, format: .number)
        }
    }
    
    Section("Decorations") {
        Section {
            List(selection: $selectedDecorations) {
                DisclosureGroup {
                    HStack {
                        Toggle("Balloons 🎈", isOn: $includeBalloons)
                        Spacer()
                        decorationThemes[.balloon].map { $0.swatch }
                    }
                    .tag(Decoration.balloon)
                    
                    HStack {
                        Toggle("Confetti 🎊", isOn: $includeConfetti)
                        Spacer()
                        decorationThemes[.confetti].map { $0.swatch }
                    }
                    .tag(Decoration.confetti)
                    
                    HStack {
                        Toggle("Inflatables 🪅", isOn: $includeInflatables)
                        Spacer()
                        decorationThemes[.inflatables].map { $0.swatch }
                    }
                    .tag(Decoration.inflatables)
                    
                    HStack {
                        Toggle("Party Horns 🥳", isOn: $includeBlowers)
                        Spacer()
                        decorationThemes[.noisemakers].map { $0.swatch }
                    }
                    .tag(Decoration.noisemakers)
                } label: {
                    Toggle("All Decorations", isOn: [
                        $includeBalloons, $includeConfetti,
                        $includeInflatables, $includeBlowers
                    ])
                    .tag(Decoration.all)
                }
#if os(macOS)
                .toggleStyle(.checkbox)
#endif
            }
            
            Picker("Decoration theme", selection: themes) {
                Text("Blue").tag(Theme.blue)
                Text("Black").tag(Theme.black)
                Text("Gold").tag(Theme.gold)
                Text("White").tag(Theme.white)
            }
#if os(macOS)
            .pickerStyle(.radioGroup)
#endif
        }
    }
    
}
.formStyle(.grouped)
```
