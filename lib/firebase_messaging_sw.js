importScripts('https://www.gstatic.com/firebasejs/9.6.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.0/firebase-messaging-compat.js');
firebase.initializeApp({
  apiKey: "AIzaSyBVAXMs5WieSouK0ACqTdzJM-reOT-Z0QU",
  authDomain: "sample-b03f1.firebaseapp.com	",
  projectId: "sample-b03f1",
  storageBucket:  "sample-b03f1.appspot.com",
  messagingSenderId: "575623170706",
  appId: "1:575623170706:android:696c6b1962b0e424ff344b"
});
const messaging = firebase.messaging();
