import SwiftJava

enum FabricCallback {
    static func make<T: AnyJavaObject>(
        _ method: String,
        as type: T.Type
    ) -> T {
        let fabricLoaderClass = try! JavaClass<FabricLoader>()
    guard
        let loader = fabricLoaderClass.getInstance(),
        let containerOptional = loader.getModContainer(modID),
        let container = containerOptional.orElseThrow()
    else {
        fatalError("Failed to get ModContainer")
    }

    let languageAdapterClass = try! JavaClass<FabricLanguageAdapter>()
    guard let languageAdapter = languageAdapterClass.getDefault() else {
        fatalError("Failed to get LanguageAdapter")
    }

    let callbackClass = try! JavaClass<T>()

    do {
        return try languageAdapter.create(
            container,
            method,
            callbackClass
        )
    } catch {
        fatalError("Failed to create Fabric callback \(method): \(error)")
    }
    }
}