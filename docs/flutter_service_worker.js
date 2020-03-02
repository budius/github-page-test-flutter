'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/main.dart.js": "bdc4ab572e55a13d761d634bc10da9a0",
"/index.html": "56d4f9180a3ec6bb0365dd9452157e72",
"/manifest.json": "c8d5ff58304034cdefacdac7d44724b0",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/assets/AssetManifest.json": "991bb7d03b8b1ac5160e2593b4f8c9ce",
"/assets/fonts/Roboto-Black.ttf": "5ebb24ee1112dd9562629375c387879a",
"/assets/fonts/Roboto-Regular.ttf": "11eabca2251325cfc5589c9c6fb57b46",
"/assets/fonts/Lobster-Regular.ttf": "9406d0ab606cf8cb91c41b65556bd836",
"/assets/fonts/RobotoMono-Regular.ttf": "b4618f1f7f4cee0ac09873fcc5a966f9",
"/assets/fonts/Notable-Regular.ttf": "dc386f0b36c8cfdbe2f0efbbb5c83781",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/LICENSE": "e72ade93564a49ac9cfed5c33f9c8e8b",
"/assets/FontManifest.json": "4d109a5a13aab71441cd07f925d0a159",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632"
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
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
