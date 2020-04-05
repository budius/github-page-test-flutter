'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "3699ae5340e5eedb528fc38fe23319ea",
"/manifest.json": "c8d5ff58304034cdefacdac7d44724b0",
"/assets/FontManifest.json": "4d109a5a13aab71441cd07f925d0a159",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/Roboto-Black.ttf": "5ebb24ee1112dd9562629375c387879a",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/fonts/RobotoMono-Regular.ttf": "b4618f1f7f4cee0ac09873fcc5a966f9",
"/assets/fonts/Lobster-Regular.ttf": "9406d0ab606cf8cb91c41b65556bd836",
"/assets/fonts/Notable-Regular.ttf": "dc386f0b36c8cfdbe2f0efbbb5c83781",
"/assets/fonts/Roboto-Regular.ttf": "11eabca2251325cfc5589c9c6fb57b46",
"/assets/LICENSE": "763f27e704c2444e35960c5d565ae20c",
"/assets/AssetManifest.json": "991bb7d03b8b1ac5160e2593b4f8c9ce",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/main.dart.js": "b1d238aa20e64c1f6ac18b85ac26c6bf"
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
