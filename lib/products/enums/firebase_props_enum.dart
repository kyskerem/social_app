enum FirebaseProps {
  uid('uid'),
  publisherUid('publisherUid'),
  likes('likes'),
  displayName('displayName'),
  photoURL('photoURL'),
  postId('postId'),
  id('id'),
  email('email'),
  comment('comment'),
  datePublished('datePublished'),
  creationTime('creationTime'),
  lastSignInTime('lastSignInTime');

  final String value;
  const FirebaseProps(this.value);
}
