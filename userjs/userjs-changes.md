# changes (which I have made to the [arkenfox user.js](https://github.com/arkenfox/user.js))

- `privacy.trackingprotection.fingerprinting.enabled` = true - [FF67+] Blocks Fingerprinting

- `privacy.trackingprotection.cryptomining.enabled` = true - [FF67+] Blocks CryptoMining

- `privacy.trackingprotection.enabled` = true - Mozilla's built-in tracking protection

- `dom.event.clipboardevents.enabled` = false - Stops websites from logging if you copy, paste or cut something or where you do it.

- `network.http.referer.XOriginPolicy` = 2 - Only send Referer when the full hostnames match. If anything breaks, this can be set to 1; however, it is unlikely that this will be needed.

- `network.http.referer.XOriginTrimmingPolicy` = 2 - Only send scheme, host and port in Referer.

- *`keyword.enabled` = true - Allows you to use your default search engine(s) in the URL bar. This is the normal functionality of Firefox, however, the arkenfox user.js disables this.

- *`extensions.pocket.enabled` = false - Disables Firefox's pocket integration.

- `extensions.allowPrivateBrowsingByDefault` = true - Sets all add-ons to be enabled in private mode by default.

- `browser.privatebrowsing.autostart` = true - Sets Firefox to always been in private mode.

- `browser.urlbar.suggest.bookmark` = false - Disables suggestions in the URL bar based upon your bookmarks.

- `browser.urlbar.suggest.history` = false - Disables suggestions in the URL bar based upon your history.

- `browser.urlbar.suggest.openpage` = false - Disables suggestions in the URL bar based upon your open pages.

- `browser.urlbar.suggest.topsites` = false - Disables suggestions in the URL bar based upon your most visited sites.

- `geo.enabled = false` - Disables the geolocation functionality within Firefox.

- *`browser.ctrlTab.recentlyUsedOrder` = false - The Ctrl+Tab shortcut cycles to the next tab, instead of the most recently used tab.

- *`media.videocontrols.picture-in-picture.enabled` = false - Disables the picture-in-picture video controls.

- *`browser.warnOnQuit` = false - Firefox no longer warns you about closing mutliple tabs when you shut it down.

- `browser.safebrowsing.malware.enabled` = false - Disables blocking of "dangerous and deceptive content".

- `dom.security.https_only_mode` = true - forces websites to only use the HTTPS protocol

- `dom.security.https_only_mode_pbm` = true

- `dom.security.https_only_mode.upgrade_local` = true - upgrades all HTTP connections to HTTPS where possible

- `permissions.default.geo` = 2 - Geolocation permissions  [0:always ask; 1:allow; 2:block]

- `permissions.default.camera` = 2 - Camera permissions

- `permissions.default.microphone` = 2 - Microphone permissions

- *`permissions.default.desktop-notification` = 2 - Desktop notifications

- *`dom.vr.enabled` = false - Virtual Reality Permissions

- `media.autoplay.default` = 5 - Autoplay permissions [0:allow; 1:blockAudio; 5:blockAll]

- `media.autoplay.allow-extension-background-pages` = false - Allows background scripts from add-ons to autoplay audio media

- `media.autoplay.block-event.enabled` = true - Blocks further autoplay events

Anything marked with an asterisk (*) is only a matter of preference and is not a security or privacy measure. Safe browsing has been turned off because it uses Google services to enforce their safe browsing rules and I, personally, choose not to trust Google.
