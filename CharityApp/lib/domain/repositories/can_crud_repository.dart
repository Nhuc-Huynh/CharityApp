abstract class CRUDableRepository<T> {
  Future<List<T>> load(String rootId, int startIndex, int number);
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<void> update(T entity);
}