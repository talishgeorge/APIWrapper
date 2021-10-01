extension Dictionary {

  // If a value exists for the specified key, it will be returned without invoking
  // `missingValueProvider`. If a value does not exist for the specified key, then it will be
  // created and stored in the dictionary by invoking `missingValueProvider`.
  //
  // Useful when a dictionary is used as a cache.
  mutating func value(for key: Key, missingValueProvider: () -> Value) -> Value {
    if let value = self[key] {
      return value
    } else {
      let value = missingValueProvider()
      self[key] = value
      return value
    }
  }

}
