'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "3c14d3f63c5f208ee499a3706ca26803",
"version.json": "4b098a212e0bbce33516511aa3182f31",
"index.html": "29ff8452c523acd326439606c8b45b2f",
"/": "29ff8452c523acd326439606c8b45b2f",
"main.dart.js": "16a8a6d238c85ab729aacbc52ea34773",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "2ab0b34d22d8a02761debae02fbad499",
"icons/Icon-192.png": "55ed0fb42e17020f14b92f56e69afb21",
"icons/Icon-maskable-192.png": "55ed0fb42e17020f14b92f56e69afb21",
"icons/Icon-maskable-512.png": "29eaab6b7cf3ea2eadfdbc349ccb5d35",
"icons/Icon-512.png": "29eaab6b7cf3ea2eadfdbc349ccb5d35",
"manifest.json": "47a95361ef9aec905d80c5b873c68e26",
"assets/AssetManifest.json": "f7c54a742c875301fc54e2f98c10bcc6",
"assets/NOTICES": "42a877c6059df2e3d4d219e42827e88c",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "53b28a3dc3204b639a2c7764babc6bbd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "c867b9dc5f05743034bb14b13ee00207",
"assets/fonts/MaterialIcons-Regular.otf": "668e7f80b0aea09b3be5b1df841f759a",
"assets/assets/images/newsday.png": "936ac2c9a63ba6f3675b6b3816095526",
"assets/assets/images/zoom.png": "f0bd2a2f059dee2a17caf6e44f053289",
"assets/assets/images/x.png": "c5af505c5d832873a560067849bac789",
"assets/assets/images/emmy.png": "f6f275b9b142c0329b96f705a8329e4f",
"assets/assets/images/jamie-headshot.jpeg": "a275c6df8a782d997f3e581862f7d085",
"assets/assets/images/jamie3.jpg": "b1ed015b9d44661d7d2b7f64c7c6a11d",
"assets/assets/images/jamie2.jpg": "67e1c1a37ece1e4f32006a18294aa0fe",
"assets/assets/images/jamie1.jpg": "e2da404e9d1eb5013803d0d7b77c80ad",
"assets/assets/images/messaging.jpeg": "e3868085f2195bc3967de2e6ff9b8cc8",
"assets/assets/images/bruce-beck.jpeg": "c3201b9cb251f66756fd7d08e70304fa",
"assets/assets/images/headshot.png": "853a3b7bbb38de95a16c3efbfbc48f40",
"assets/assets/images/presence.jpeg": "441bba3705eb0509be2ed29163ef5858",
"assets/assets/images/ig.png": "e2a6deb24c86aec994e3f6c6a8df285d",
"assets/assets/images/islanders.jpeg": "2646c58de0215680b58e2b51b7e09032",
"assets/assets/images/thumbnail.png": "54fe675cde92643947b2f3e614c9896a",
"assets/assets/images/jamie-logo-white.png": "5ff1bc34be9563c7e9c443c1b9fe97a8",
"assets/assets/images/pat-dolan.jpeg": "2cabf45c55cf8991666d5403bcfad192",
"assets/assets/images/news12.png": "84cc1d28fe04a54f51fd7f6c1ad8689a",
"assets/assets/images/public.jpeg": "ca3f8ba2487362402304488990393add",
"assets/assets/images/reporting.jpeg": "f4c77bda7e92caae0b80e180866a9ee9",
"assets/assets/images/elisa-distefano.jpeg": "63c967e9afd250b3df7af7a8cf55cc2d",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
