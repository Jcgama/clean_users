# clean_users

A small Flutter project demonstrating Clean Architecture and dependency injection with `get_it`.

## Clean Architecture

Clean Architecture organizes an application into layers with clear responsibilities and
dependencies. The central rule is that inner layers contain business concepts and should
not depend on outer layers or framework details. This keeps business logic easier to test
and makes external concerns, such as APIs and UI, easier to change independently.

## How this project uses it

The users feature is organized into three layers:

- **Presentation** (`lib/features/users/presentation`) contains the `UsersPage` and
  `UsersBloc`. The page displays loading, error, and user-list states; the BLoC handles
  UI events and delegates the work of loading users.
- **Domain** (`lib/features/users/domain`) contains the `User` entity, the
  `UsersRepository` contract, and the `GetUsers` use case. This is the business-facing
  layer: the use case asks the repository for users without knowing how or where they are
  fetched.
- **Data** (`lib/features/users/data`) implements the domain repository contract. The
  remote data source fetches user data through Dio, the model represents the API response,
  and `UsersRepositoryImpl` maps those models into domain `User` entities.

The request flow is: `UsersPage` → `UsersBloc` → `GetUsers` → `UsersRepository` →
`UsersRepositoryImpl` → `UsersRemoteDatasource` → API. Results return through the same
chain, with the repository converting data models into domain entities. The domain
repository interface lets the domain remain independent of the remote data source and
networking library.

## Dependency injection with get_it

`get_it` is a service locator used here as the composition point for the app's object
graph. The `setup()` function in `lib/core/dependency_injection.dart` registers
dependencies, and `main()` calls it before `runApp()`. Consumers then receive the objects
they need through constructor parameters rather than constructing concrete dependencies
themselves.

The registrations build this dependency chain:

1. `ApiClient` and its configured `Dio` client are registered as singletons, so the app
   shares those instances.
2. `UsersRemoteDatasource`, `UsersRepository`, and `GetUsers` are lazy singletons. They
   are created on first request and reused afterward. The repository is registered using
   the `UsersRepository` abstraction and backed by `UsersRepositoryImpl`.
3. `UsersBloc` is registered as a factory, so each request for a BLoC creates a fresh
   instance. `UsersPage` obtains one from `getIt` when creating its `BlocProvider`.

This keeps dependency construction in one place and makes it possible to replace
implementations—for example, with a test repository—without changing the presentation
or domain logic.
