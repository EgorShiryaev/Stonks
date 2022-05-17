# stonks

Проект для отборочного этапа "Международной цифровой олимпиаде 'Волга-IT 22'"

Задание: Мобильное приложение должно: 
1. Отображать название акций и цену; 
2. Давать динамическое отображение акций, показанных на экране.
Опционально: настроить получение текущей стоимости акции через web-сокеты.

Stonks - мобильное приложение, которое позволяет следить за актуальной ценой американских акций или криптовалюты.

Stonks включает функции: 
1. Отслеживание текущих цен у сохраненных акций в разделе "Мои акции" (Отслеживание актуальной цены происходит через web-socket соединение) 
2. Кеширование сохраненых акций 
3. Поиск новых акций в разделе "Поиск" 
4. Добавленние найденной акции в сохраненые акции 
5. Удаление акции из списка сохраненых акций 
6. Отмена удаления из списка сохраненых акций 
7. Отображение статуса подключения

В репозитории присутвует апк для андройд

Для проверки получения последней цены, рекомендуется из списка популярных акций добавить BINANCE:BTCUSDT,
тк биткоин торгуется всё время.

Для проверки оптимизации рекомендуется добавить все акции из списка популярных акций.
И следить за их ценой во время работы американской биржы: с 16.30 до 23:00 по МСК

Для разделения бизнес логики и  ui используется паттерн BLoC.
Архитектура проекта соответсвует принципам чистой архитектуры