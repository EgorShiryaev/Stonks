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

1. Отслеживание текущих цен у сохраненных акций в разделе "Мои акции" (Отслеживание актуальной цены происходит через web-socket соединение)
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

![CheckInternetConnection](https://user-images.githubusercontent.com/80877621/196949154-83df4da9-f0ee-4b7d-ae34-5c6ecae4fece.png)
![ExchangesPage](https://user-images.githubusercontent.com/80877621/196949159-73fc2905-ddcb-4aee-b772-af64cc520a27.png)

![SearchPage](https://user-images.githubusercontent.com/80877621/196949166-6379894e-5415-47e8-99ad-b352fb73bf0c.png)
![SearchResultPage](https://user-images.githubusercontent.com/80877621/196949168-7096d777-e1bd-4445-bac3-e39c679d9283.png)

![SetNotificationModal](https://user-images.githubusercontent.com/80877621/196949170-fa8232b9-718c-41e2-a8f4-7984a218ab3c.png)
!https://user-images.githubusercontent.com/80877621/196951322-7cd67dec-ab88-4791-8010-15e0ef377959.mp4

# Награды

![Отборочный этап](https://user-images.githubusercontent.com/80877621/196950892-cd64e130-53e8-4d00-8545-836a32d7f0f1.png)

![Финальный этап](https://user-images.githubusercontent.com/80877621/196950914-40daaf21-820f-42dc-a6a8-7865441d31af.png)

