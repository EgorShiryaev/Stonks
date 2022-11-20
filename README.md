# Stonks

Мобильное приложение для отслеживания котировок.

Разработанно для участия в [VolgaIT](https://volga-it.org/).

## Задание отборочного этапа:

1. Отображать название акций и цену;
2. Давать динамическое отображение акций, показанных на экране. Опционально: настроить получение текущей стоимости акции через web-сокеты.

Время на выполнение задания: c 1 марта до 31 мая 2022 года

## Задание финального этапа

1. Дополнить приложение функционалом фильтрации по названию (поиск);
2. Добавить поддержку остальных бирж;
3. Добавить возможность добавить инструмент в избранное (с сохранением в энергонезависимой памяти);
3.5. Добавленные в избранные отображаются сверху списка;
4. Добавить возможность информировать пользователя если цена инструмента снизится\поднимется ниже\выше указанного порога. (notification);
5. Вывод графика/свечей по выбранному инструменту с возможностью указать период (в рамках того что дается в бесплатной версии).

Время на выполнение задания: 7 часов

Apk файл можно скачать [тут](https://github.com/EgorShiryaev/Stonks/releases).

## Начало работы

Перед запуском приложения необходимо установить все программное обеспечение перечисленное в разделе "Необходимое ПО". 

Только после того как у вас установлено всё ПО, вы можете переходить к разделу "Запуск приложения".

### Необходимое ПО

- [flutter 3.3.2](https://docs.flutter.dev/development/tools/sdk/releases)
- [Xcode](https://apps.apple.com/ru/app/xcode/id497799835?mt=12)
- [Android Studio](https://developer.android.com/studio)
- [Visual Studio Code](https://code.visualstudio.com/)

После того как скачается flutter, следуйте этим [инструкциям](https://docs.flutter.dev/get-started/install).

Для настройки редактора кода, следуйте этим [инструкциям](https://docs.flutter.dev/get-started/editor?tab=vscode).

### Запуск приложения

Откройте проект в редакторе кода. Запустите терминал в папке проекта. Затем установите все необходимые пакеты командой:

```
flutter pub get
```

После успешной загрузки пакетов запустите эмулятор и напишите команду в терминал:

```
flutter run
```

Подробнее о запуске приложения flutter можно узнать [тут](https://docs.flutter.dev/get-started/test-drive?tab=vscode).

## Разработка

Для получения данных об акциях используется [finnhub API](https://finnhub.io/)

Базой данной является [hive](https://pub.dev/packages/hive)

Для работы с websocket`ами используется библиотека [dart:io](https://api.dart.dev/stable/2.18.4/dart-io/dart-io-library.html)

## Скрины

![CheckingInternetConnection](https://user-images.githubusercontent.com/80877621/197196559-e8308121-83bf-45a5-8301-f41cb5868bbd.png)
![ExchangeItemsPage](https://user-images.githubusercontent.com/80877621/197196563-95d71166-e2d4-46e2-8f3a-5437129e16d6.png)

![SearchPage](https://user-images.githubusercontent.com/80877621/197196570-6e41b57e-357e-412d-bdc2-e39e651b6ced.png)
![AddToFavorites](https://user-images.githubusercontent.com/80877621/197196554-9a4f9dd3-6a11-46c8-9a98-0cdeaa2fe1e3.png)

![DeleteFavorite](https://user-images.githubusercontent.com/80877621/197196560-0681a248-07da-4a0d-a908-1f64822b82e4.png)
![FavoritesPage](https://user-images.githubusercontent.com/80877621/197196566-2d918ab5-a9c5-43ef-bb95-367c51ba97fa.png)

[Видео страницы "Избранные"](https://user-images.githubusercontent.com/80877621/197197041-9db7c2c3-0e48-44bc-890d-058cf71cab48.MP4)
