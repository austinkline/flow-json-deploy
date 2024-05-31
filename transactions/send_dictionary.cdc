transaction(data: {String: AnyStruct}) {
    prepare(acct: &Account) {
        log(data)
    }
}