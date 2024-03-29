'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "bbe7ef72d98814ecf23857e150cafa63",
"/": "bbe7ef72d98814ecf23857e150cafa63",
"main.dart.js": "2d485ee8a1258e313745b65c63e4efb0",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"version.json": "64996f4186b5b1bb8001c529f0076705",
"manifest.json": "c5ecfb6e054d515406730794e4b9c97d",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/AssetManifest.json": "0ab09183eadd148d81b3591660c2b6bc",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/NOTICES": "3d750f3c2c1e95e6c6f280190b2de8eb",
"assets/asset/imges/heart-in-a-circle.png": "d58ed3cb506bc779c6239d599e322bce",
"assets/asset/imges/emoji.png": "fab2571c04079ee77db509402441720d",
"assets/asset/imges/author.png": "25a56a2a1acb14fa6f82b2f725297549",
"assets/asset/imges/discount.png": "f0ff2c2b7efe1e6c57639fc7228e2e6b",
"assets/asset/imges/approve.png": "5c9475a61f8fce8cc2a9e437dcca1595",
"assets/asset/imges/back-button.png": "33d592956ce8fe2f4099fede93ec7dfd",
"assets/asset/imges/diamond.png": "0cfcfc2280cff1942cfd371ebf5e6b47",
"assets/asset/imges/images%2520(1).png": "2c6d1d69526048a6641f7de6dcf5e672",
"assets/asset/imges/director.png": "89d9e55409dc1b4b9e61bb3a8eec81cc",
"assets/asset/imges/categies_img/pexels-aleksey-kuprikov-3715436.jpg": "7a9c0da944c6f31c0a659decb9de97b9",
"assets/asset/imges/categies_img/pexels-setu-chhaya-9455189.jpg": "bbf078fde5dddbfdc05575f0baf54fc4",
"assets/asset/imges/categies_img/pexels-mikhail-nilov-8321369.jpg": "90c2346b5ca33235056f5e199e8f457f",
"assets/asset/imges/categies_img/pexels-denys-gromov-13252308.jpg": "448814b4fc9d40a3310401e5e4b84e4f",
"assets/asset/imges/categies_img/pexels-asad-photo-maldives-1450372.jpg": "80cec453edb702106c4f2e6bc50aedc1",
"assets/asset/imges/categies_img/pexels-veeterzy-38136.jpg": "362ce33f41cadaf4f0deefa2a916af66",
"assets/asset/imges/navigation_img/location.png": "cd4aff5d0037488d39e079b23fd2ec9a",
"assets/asset/imges/navigation_img/eye.png": "bb8e6498d17a21face18972834122eed",
"assets/asset/imges/navigation_img/home-icon-silhouette.png": "3cf3bbf96663fefac4e687373e2fdecc",
"assets/asset/imges/navigation_img/calendar.png": "db041557dbfd68a3527f26616de89a06",
"assets/asset/imges/tour-guide.png": "687b2d0e8fbb0d3c96a41b5365a9c43e",
"assets/asset/imges/pexels-photo-4220967.jpeg": "7f7b85a3bdaf314c7f0b3fa859469d58",
"assets/asset/imges/mayor.png": "03f0f2e439e6a0356ec1352667e0cbca",
"assets/AssetManifest.bin": "50414b767e44e37fdcf197bef71cbd0d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "5c87ae32eb8a17ed09cf2545cb87fef0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
