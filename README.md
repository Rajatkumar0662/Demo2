# Demo Project - Screening Round

Screening Document: [Screening Round - Coding Exercise ](<./assets/documents/Screening%20Round%20-%20Coding%20Exercise%20(1)-2.pdf>)

Based on above document, following are the project architechture setup,

## Developer

Name: Rajat Kumar Singh

Age: 25 yrs

Email: rajatkumar066@gmail.com

Phone Number: [+91-8292782606](tel:+918292782606)

LinkedIn: [Rajat Kumar Singh](https://www.linkedin.com/in/rajatkumar0662/)

resume: [Senior Software Developer - Flutter](<./assets/documents/Resume-Rajat-Kumar-Singh%20(1).pdf>)

## Packages

- [Go Router](https://pub.dev/packages/go_router) ^12.1.1
- [Bloc](https://pub.dev/packages/bloc) ^8.1.2
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) ^8.1.3
- [Equatable](https://pub.dev/packages/equatable) ^2.0.5
- [Hive](https://pub.dev/packages/hive) ^2.2.3
- [Path Provider](https://pub.dev/packages/path_provider) ^2.1.1

## Architecture Pattern

### BLoC

The architecture pattern used in this demo is `BLOC`. Where, there is 2 BLoC responsible for
functioning of the application.

- [SuccessBloc](./lib/modules/func/bloc/success/success_bloc.dart) - For Handling success/win (when Count matches second part of Current Timestamp.)

- [CounterBloc](./lib/modules/func/bloc/counter/counter_bloc.dart) - responsible for generating random Number and states related to it.

### Repository

- [CounterRepository](./lib/modules/data/repository/counter_repo.dart)

  - getRandomNumber - Generating Random Numbers (LOGIC)
  - getCounter - Fetch `success` count
  - setCounter - increment current count by 1
  - resetCounter - set count to 0

### Utils

- [Utils](./lib/utils/custom_snackbar.dart) - Responsible for creating snackbar

Note: Following `Module based development` to scale to larger module structure
