import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  static getData(path) {
    return FirebaseFirestore.instance.collection(path).get();
  }

  static addData(path, data) {
    FirebaseFirestore.instance.collection(path).add(data);
  }

  static deleteData(path, docId) {
    FirebaseFirestore.instance.collection(path).doc(docId).delete();
  }

  static updateData(path, docId, data) {
    FirebaseFirestore.instance.collection(path).doc(docId).update(data);
  }

  static singleData(path, docId) {
    return FirebaseFirestore.instance.collection(path).doc(docId).get();
  }

  static addChildData(parentPath, parentId, childPath, childData) {
    FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .add(childData);
  }

  static getChildData(parentPath, childPath, parentId) {
    return FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .get();
  }

  static deleteChildData(parentPath, parentId, childPath, childId) {
    FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .doc(childId)
        .delete();
  }

  static updateChildData(parentPath, parentId, childPath, childId, data) {
    FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .doc(childId)
        .update(data);
  }

  static getSingleChildData(parentPath, parentId, childPath, childId) {
    return FirebaseFirestore.instance
        .collection(parentPath)
        .doc(parentId)
        .collection(childPath)
        .doc(childId)
        .get();
  }
}
