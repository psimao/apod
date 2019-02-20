abstract class EntityMapper<E> {

  E map(dynamic obj);

  T transform<T> (E entity) => null;
}