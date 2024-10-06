import 'package:todo_list/data/source/source.dart';

class Repository<T> implements DataSource{
  final DataSource<T> localDataSource;

  Repository({required this.localDataSource});
  @override
  Future createOrUpdate(data) {
    return createOrUpdate(data);
  }

  @override
  Future<void> delete(data) {
    return delete(data);
  }

  @override
  Future<void> deleteAll() {
    return deleteAll();
  }

  @override
  Future<void> deleteById(id) {
    return deleteById(id);
  }

  @override
  Future findById(id) {
    return findById(id);
  }

  @override
  Future<List> getAll({String searchKeyword=''}) {
    return getAll(searchKeyword: searchKeyword);
  }

}