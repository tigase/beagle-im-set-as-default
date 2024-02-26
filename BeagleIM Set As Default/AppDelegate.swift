//
// AppDelegate.swift
//
// BeagleIM Set As Default
// Copyright (C) 2020 "Tigase, Inc." <office@tigase.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. Look for COPYING file in the top folder.
// If not, see https://www.gnu.org/licenses/.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private static let APP_BUNDLE_ID = "org.tigase.messenger.BeagleIM";

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let currentBundleId = LSCopyDefaultHandlerForURLScheme("xmpp" as CFString)?.takeRetainedValue();
        print(currentBundleId, currentBundleId as String?)
        if AppDelegate.APP_BUNDLE_ID == (currentBundleId as String?) {
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "BeagleIM is currently set as default app to open URI starting with xmpp:. Do you wish to keep as a default app it?";
            alert.addButton(withTitle: "Yes");
            alert.addButton(withTitle: "No");
            switch alert.runModal() {
            case .alertSecondButtonReturn:
                unsetAsDefault();
            default:
                break;
            }
        } else {
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "Do you wish to set BeagleIM as default app to open URI starting with xmpp: ?";
            alert.addButton(withTitle: "Yes");
            alert.addButton(withTitle: "No");
            switch alert.runModal() {
            case .alertFirstButtonReturn:
                setAsDefault();
            default:
                break;
            }
        }
        exit(0);
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func setAsDefault() {
        let result = LSSetDefaultHandlerForURLScheme("xmpp" as CFString, AppDelegate.APP_BUNDLE_ID as CFString);
        switch result {
        case 0:
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "BeagleIM will now open URIs starting with xmpp:";
            alert.addButton(withTitle: "OK");
            alert.runModal();
        default:
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "It was not possible to set BeagleIM as default app for xmpp: URI.\nError code: \(result)";
            alert.addButton(withTitle: "OK");
            alert.runModal();
        }
    }
    
    private func unsetAsDefault() {
        
        let result = LSSetDefaultHandlerForURLScheme("xmpp" as CFString, "None" as CFString);
        switch result {
        case 0:
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "BeagleIM will not open URIs starting with xmpp:";
            alert.addButton(withTitle: "OK");
            alert.runModal();
        default:
            let alert = NSAlert();
            alert.alertStyle = .informational;
            alert.messageText = "Set BeagleIM as default"
            alert.informativeText = "It was not possible to unset BeagleIM as default app for xmpp: URI.\nError code: \(result)";
            alert.addButton(withTitle: "OK");
            alert.runModal();
        }
    }


}

