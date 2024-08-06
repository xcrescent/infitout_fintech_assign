# Assignment

This Flutter application demonstrates a table with fixed central columns and reverse scrolling for the left and right columns.

## Explanation

This application consists of a main widget (`MyApp`) and a home page widget (`HomePage`). The `HomePage` widget uses multiple `ListView` widgets to create a horizontally scrollable table with fixed central columns. The left and right columns scroll in opposite directions.

### Code Breakdown

1. **Main Application (`MyApp`):**
    - Sets up the application with a title and theme.
    - The home page is set to `HomePage`.

2. **HomePage State (`_MyHomePageState`):**
    - Four `ScrollController` instances manage the scrolling of the columns.
        - `_scrollControllerLeft`: Controls the left scrolling columns.
        - `_scrollControllerFixed`: Controls the fixed center columns.
        - `_scrollControllerRight`: Controls the right scrolling columns.
        - `_scrollController`: Controls vertical scrolling.
    - `initState` method:
        - Sets up listeners to synchronize the scrolling between left and right columns in reverse direction.
    - `dispose` method:
        - Disposes of the `ScrollController` instances.
    - `build` method:
        - Creates a horizontal scrollable view with three sections:
            - Left scrolling columns.
            - Fixed center columns.
            - Right scrolling columns (scrolling in reverse direction).

### Running the Application

1. **Install Flutter:**
    - Follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install) to install Flutter.

2. **Clone the Repository:**
    - Clone the repository using the following command:
        ```sh
        git clone https://github.com/xcrescent/infitout_fintech_assign
        ```
    - Navigate to the project directory:
        ```sh
        cd infitout_fintech_assign
        ```
3. **Run the Application:** 
    - Run the application using the following command:
        ```sh
        flutter run
        ```