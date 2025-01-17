﻿local L = LibStub("AceLocale-3.0"):NewLocale("AuctionLite", "ruRU");
if not L then return end

L["Accept"] = "Принять"
L["Add a new item to a favorites list by entering the name here."] = "Введите здесь название предмета для добавления в список избранного."
L["Add an Item"] = "Добавить предмет"
L["Advanced"] = "Дополнительно"
L["Always"] = "Всегда"
L["Amount to multiply by vendor price to get default sell price."] = "Множитель цены продажи торговцу для получения цены продажи по умолчанию."
L["Approve"] = "Подтвердить"
L["Auction"] = "Аукцион"
L["Auction creation is already in progress."] = "Создание аукциона уже в процессе."
L["Auction house data cleared."] = "Все данные удалены."
L["AuctionLite"] = "AuctionLite"
L["AuctionLite Buy"] = "AuctionLite Покупка"
L["AuctionLite - Buy"] = "AuctionLite - Покупка"
L["AuctionLite Sell"] = "AuctionLite Продажа"
L["AuctionLite - Sell"] = "AuctionLite - Продажа"
L["AuctionLite v%s loaded!"] = "AuctionLite v%s загружен!"
L["Auction scan skipped (control key is down)"] = "Сканирование аукциона пропущено (нажата кнопка Ctrl)"
L["Batch %d: %d at %s"] = "Партия %d: %d за %s"
L["Below AH"] = "Ниже АУКа"
L["Bid cost for %d:"] = "Ставка за %d шт.:"
L["Bid on %dx %s (%d |4listing:listings; at %s)."] = "Ставка на: %dx %s (%d |4лот:лота:лотов; за %s)."
L["Bid Per Item"] = "Ставка (за штуку)"
L["Bid Price"] = "Начальная цена"
L["Bid Total"] = "Ставка (всего)"
L["Bid Undercut"] = "\"Сбивать\" ставку"
-- L["Bid Undercut (Fixed)"] = ""
L["Bought %dx %s (%d |4listing:listings; at %s)."] = "Куплено %dx %s (%d |4лот:лота:лотов; за %s)"
L["Buyout cannot be less than starting bid."] = "Цена выкупа не может быть меньше начальной ставки."
L["Buyout cost for %d:"] = "Выкупная цена за %d шт.:"
L["Buyout Per Item"] = "Выкуп (за штуку)"
L["Buyout Price"] = "Выкупная цена"
L["Buyout Total"] = "Выкуп (всего)"
L["Buyout Undercut"] = "\"Сбивать\" цену выкупа"
-- L["Buyout Undercut (Fixed)"] = ""
L["Buy Tab"] = "Купить"
L["Cancel"] = "Отмена"
L["Cancel All"] = "Отменить все"
L["Cancel All Auctions"] = "Отменить все лоты"
L["CANCEL_CONFIRM_TEXT"] = "На некоторые из ваших лотов есть ставки.  Вы хотите отменить все лоты, только лоты без ставок, или ничего не делать?"
L["Cancelled %d |4listing:listings; of %s."] = "Отменено %d |4лот:лота:лотов; из %s."
L["Cancelled %d listings of %s"] = "Отменено: %d |4лот:лота:лотов; %s"
-- L["CANCEL_NOTE"] = ""
L["CANCEL_TOOLTIP"] = [=[|cffffffffКлик:|r Отменить все лоты
|cffffffffCtrl-Клик:|r Отменить перебитые лоты]=]
L["Cancel Unbid"] = "Отменить лоты без ставок"
L["Cancel Undercut Auctions"] = "Отменить перебитые лоты"
L["|cff00ff00Scanned %d listings.|r"] = "|cff00ff00Просканировано: %d |4лот:лота:лотов;.|r"
L["|cff00ff00Using previous price.|r"] = "|cff00ff00Используя предыдущую цену.|r"
L["|cff808080(per item)|r"] = "|cff808080(за предмет)|r"
L["|cff808080(per stack)|r"] = "|cff808080(за связку)|r"
L["|cff8080ffData for %s x%d|r"] = "|cff8080ffДанные для %s x%d|r"
L["|cffff0000Buyout less than bid.|r"] = "|cffff0000Цена выкупа меньше, чем ставка.|r"
L["|cffff0000Buyout less than vendor price.|r"] = "|cffff0000Цена выкупа меньше, чем цена продажи торговцу.|r"
L["|cffff0000[Error]|r Insufficient funds."] = "|cffff0000[Ошибка]|r Не хватает денег."
L["|cffff0000Invalid stack size/count.|r"] = "|cffff0000Неверное кол-во/размер связки.|r"
L["|cffff0000No bid price set.|r"] = "|cffff0000Не указана ставка.|r"
L["|cffff0000Not enough cash for deposit.|r"] = "|cffff0000Не хватает денег на депозит.|r"
L["|cffff0000Not enough items available.|r"] = "|cffff0000Недостаточно предметов.|r"
L["|cffff0000Stack size too large.|r"] = " |cffff0000Размер связки слишком велик.|r"
L["|cffff0000Using %.3gx vendor price.|r"] = "|cffff0000Используя цену продавца, умноженную на %.3g.|r"
L["|cffff0000[Warning]|r Skipping your own auctions.  You might want to cancel them instead."] = "|cffff0000[Внимание]|r Пропуск своих лотов.   Возможно, вы захотите их отменить."
L["|cffff7030Buyout less than vendor price.|r"] = "|cffff7030Цена выкупа меньше цены продажи торговцу.|r"
L["|cffff7030Stack %d will have %d |4item:items;.|r"] = "|cffff7030Связка %d содержит %d |4предмет:предмета:предметов;.|r"
L["|cffffd000Using historical data.|r"] = "|cffffd000Используются исторические данные.|r"
L["|cffffff00Scanning: %d%%|r"] = "|cffffff00Сканирование: %d%%|r"
L["Choose a favorites list to edit."] = "Выберите список избранного для редактирования."
L["Choose which tab is selected when opening the auction house."] = "Укажите, какую вкладку открывать при посещении аукциона."
L["Clear All"] = "Очистить все"
L["Clear all auction house price data."] = "Очистить все цены, собранные аддоном."
L["Clear All Data"] = "Очистить все данные"
L["CLEAR_DATA_WARNING"] = "Вы действительно хотите удалить все собранные аддоном цены на предметы?"
L["Competing Auctions"] = "Конкурирующие лоты"
L["Configure"] = "Настроить"
L["Configure AuctionLite"] = "Настроить AuctionLite"
L["Consider resale value of excess items when filling an order on the \"Buy\" tab."] = "Учитывать перепродажу лишних предметов при сортировке списка во вкладке \"Покупка\"."
L["Consider Resale Value When Buying"] = "Рассматривать цену перепродажи перед покупкой"
L["Create a new favorites list."] = "Создать новый список избранного."
L["Created %d |4auction:auctions; of %s x%d."] = "Создано: %d |4лот:лота:лотов; из %s x%d."
L["Created %d |4auction:auctions; of %s x%d (%s total)."] = "Создано %d |4лот:лота:лотов; из %s x%d (%s всего)."
L["Current: %s (%.2fx historical)"] = "Текущая: %s (%.2fx историческая)"
L["Current: %s (%.2fx historical, %.2fx vendor)"] = "Текущая: %s (%.2fx историческая, %.2fx торговца)"
L["Current: %s (%.2fx vendor)"] = "Текущая: %s (%.2fx торговца)"
L["Deals must be below the historical price by this much gold."] = "Предложения должны быть ниже исторических цен на указанное количества золота."
L["Deals must be below the historical price by this percentage."] = "Предложения должны быть ниже исторических цен на указанный процент."
L["Default"] = "По умолчанию"
L["Default Number of Stacks"] = "Количество связок по умолчанию."
L["Default Stack Size"] = "Размер связки по умолчанию"
L["Delete"] = "Удалить"
L["Delete the selected favorites list."] = "Удалить выбранный список избранного."
L["%dh"] = "%d ч."
L["Disable"] = "Отключить"
L["Disenchant"] = "Распыление"
L["Do it!"] = "Выполнить!"
L["Do Nothing"] = "Ничего не делать"
L["Enable"] = "Включить"
L["Enter item name and click \"Search\""] = "Введите название предмета и нажмите \"Поиск\""
L["Enter the name of the new favorites list:"] = "Введите имя нового списка избранного:"
L["Error locating item in bags.  Please try again!"] = "Предмет не обнаружен в сумках. Попробуйте еще раз!"
L["Error when creating auctions."] = "Ошибка при объявлении аукциона."
L["Fast Auction Scan"] = "Быстрое сканирование аукциона"
L["Fast auction scan disabled."] = "Быстрое сканирование аукциона отключено."
L["Fast auction scan enabled."] = "Быстрое сканирование аукциона включено."
L["FAST_SCAN_AD"] = [=[Быстрое сканирование в AuctionLite позволяет просканировать весь аукцион за считанные секунды.

Однако, в зависимости от вашего соединения, быстрое сканирование может привести к отсоединению от сервера. Если это произошло, вы можете отключить быстрое сканирование в настройках AuctionLite.

Включить быстрое сканирование?]=]
L["Favorites"] = "Избранное"
-- L["Fixed amount to undercut market value for bid prices (e.g., 1g 2s 3c)."] = ""
-- L["Fixed amount to undercut market value for buyout prices (e.g., 1g 2s 3c)."] = ""
L["Full Scan"] = "Полн Скан"
L["Full Stack"] = "Полная связка"
L["Hide Tooltips"] = "Скрыть подсказки"
L["Historical Price"] = "Историческая цена"
L["Historical price for %d:"] = "Историческая цена за %d шт.:"
L["Historical: %s (%d |4listing:listings;/scan, %d |4item:items;/scan)"] = "Историч.: %s (%d  |4лот:лота:лотов;/скан, %d |4предмет:предмета:предметов;/скан)"
L["If Applicable"] = "Если возможно"
L["Invalid starting bid."] = "Неверная начальная цена."
L["Item"] = "Предмет"
L["Items"] = "Кол-во"
L["Item Summary"] = "Сводка предметов"
L["Last Used Tab"] = "Последняя открытая вкладка"
-- L["Listing %d of %d"] = ""
L["Listings"] = "Лоты"
L["Market Price"] = "Рыночная цена"
L["Max Stacks"] = "Макс. связок"
L["Max Stacks + Excess"] = "Макс. связок + излишек"
L["Member Of"] = "Состоит в списке"
L["Minimum Profit (Gold)"] = "Минимальная выгода (в золоте)"
L["Minimum Profit (Pct)"] = "Минимальная прибыль (МП)"
L["Mouse Cursor"] = "Курсор мыши"
L["Name"] = "Имя"
L["Net cost for %d:"] = "Чистая стоимость %d:"
L["Never"] = "Никогда"
L["New..."] = "Новый..."
L["No current auctions"] = "Аукционы отсутствуют"
L["No deals found"] = "Сделок не найдено"
L["No items found"] = "Предметов не найдено"
L["(none set)"] = "(не уст.)"
L["Note: %d |4listing:listings; of %d |4item was:items were; not purchased."] = "Примечание: не куплено %d |4лот:лота:лотов; из %d |4предмета:предметов:предметов;."
L["Not enough cash for deposit."] = "Не хватает денег на депозит."
L["Not enough items available."] = "Недостаточно предметов."
L["Number of Items"] = "Количество предметов"
L["Number of Items |cff808080(max %d)|r"] = "Количество предметов |cff808080(макс %d)|r"
L["Number of stacks suggested when an item is first placed in the \"Sell\" tab."] = "Количество связок, предлагаемое в случае, когда предмет впервые помещается в ячейку \"Продать\"."
L["One Item"] = "Один предмет"
L["One Stack"] = "Одна связка"
L["On the summary view, show how many listings/items are yours."] = "В сводке, показывать сколько лотов/предметов - ваши."
L["Open All Bags at AH"] = "Открывать все сумки при посещении аукциона"
L["Open all your bags when you visit the auction house."] = "Открывать все ваши сумки при посещении аукциона."
L["Open configuration dialog"] = "Открыть окно настроек"
L["Percent to undercut market value for bid prices (0-100)."] = "Процент \"подрезки\" цен ставки (0-100)."
L["Percent to undercut market value for buyout prices (0-100)."] = "Процент \"подрезки\" цен для выкупа (0-100)."
L["per item"] = "за предмет"
L["per stack"] = "за связку"
-- L["Placement of tooltips in \"Buy\" and \"Sell\" tabs."] = ""
L["Potential Profit"] = "Потенциальная прибыль"
L["Pricing Method"] = "Метод указания цен"
L["Print Detailed Price Data"] = "Выводить детальную информацию о ценах"
L["Print detailed price data when selling an item."] = "Выводить детальную информацию о цене при выставлении предмета на аукцион."
L["Profiles"] = "Профили"
L["Qty"] = "Кол-во"
L["Remove Items"] = "Удалить предметы"
L["Remove the selected items from the current favorites list."] = "Удалить выбранные предметы из текущего списка избранного."
L["Resell %d:"] = "Перепродажа %d:"
L["Right Side of AH"] = "Правая сторона АУКа"
L["Round all prices to this granularity, or zero to disable (0-1)."] = "Округлять все цены согласно данному значению, или 0 для отключения округления (0-1)."
L["Round Prices"] = "Округлять цены"
L["Save All"] = "Сохранить все"
L["Saved Item Settings"] = "Сохр. параметры"
L["Scan complete.  Try again later to find deals!"] = "Сканирование завершено. Попробуйте поискать предложения позднее!"
L["Scanning:"] = "Сканирование:"
L["Scanning..."] = "Сканирование..."
L["Search"] = "Поиск"
L["Searching:"] = "Поиск:"
L["Select a Favorites List"] = "Выберите список избранного"
L["Selected Stack Size"] = "Размер выбранной связки"
L["Sell Tab"] = "Продать"
L["Show auction house value in tooltips."] = "Показывать цену аукциона в подсказках."
L["Show Auction Value"] = "Показывать цену аукциона"
L["Show Deals"] = "Показать предложения"
L["Show Disenchant Value"] = "Показывать цену распыления"
L["Show expected disenchant value in tooltips."] = "Показывать цену распыления в подсказках."
L["Show Favorites"] = "Показать избранное"
L["Show Full Stack Price"] = "Показывать цену полной связки"
L["Show full stack prices in tooltips (shift toggles on the fly)."] = "Показывать цену полной связки в подсказках (Shift переключает на лету)."
L["Show How Many Listings are Mine"] = "Показывать количество моих лотов"
L["Show My Auctions"] = "Показать мои лоты"
L["Show Vendor Price"] = "Показывать цену продажи торговцу"
L["Show vendor sell price in tooltips."] = "Показывать цену продажи торговцам в подсказках."
L["Stack Count"] = "Кол-во связок"
L["Stack Size"] = "Размер связки"
L["Stack size suggested when an item is first placed in the \"Sell\" tab."] = "Размер связки, предлагаемый в случае, когда предмет впервые помещается в ячейку \"Продать\"."
L["Stack size too large."] = "Размер связки слишком велик."
L["stacks of"] = "связок по"
L["Start Tab"] = "Начальная вкладка"
L["Store Price Data"] = "Сохранять цены"
L["Store price data for all items seen (disable to save memory)."] = "Сохранять данные обо всех предметах (отключите для сохранения памяти)."
L["Time Elapsed:"] = "Прошло времени:"
L["Time Remaining:"] = "Осталось времени:"
L["Tooltip Location"] = "Расположение подсказки"
L["Tooltips"] = "Подсказки"
L["Use Coin Icons in Tooltips"] = "Использовать иконки монет в подсказках"
L["Use fast method for full scans (may cause disconnects)."] = "Использовать быстрое сканирование (может привести к отключениям от сервера)."
L["Uses the standard gold/silver/copper icons in tooltips."] = "Использовать стандартные иконки золота/серебра/меди в подсказках."
L["Vendor"] = "Торговец"
L["Vendor Multiplier"] = "Множитель цены продавца"
L["Vendor: %s"] = "Торговец: %s"
L["VENDOR_WARNING"] = "Цена выкупа ниже цены продажи торговцу. Все равно создать такой лот?"
L["Window Corner"] = "Угол окна"

