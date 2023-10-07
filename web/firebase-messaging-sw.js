 importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js");
 importScripts("https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js");

  const firebaseConfig = {
    apiKey: "AIzaSyCeE21bDpuy89r-XmSCm-Ke-brkuDvPXQo",
    authDomain: "mandixpress-d67a9.firebaseapp.com",
    projectId: "mandixpress-d67a9",
    storageBucket: "mandixpress-d67a9.appspot.com",
    messagingSenderId: "558459610565",
    appId: "1:558459610565:web:14ffdb29a7fe0efa9097ac",
    measurementId: "G-QSHDHC86J6"
  };
console.log('Received background message ', firebaseConfig);

  // Initialize Firebase with your config
  firebase.initializeApp(firebaseConfig);

  const messaging = firebase.messaging();

  // Optional: Handle background messages
 messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload.data.body);
 // Customize your notification here
   const notificationTitle =  payload.data.title;
   const notificationOptions = {
     body:  payload.data.body,
     icon: 'https://ik.imagekit.io/00itvcwwk/category/image_1695544053687_u_4xiNaXWr.png?updatedAt=1695544060164', // Specify a custom icon URL
     badge: 'https://ik.imagekit.io/00itvcwwk/category/image_1695544053687_u_4xiNaXWr.png?updatedAt=1695544060164', // Specify a custom badge URL
     sound: 'https://ik.imagekit.io/00itvcwwk/shopeefood_sound.mp3?updatedAt=1696573541986',
     data: { customKey: 'customValue' }, // You can add custom data
   };

   self.registration.showNotification(notificationTitle, notificationOptions);
 });

