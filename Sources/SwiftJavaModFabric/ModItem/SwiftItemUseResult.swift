enum SwiftItemUseResult {
    case pass
    case success
    case consume
    case fail

    /// ItemEvents.USEでは処理せず、
    /// 他のlistener / vanilla Item.useへ処理を渡す
    case `delegate`
}
