## v4.3.1 (32-bit: Revision 44552, 2014-09-09; 64-bit: 46552, 2014-09-09)

 * Fixed problem when building with XCode 6

## v4.3.0 (32-bit: Revision 44551, 2014-08-14; 64-bit: 46551, 2014-08-14)

 * Added attribution plugin capability
 * No longer inspects or reports the MAC address of the device

## *v4.2.1 (32-bit: Revision 44550, 2014-07-09; 64-bit: 46550, 2014-07-09)

 * Added ability to override configuration by app version
 * Minor configuration changes

## *v4.2.0 (32-bit: Revision 44549, 2014-06-24; 64-bit: 46549, 2014-06-24)

 * Added new event types to Debug UI
 * Removed URL handler verification from Debug UI
 * Extended timeout on configuration requests
	
## *v4.1.1* (32-bit: Revision 44548, 2014-06-02; 64-bit: 46548, 2014-06-02)

 * Minor bug fixes

## *v4.1.0* (32-bit: Revision 44547, 2014-04-08; 64-bit: 46547, 2014-04-08)

 * Added ability to optionally display ads
 * Added ability to detect the user's appstore country
 * No longer accessing UIPasteboard on iOS 7 for facebook ID purposes
 * 64-bit bug fix: allowing targeting of iOS 5.1, instead of requiring iOS 6.0

## *v4.0.0* (32-bit: Revision 44546, 2014-03-03; 64-bit: 46546, 2014-03-03)

 * Added support for cocoapods
 * Added new event types, with the enums defined below.
   1. `[FiksuTrackingManager uploadRegistration:(FiksuRegistrationEvent)event];`
   2. `[FiksuTrackingManager uploadPurchase:(FiksuPurchaseEvent)event price:(double)price currency:(NSString *)currency];`

```objc
typedef enum {
  FiksuRegistrationEvent1,
  FiksuRegistrationEvent2,
  FiksuRegistrationEvent3
} FiksuRegistrationEvent;

typedef enum {
  FiksuPurchaseEvent1,
  FiksuPurchaseEvent2,
  FiksuPurchaseEvent3,
  FiksuPurchaseEvent4,
  FiksuPurchaseEvent5
} FiksuPurchaseEvent;
```

## *v3.7.0* (32-bit only: Revision 44545, 2013-10-22)

 * Adjusted jailbroken device detection

## *v3.6.1* (32-bit: Revision 44544, 2013-10-17; 64-bit: Revision 46544, 2013-11-13)

 * No longer accessing UIPasteboard on iOS 7
 * Better subject for email submission to Fiksu
 * Support for 64-bit added 2013-11-13

## *v3.6* (Revision 44543, 2013-08-27)

 * Updated for iOS 7/Xcode 5
 * Added `[FiksuTrackingManager setAppTrackingEnabled:(BOOL)]` and `[FiksuTrackingManager isAppTrackingEnabled]`

## *v3.5.1* (Revision 44542, 2013-09-04) 

 * Added support for custom events via `[FiksuTrackingManager uploadCustomEvent]`
   * This replaces the call from _FiksuSDK 3.5_ for FMA Engagement events: `[FiksuTrackingManager uploadFMAEngagementEvent]`
 * Added custom events to Debug UI
 * Additional Debug UI cleanup

## *v3.5* (Revision 44541, 2013-07-18)

 * Added FMA Engagement events
 * Added request signing

## *v3.3* (Revision 44539, 2013-04-03)

 * Support for client generated ID by calling `[FiksuTrackingManager setClientID:...]`
 * Debug Mode providing visibility into URL configuration

## *v3.2.2* (Revision 44538, 2013-03-28)

 * All UDID references removed
 * Debug Mode bug fix
 
## *v3.2.1* (Revision 44537, 2013-02-08)

 * Moved SDK storage from `Documents/` to `Library/Application Support/com.fiksu.sdk/` or `Library/Caches/com.fiksu.sdk/`, in that order.

## *v3.2* (Revision 44536, 2012-12-26)

 * Added Facebook app attribution support

## *v3.1.1* (Revision 44535, 2012-11-19)

 * Addressed some issues with Debug mode

## *v3.1* (Revision 44534, 2012-11-19)

 * Added Fiksu Debug Mode for verifying proper SDK integration
 * Changed configuration of SDK from editing code to editing plists
 * Provided SDK as embedded framework for ease of integration

## *v3.0* (Revision 44531, 2012-09-13)

 * Using new AdSupport.framework for advertisingIdentifier

## Revision 44530 (2012-08-28)

 * Removed OpenUDID support
 * Enabled transmission of new iOS identifiers
 * Disabled HTML5 tracking by default
