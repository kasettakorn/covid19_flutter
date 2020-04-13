'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "89420ef5a624f0351669408c47ea87e0",
"/": "89420ef5a624f0351669408c47ea87e0",
"main.dart.js": "9193cb12ac6c60f655d378c2af7b65f6",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "06a952ef34aedd304499a062a3b3398e",
"assets/LICENSE": "a146ad470506a1c1e5494c21dba6e914",
"assets/images/icon.png": "eb5aa4b794c2b8fd63e84fddc5cbad17",
"assets/images/coronavirus.png": "eff9c5bd59af607f12dd1aebc4d5dae0",
"assets/images/waiting.png": "4c15a9b76fb269e21b445715a80a78ab",
"assets/images/patient.png": "d6882a51496f88e5f2299b7466d997c4",
"assets/images/death.png": "a1f76a33645331bca69dddfeb23a84af",
"assets/AssetManifest.json": "51d0c991a0033d48fc8a200d1be0b950",
"assets/FontManifest.json": "ece0a07a97a9d66e29b09d69103cc850",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/Prompt-Medium.ttf": "bd536c6341c5402b41fa4b9e58705579",
"assets/fonts/Prompt-Light.ttf": "2aed5273600290713f7ed8d182a93592",
"assets/fonts/Prompt-Regular.ttf": "16b4ce72cf30da14d83d5e3981d3113c",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/fonts/Prompt-Black.ttf": "e62b3130a1faa3434353e3c7f5ff2664"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
