access(all) contract Foo {
    access(all) let data: {String: AnyStruct}

    init(data: {String: AnyStruct}) {
        self.data = data
    }
}