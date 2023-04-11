// public class FCMSender {
//     private static void sendMessageToFcmRegistrationToken() throws Exception {
//         String registrationToken = "REPLACE_WITH_FCM_REGISTRATION_TOKEN";
//         message message =
//             Message.builder()
//                 .putData("FCM", "https://firebase.google.com/docs/cloud-messaging")
//                 .putData("flutter", "https://flutter.dev/")
//                 .setNotification(
//                     Notification.builder()
//                         .setTitle("Try this new app")
//                         .setBody("Learn how FCM works with Flutter")
//                         .build())
//                 .setToken(registrationToken)
//                 .build();
     
//         FirebaseMessaging.getInstance().send(message);
     
//         System.out.println("Message to FCM Registration Token sent successfully!!");
//       }
// }
