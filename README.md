# Almost Netflix - Flutter


![Banner](readme_banner.png)

## Requirements

Before using this project, you will need to have Appwrite instance with Almost Netflix project ready. You can visit the Project setup [GitHub repository](https://github.com/Meldiron/almost-netflix-project-setup) or [Dev.to post](https://dev.to/appwrite/did-we-just-build-a-netflix-clone-with-appwrite-28ok).

## Usage

```bash
$ git clone https://github.com/appwrite/demo-almost-netflix-for-flutter.git
$ cd demo-almost-netflix-for-flutter
$ open -a Simulator.app
$ flutter run
```

Make sure to update Endpoint and ProjectID in `lib/api/client.dart`.

The application will be listening on port `3000`. You can visit in on URL `http://localhost:3000`.


### `assets`

The assets directory contains your images such as logos as well as anything else you would like your project to use, be sure to update `pubspec.yaml` with any addition folders.

More information about assets can be found in [the documentation](https://docs.flutter.dev/development/ui/assets-and-images).

### `lib/api`

The `lib/api` folder contains our API request client that is used for communicating with Appwrite endpoints.

### `lib/data`

The `lib/data` folder is where we put anything that represents data such as our models

### `lib/extensions`

We use the `lib/extensions` folder to extend the Dart language with helpers for convenience methods.

### `lib/providers`

Our `lib/providers` folder is where we create our `ChangeNotifiers` that allow observation and access across our app.

For more information about the Provider library which we used can be found in the [documentation](https://pub.dev/packages/provider)

### `lib/screens`

Directory `lib/screens` is where we place all of our top level views and responsible for laying out how we present to our users.

### `lib/widgets`

The `lib/widgets` directory contains all of our Flutter widgets. Widgets are the main component of Flutter and can make up different pars of your screen.

For more information on Widgets can be found in the [documentation](https://docs.flutter.dev/reference/widgets)
