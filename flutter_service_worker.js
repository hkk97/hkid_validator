'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"main.dart.js": "80aa9ed9afc810c0f23b1e48843da232",
"assets/AssetManifest.json": "08baa5d14b333894595c4d9c1e5a937a",
"assets/apple-touch-icon-76x76-precomposed.png": "e1d815c1e9af056d93a6c237e8c92989",
"assets/apple-touch-icon-72x72.png": "5c7f5af5b567c6207cd416a8bcbc020f",
"assets/favicon-16x16.png": "8f9f5e742a5c38ebeb0f232788d150f7",
"assets/apple-touch-icon-60x60.png": "92d8aacf5808c0d4a1ab3932f15b192f",
"assets/apple-touch-icon-180x180.png": "4600dd25a7dcee53ab874337327beeea",
"assets/apple-touch-icon-precomposed.png": "51f8cb25ed9ffa660b3978b09d9be3c7",
"assets/favicon.ico": "ff209ee4376748d2427edc94b4fab47a",
"assets/assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/FontManifest.json": "f66aa55cd79651f341aedd8491362eea",
"assets/assets/icons/check_16x16.png": "0acccbd68ae4924c881730426084db55",
"assets/assets/icons/close_16x16.png": "f61a2ec0afc719fbb5a610bc42d651fa",
"assets/assets/icons/menu_32x32.png": "1f137a6e1c4e204242dde41ee509c8b0",
"assets/apple-touch-icon-72x72-precomposed.png": "e6897d2a752ffac7d50ff9b00c87f48a",
"assets/mstile-150x150.png": "dd2bf7bdfa65b8aae4d209a56c191cfa",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/shaders/ink_sparkle.frag": "bfd223fd128d659ff8813253d56be66f",
"assets/mstile-144x144.png": "f3bbf907d11675b5ff0c68a8bd6a8ff8",
"assets/browserconfig.xml": "f773b293a24adc2660b92a5f0a2ca29d",
"assets/apple-touch-icon-114x114.png": "b7a555c33972196f70da9f22e5c7543d",
"assets/apple-touch-icon-144x144.png": "d1aa21d385450b6a1f2203ac15e4280e",
"assets/site.webmanifest": "eca7907e83d50e683557ad6f6d52f4a1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/android-chrome-256x256.png": "44c9c954286a22b227ec048370467620",
"assets/apple-touch-icon-120x120.png": "58a464ad2d3fc1f41e4da04dee74c7e8",
"assets/apple-touch-icon-57x57.png": "b027bf9f17d287dcb62a7e4526a0c2e2",
"assets/apple-touch-icon.png": "4600dd25a7dcee53ab874337327beeea",
"assets/FontManifest.json": "f66aa55cd79651f341aedd8491362eea",
"assets/apple-touch-icon-57x57-precomposed.png": "af86b0bc3e86f3b3e8e890d813020250",
"assets/NOTICES": "5d1093059620e4d5c50c5c8e1d2af234",
"assets/favicon-32x32.png": "b6338180cbf9583cdef6e6eb95d87521",
"assets/apple-touch-icon-114x114-precomposed.png": "f110978a60436b44de5ee5d5c21f9ebe",
"assets/favicon.png": "e990c85d612f13b66faa12c37ac913d3",
"assets/apple-touch-icon-180x180-precomposed.png": "51f8cb25ed9ffa660b3978b09d9be3c7",
"assets/android-chrome-192x192.png": "766ec6d425e65cacaa41ea345caa9c82",
"assets/mstile-310x310.png": "41620cdb4fb43792c0c6cced52b6367b",
"assets/apple-touch-icon-76x76.png": "c2489ba1ae86eaca4dda47e68ccbb54b",
"assets/apple-touch-icon-152x152.png": "641b6c1ca40e1ee3466955e5eebea6c2",
"assets/mstile-70x70.png": "3613827e558b2cf6b447b441f843b16c",
"assets/apple-touch-icon-152x152-precomposed.png": "d09625ad1f383f23fc4070e20a975772",
"assets/loading.gif": "6def8d80a999aa526b1eeb5799c215c7",
"assets/safari-pinned-tab.svg": "5fdb9f1d8bacf5090939f47d81f3c430",
"assets/manifest.json": "ddb59eb5cdd1f438474349814082ff61",
"assets/apple-touch-icon-120x120-precomposed.png": "d592878a2d5fb5d573e9b217b6c6b965",
"assets/apple-touch-icon-60x60-precomposed.png": "9ce3246691f1f18ed087347d792d84ab",
"assets/apple-touch-icon-144x144-precomposed.png": "a41fbb12abf05fb7f8959caada767159",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"index.html": "b13c54acba20d37f07e232466463b302",
"/": "b13c54acba20d37f07e232466463b302",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
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
