# Gextensions

This Swift package provides a collection of extensions for String, Double, Float, Int64, Date, UITextView, and UIColor, offering utility methods and properties that simplify and enhance their usage in your iOS projects.


## Features

- **String Extensions: Subscript access, URL manipulation, regex-based search, and text trimming.
- **Number Extensions: Formatting methods for Double, Float, and Int64, with byte size conversions.
- **Date Extensions: Time interval calculations and date comparison utilities.
- **UI Extensions: Placeholder support for UITextView, color manipulation for UIColor.

## Installation

### Swift Package Manager (SPM)

To integrate `Gextensions` into your project using Swift Package Manager, add the following dependency in your `Package.swift` file:

```swift
.package(url: "https://github.com/mohamedaglan2225/GExtensions.git", from: "1.0.0")
```

## Usage

### 1. import Gextensions


```
import Gextensions
```


### 2.  String Extensions

```
let url = "https://example.com/search?q=swift"
let domain = url.domainFromURL
print("Domain: \(domain)")  // Output: "example.com"

let trimmedString = "  Hello, World!  ".trimmedAndStripped()
print("Trimmed: '\(trimmedString)'")  // Output: "Hello, World!"

```

### 3. Number Extensions

```
let number: Double = 1234.5678
print("Formatted (2 decimals): \(number.formattedWithTwoDecimals)")  // Output: "1234.57"

let fileSize: Int64 = 1048576
print("File Size: \(fileSize.formattedAsBytes)")  // Output: "1 MB"


```

### 4. Date Extensions

```

let date = Date()
let interval = date.timeIntervalToNow()
print("Time interval: \(interval) seconds")

let earlierDate = Date(timeIntervalSinceNow: -3600)
let difference = Date.timeDifference(lhs: date, rhs: earlierDate)
print("Difference: \(difference) seconds")

```


### 5. UI Extensions

```

let textView = UITextView()
textView.placeholderText = "Enter your text here..."

```


### 6. UIColor Manipulation

```

let color = UIColor.red
let lighterColor = color.lighter(by: 0.2)
let darkerColor = color.darker(by: 0.2)


```



