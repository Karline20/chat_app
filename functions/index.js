import { initializeApp } from 'firebase-admin/app';
import { getMessaging } from 'firebase-admin/messaging';
import { firestore } from 'firebase-functions/v1';
initializeApp();

export const myFunction = firestore
  .document('chat/{messageId}')
  .onCreate((snapshot, context) => {
    // Return this function's promise, so this ensures the firebase function
    // will keep running, until the notification is scheduled.
    
    return getMessaging().send({
      // Sending a notification message.
      notification: {
        title: snapshot.data()['userName'],
        body: snapshot.data()['text'],
      },
      data: {
        // Data payload to be sent to the device.
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      },
      topic: 'chat',
    });
  });