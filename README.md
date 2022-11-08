# Проект для участия в [VolgaIT](https://volga-it.org/)

# Задание отборожного этапа:

1. Отображать название акций и цену;
2. Давать динамическое отображение акций, показанных на экране. Опционально: настроить получение текущей стоимости акции через web-сокеты.

Время на выполнение задания: c 1 марта до 31 мая 2022 года

# Задание финального этапа

1. Дополнить приложение функционалом фильтрации по названию (поиск).
2. Добавить поддержку остальных бирж.
3. Добавить возможность добавить инструмент в избранное (с сохранением в энергонезависимой памяти).
   3.5 Добавленные в избранные отображаются сверху списка
4. Добавить возможность информировать пользователя если цена инструмента снизится\поднимется ниже\выше указанного порога. (notification).
5. Вывод графика/свечей по выбранному инструменту с возможностью указать период (в рамках того что дается в бесплатной версии)

Время на выполнение задания: 7 часов

# Сборка и тестирование

Для сборки приложения необходимо установить

1. Flutter 3.3.2
2. VSCode или Android Studio
3. В выбранном IDE установить расширение Flutter

# Stonks включает функции:

1. Отслеживание текущих цен у сохраненных инструментов в разделе "Избранные" (Отслеживание актуальной цены происходит через web-socket соединение)
2. Кеширование сохраненых акций
3. Поиск новых акций в разделе "Поиск"
4. Добавленние найденной акции в сохраненые акции
5. Удаление акции из списка сохраненых акций
6. Отмена удаления из списка сохраненых акций
7. Отображение статуса подключения
8. Получени всех инструментов торгуемых на определенной бирже
9. Уведомление о изменение цены инструмента
10. Отображение графика свечей для акций из Избранных

# Проверка задания

1. Для проверки получения последней цены, рекомендуется из списка популярных акций добавить BINANCE:BTCUSDT,
   тк биткоин торгуется всё время.
2. Для проверки оптимизации рекомендуется добавить все акции из списка популярных акций.
   И следить за их ценой во время работы американской биржы: с 16.30 до 23:00 по МСК
   
# Архитектура приложения

Для разделения бизнес логики и ui используется паттерн BLoC.
Архитектура проекта соответсвует принципам чистой архитектуры

# Скрины

![CheckingInternetConnection](https://user-images.githubusercontent.com/80877621/197196559-e8308121-83bf-45a5-8301-f41cb5868bbd.png)
![ExchangeItemsPage](https://user-images.githubusercontent.com/80877621/197196563-95d71166-e2d4-46e2-8f3a-5437129e16d6.png)

![SearchPage](https://user-images.githubusercontent.com/80877621/197196570-6e41b57e-357e-412d-bdc2-e39e651b6ced.png)
![AddToFavorites](https://user-images.githubusercontent.com/80877621/197196554-9a4f9dd3-6a11-46c8-9a98-0cdeaa2fe1e3.png)

![DeleteFavorite](https://user-images.githubusercontent.com/80877621/197196560-0681a248-07da-4a0d-a908-1f64822b82e4.png)
![FavoritesPage](https://user-images.githubusercontent.com/80877621/197196566-2d918ab5-a9c5-43ef-bb95-367c51ba97fa.png)

[Видео страницы "Избранные"](https://user-images.githubusercontent.com/80877621/197197041-9db7c2c3-0e48-44bc-890d-058cf71cab48.MP4)
