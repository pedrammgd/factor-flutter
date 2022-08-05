
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyAZfEcUTdlnvO9_19mM7qawAMLiq9MJMdE",
     authDomain: "factor-flutter.firebaseapp.com",
     projectId: "factor-flutter",
     storageBucket: "factor-flutter.appspot.com",
     messagingSenderId: "1050573148656",
     appId: "1:1050573148656:web:0066d9606db59d63a6cd35",
     measurementId: "G-XHJ26XT7CD"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});