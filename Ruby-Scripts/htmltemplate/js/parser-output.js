var entities = [{
  "id": 1,
  "typeString": "struct",
  "properties": [
    {
  "name": "var appDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some Scene",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "name": "Schuylkill_AppApp",
  "superClass": 16
},{
  "id": 2,
  "typeString": "class",
  "properties": [
    {
  "name": "var wcSessionChannelDelegate: WatchSessionChannelDelegate",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "registerForRemoteNotifications()",
  "type": "instance",
  "accessLevel": "private"
}
  ],
  "protocols": [
    18,
    19
  ],
  "name": "AppDelegate",
  "superClass": 17
},{
  "id": 4,
  "typeString": "struct",
  "properties": [
    {
  "name": "let acceleration: Observable<CMAcceleration>?",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let accelerometerData: Observable<CMAccelerometerData>?",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let rotationRate: Observable<CMRotationRate>?",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let magneticField: Observable<CMMagneticField>?",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let deviceMotion: Observable<CMDeviceMotion>?",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "methods": [
    {
  "name": "init(motionManager: CMMotionManager)",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "name": "MotionManager"
},{
  "id": 11,
  "typeString": "struct",
  "properties": [
    {
  "name": "let motionActivity: Observable<CMMotionActivity>?",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "methods": [
    {
  "name": "init(motionActivityManager: CMMotionActivityManager)",
  "type": "instance",
  "accessLevel": "public"
}
  ],
  "name": "MotionActivityManager"
},{
  "id": 15,
  "typeString": "class",
  "methods": [
    {
  "name": "getFirstView<V : View>(status: UserData = UserData.shared) throws -> V",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "name": "ApplicationLoadFactory"
},{
  "id": 16,
  "typeString": "class",
  "name": "App"
},{
  "id": 17,
  "typeString": "class",
  "name": "NSObject"
},{
  "id": 18,
  "typeString": "protocol",
  "name": "UIApplicationDelegate"
},{
  "id": 19,
  "typeString": "protocol",
  "name": "UNUserNotificationCenterDelegate"
},{
  "id": 20,
  "typeString": "class",
  "name": "UIApplication",
  "extensions": [
    3
  ]
},{
  "id": 21,
  "typeString": "class",
  "name": "Reactive",
  "extensions": [
    5,
    6,
    7,
    8,
    12,
    13,
    14
  ]
},{
  "id": 22,
  "typeString": "class",
  "name": "Resolver",
  "extensions": [
    9,
    10
  ]
},{
  "id": 23,
  "typeString": "protocol",
  "name": "ResolverRegistering"
},{
  "id": 3,
  "typeString": "extension",
  "properties": [
    {
  "name": "var FIREBASE_INFO_PLIST : [[String:String]]?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let path",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let url",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let plist",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "setupWatchConnectivity(delegate : WatchSessionChannelDelegate) throws",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "UIApplication"
},{
  "id": 5,
  "typeString": "extension",
  "properties": [
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let e",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "manager(createMotionManager: @escaping () throws -> CMMotionManager =",
  "type": "type",
  "accessLevel": "public"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 6,
  "typeString": "extension",
  "properties": [
    {
  "name": "var acceleration: Observable<CMAcceleration>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var accelerometerData: Observable<CMAccelerometerData>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var rotationRate: Observable<CMRotationRate>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var magneticField: Observable<CMMagneticField>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var deviceMotion: Observable<CMDeviceMotion>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let motionManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 7,
  "typeString": "extension",
  "methods": [
    {
  "name": "memoize<D>(key: UnsafeRawPointer, createLazily: () -> Observable<D>) -> Observable<D>",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 8,
  "typeString": "extension",
  "properties": [
    {
  "name": "var pedometer: Observable<CMPedometerData>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let pedometer",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "pedometer(from: Date! = Date()) -> Observable<CMPedometerData>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "memoize<D>(key: UnsafeRawPointer, createLazily: () -> Observable<D>) -> Observable<D>",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 9,
  "typeString": "extension",
  "properties": [
    {
  "name": "var mock",
  "type": "type",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Resolver"
},{
  "id": 10,
  "typeString": "extension",
  "methods": [
    {
  "name": "register()",
  "type": "type",
  "accessLevel": "public"
}
  ],
  "protocols": [
    23
  ],
  "extendedEntityName": "Resolver"
},{
  "id": 12,
  "typeString": "extension",
  "properties": [
    {
  "name": "let activityManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let e",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "manager(createActivityManager: @escaping () throws -> CMMotionActivityManager =",
  "type": "type",
  "accessLevel": "public"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 13,
  "typeString": "extension",
  "properties": [
    {
  "name": "var motionActivity: Observable<CMMotionActivity>",
  "type": "instance",
  "accessLevel": "public"
},
    {
  "name": "let activityManager",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let operationQueue",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let data",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Reactive"
},{
  "id": 14,
  "typeString": "extension",
  "methods": [
    {
  "name": "memoize<D>(key: UnsafeRawPointer, createLazily: () -> Observable<D>) -> Observable<D>",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "Reactive"
}] 