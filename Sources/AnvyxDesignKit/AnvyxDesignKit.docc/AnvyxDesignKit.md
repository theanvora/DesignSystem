# ``AnvyxDesignKit``

A reactive, theme-driven SwiftUI design system: dynamic tokens, Liquid Glass, and a set of ready-made components.

## Overview

AnvyxDesignKit centers on ``AnvyxTheme`` — an `@Observable` container of design
tokens (colors, spacing, radius, typography, motion, haptics) injected through the
SwiftUI environment. Mutating a token at runtime re-renders every view that reads
it, so runtime theming and dark mode "just work" without global mutable state.

```swift
@main
struct MyApp: App {
    @State private var theme = AnvyxTheme()
    var body: some Scene {
        WindowGroup {
            RootView()
                .anvyxTheme(theme)   // inject once
        }
    }
}

struct RootView: View {
    @Environment(\.anvyxTheme) private var theme
    var body: some View {
        Text("Hello").foregroundStyle(theme.colors.accent)
    }
}
```

Brand colors that need explicit light/dark (or increased-contrast) variants use
``SwiftUI/Color/init(light:dark:highContrastLight:highContrastDark:)``.

## Topics

### Theming
- ``AnvyxTheme``
- ``ColorPalette``
- ``Spacing``
- ``Radius``
- ``ThemeTypography``
- ``ThemeMotion``
- ``ThemeHaptics``
- ``FontFamily``
- ``FontRegistrar``

### Liquid Glass
- ``AnvyxGlassContainer``

### Components
- ``AnvyxTextField``
- ``AnvyxSegmentedControl``
- ``AnvyxStepper``
- ``RatingView``
- ``SkeletonList``
- ``AnvyxIcon``
- ``Chip``
- ``Card``
- ``Badge``
- ``EmptyStateView``
- ``PagedView``

### Feedback
- ``Toast``
- ``ToastQueue``
- ``PrimaryButtonStyle``
- ``SecondaryButtonStyle``
- ``AsyncButton``
