#import "DynamicNavigationDrawerPlugin.h"
#if __has_include(<dynamic_navigation_drawer/dynamic_navigation_drawer-Swift.h>)
#import <dynamic_navigation_drawer/dynamic_navigation_drawer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dynamic_navigation_drawer-Swift.h"
#endif

@implementation DynamicNavigationDrawerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDynamicNavigationDrawerPlugin registerWithRegistrar:registrar];
}
@end
