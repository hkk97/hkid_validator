'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"main.dart.js": "5cfc07e55b5f231af7ef2a9a829d5578",
"assets/AssetManifest.json": "02961f8ccb2e8e378a08f968a318bd05",
"assets/apple-touch-icon-76x76-precomposed.png": "edcd075e9e9ab81165e437d19ba8373f",
"assets/apple-touch-icon-72x72.png": "c05eacedf7935728cd9ad21230024d63",
"assets/favicon-16x16.png": "18d59c1773c7cc25b03f87ca96ddf445",
"assets/apple-touch-icon-60x60.png": "4b9f4e48fc16c2659367f810a81b3853",
"assets/apple-touch-icon-180x180.png": "7eaa331ef1d02983f99f6350f727d923",
"assets/apple-touch-icon-precomposed.png": "532a41e73aecfe8836e71c2db8bb7b5a",
"assets/favicon.ico": "4a71e949ab0117b847950cf3e200af00",
"assets/assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/FontManifest.json": "f66aa55cd79651f341aedd8491362eea",
"assets/assets/icons/chrome_512x512.png": "657cef546129e8a3dce4eaff547ec272",
"assets/assets/icons/android_512x512.png": "1a751010e6e2cd2ca6610421ee06ba19",
"assets/assets/icons/ios_512x512.png": "2c942a27a5180caf2ec0ca1675080fc7",
"assets/apple-touch-icon-72x72-precomposed.png": "147517598c1f7a1bc2e763023a6b76f9",
"assets/mstile-150x150.png": "3a764ccf97f9af44f02ec57e203116ee",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/shaders/ink_sparkle.frag": "bfd223fd128d659ff8813253d56be66f",
"assets/mstile-144x144.png": "e1c471245a99c596c55782e18d0658a4",
"assets/browserconfig.xml": "611957d3c640a84b4d2a6812e2b0cf52",
"assets/apple-touch-icon-114x114.png": "9cdf6a59d48ffa17b6285db2280c0fe1",
"assets/apple-touch-icon-144x144.png": "2af145cc8f09b4dcc157641a87213642",
"assets/site.webmanifest": "be09a8efd3feed46baf03f907d56769d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "26f5af2d93473531f82ef5060f9c6d45",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "1f7cb220b3f5309130bd6d9ad87e0fc0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4e20cb87b0d43808c49449ffd69b1a74",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/android-chrome-256x256.png": "44c9c954286a22b227ec048370467620",
"assets/apple-touch-icon-120x120.png": "4aad8385ac20920476c32e7a18039896",
"assets/apple-touch-icon-57x57.png": "60ccd363761c2869197272cab4a78fe3",
"assets/apple-touch-icon.png": "7eaa331ef1d02983f99f6350f727d923",
"assets/FontManifest.json": "f66aa55cd79651f341aedd8491362eea",
"assets/apple-touch-icon-57x57-precomposed.png": "e2960b0b849f7bda7e87bb8f60ec599e",
"assets/NOTICES": "1e214fd0a792e62fb9680fd10aeab72c",
"assets/favicon-32x32.png": "e12c05a7144442c0ef3180fe7eec9038",
"assets/apple-touch-icon-114x114-precomposed.png": "1d00f0d050a6d27df93ccb4df32c4c68",
"assets/android-chrome-512x512.png": "8f4f27c0597d8395e9b535bdfabe1dd5",
"assets/favicon.png": "e990c85d612f13b66faa12c37ac913d3",
"assets/apple-touch-icon-180x180-precomposed.png": "532a41e73aecfe8836e71c2db8bb7b5a",
"assets/android-chrome-192x192.png": "746f11e788dfa49738162005f3b42d3b",
"assets/mstile-310x310.png": "41620cdb4fb43792c0c6cced52b6367b",
"assets/apple-touch-icon-76x76.png": "d77835ff9684c05996f58a464fa7e9be",
"assets/apple-touch-icon-152x152.png": "d5571273a8103f6efa1472e8b9abf283",
"assets/mstile-70x70.png": "3613827e558b2cf6b447b441f843b16c",
"assets/apple-touch-icon-152x152-precomposed.png": "928a4b9168e33e797cf27a956dd43b3c",
"assets/loading.gif": "6def8d80a999aa526b1eeb5799c215c7",
"assets/safari-pinned-tab.svg": "888e683ba0949d3968be8af4fad941fc",
"assets/manifest.json": "ddb59eb5cdd1f438474349814082ff61",
"assets/apple-touch-icon-120x120-precomposed.png": "3f5dd85ef05dbead12a586a36b542965",
"assets/apple-touch-icon-60x60-precomposed.png": "bc5ad2f49eb3dad6392425125dcdd555",
"assets/apple-touch-icon-144x144-precomposed.png": "3199c713fbd8bd3dc3c339a50ccb4629",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "ae78dff7b7169188b3c4425ad0d169fa",
"/": "ae78dff7b7169188b3c4425ad0d169fa",
"version.json": "a74ce0bee35cc93dee71211e4d8908f1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
