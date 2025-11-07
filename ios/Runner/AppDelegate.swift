import UIKit
import Flutter
import GoogleMaps
import GooglePlaces

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Provide your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyDQJC-cQjiKA_M_YCJbbefHMLCzBwzp1zs")
    // Provide your Google Places API key
    GMSPlacesClient.provideAPIKey("AIzaSyDQJC-cQjiKA_M_YCJbbefHMLCzBwzp1zs")

    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
