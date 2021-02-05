import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  static getData(path) {
    return FirebaseFirestore.instance.collection(path).get();
  }

  static addData(path, data) {
    FirebaseFirestore.instance.collection(path).add(data);
  }

  static deleteData(path, docId) {
    FirebaseFirestore.instance.collection(path).doc(docId).delete().catchError(
      (onError) {
        print(onError);
      },
    );
  }

  static updateData(path, docId, data) {
    FirebaseFirestore.instance
        .collection(path)
        .doc(docId)
        .update(data)
        .catchError(
      (onError) {
        print(onError);
      },
    );
  }

  static singleData(path, docId) {
    return FirebaseFirestore.instance.collection(path).doc(docId).get();
  }

  static addChildData(parentPath, parentId, childPath, parentData, childData) {
    FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .add(childData);
    FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .update(parentData);
  }
}
