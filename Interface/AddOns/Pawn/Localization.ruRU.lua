﻿-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2015 Green Eclipse.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.

-- 
-- Russian resources
------------------------------------------------------------

local function PawnUseThisLocalization()
PawnLocal =
{
	AsteriskTooltipLine = "|TInterface\\AddOns\\Pawn\\Textures\\Question:0|t Спец. эффекты не включаются в итоговое значение.",
	AverageItemLevelIgnoringRarityTooltipLine = "Средний уровень",
	BackupCommand = "сделать резервную копию",
	BaseValueWord = "база",
	CogwheelName = "Зубчатое колесо",
	CopyScaleEnterName = "Введите имя для новой шкалы копии %s:",
	CorrectGemsValueCalculationMessage = "   -- Правильные камни оцениваются как: %g",
	CrystalOfFearName = "Кристалл Страха",
	DebugOffCommand = "отладка выкл",
	DebugOnCommand = "отладка вкл",
	DecimalSeparator = ",",
	DeleteScaleConfirmation = "Вы уверены что хотите удалить %s? Отменить удаление будет невозможно. Наберите \"%s\" для подтверждения:",
	DidntUnderstandMessage = "   (?) не распознано \"%s\".",
	EnchantedStatsHeader = "(текущее значение)",
	EngineeringName = "Инженерное дело",
	ExportAllScalesMessage = "Нажмите Ctrl+C для копирования вашей шкалы, создайте файл для резервной копии и нажмите Ctrl+V для вставки шкалы в файл.",
	ExportScaleMessage = "Нажмите Ctrl+C для копирования шкалы для |cffffffff%s|r, нажмите Ctrl+V чтобы вставитьб шкалу позже.",
	FailedToGetItemLinkMessage = "   Ошибка получения ссылки из тултипа.  Это может быть из-за конфликтов mod-ов.",
	FailedToGetUnenchantedItemMessage = "   Ошибка получения базового значения.  Это может быть из-за конфликтов mod-ов.",
	FoundStatMessage = "   %d %s",
	GemColorList1 = "%d %s",
	GemColorList2 = "%d %s или %s",
	GemColorList3 = "%d любого цвета",
	GenericGemLink = "|Hitem:%d|h[Камень %d]|h",
	GenericGemName = "(Камень %d)",
	HiddenScalesHeader = "Другие шкалы",
	ImportScaleMessage = "Нажмите Ctrl+V чтобы вставить шкалу скопированную из других источников сюда:",
	ImportScaleTagErrorMessage = "Pawn не распознал структуру шкалы. Вы уверены что скопировали полную структуру? Попробуйте снова:",
	ItemIDTooltipLine = "ID вещи",
	ItemLevelTooltipLine = "Уровень вещи",
	LootUpgradeAdvisorHeader = "Нажмите для сравнения с вашими вещами.|n",
	LootUpgradeAdvisorHeaderMany = "|TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t Улучшение %d пунктов.  Нажмите для сравнения.",
	MissocketWorthwhileMessage = "   -- Но лучше использовать только %s камень:",
	NeedNewerVgerCoreMessage = "Pawn необходима новая версия VgerCore.  Пожалуйста, используйте версию VgerCore которая шла с Pawn.",
	NewScaleDuplicateName = "Шкала с таким именем уже существует. Введите имя шкалы:",
	NewScaleEnterName = "Введите имя шкалы:",
	NewScaleNoQuotes = "Шкала не может иметь в названии символ \". Введите имя шкалы:",
	NormalizationMessage = "   -- Нормализовано делением на %g",
	NoScale = "(нет)",
	NoScalesDescription = "Для начала, импортируйте шкалу или начните новую.",
	NoStatDescription = "Выберите стат из списка слева.",
	Or = "или ",
	RenameScaleEnterName = "Введите новое имя шкалы %s:",
	SocketBonusValueCalculationMessage = "   -- Гнездо оценивается как: %g",
	StatNameText = "1 |cffffffff%s|r цениться:",
	ThousandsSeparator = ".",
	TooltipBestAnnotation = "%s  |cff8ec3e6(лучшая)|r",
	TooltipBestAnnotationSimple = "%s  ваша лучшая",
	TooltipBigUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00 улучшение%s|r",
	TooltipSecondBestAnnotation = "%s  |cff8ec3e6(вторая лучшая)|r",
	TooltipSecondBestAnnotationSimple = "%s  ваша вторая лучшая",
	TooltipUpgradeAnnotation = "%s  |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t|cff00ff00+%.0f%% улучшение%s|r",
	TooltipUpgradeFor1H = " для одноручного",
	TooltipUpgradeFor2H = " для двуручного",
	TooltipVersusLine = "%s|n  vs. |c%s%s|r",
	TotalValueMessage = "   ---- Итого: %g",
	UnenchantedStatsHeader = "(базовое значение)",
	Unusable = "(неприминимо)",
	UnusableStatMessage = "   -- %s не применимо, пропускается.",
	Usage = [=[Pawn by Vger-Azjol-Nerub
www.vgermods.com
 
/pawn -- для отображения и скрытия интерфейса Pawn
/pawn debug [ on | off ] -- писать информацию отладки в консоль
/pawn backup -- сделать резервную копию всех ваших шкал
 
For more information on customizing Pawn, please see the help file (Readme.htm) that comes with the mod.
]=],
	ValueCalculationMessage = "   %g %s x %g каждый = %g",
	VisibleScalesHeader = "Шкалы %s",
	Stats = {
		AgilityInfo = "Ловкость. Увеличивает силу атаки для некоторых классов.",
		Ap = "Сила Атаки",
		ApInfo = "Сила Атаки.  Не присутствует на вещах.  Не включается в себя силу атаки полученную от Силы или Ловкости.",
		ArmorInfo = "Броня. Не включает в себя бонусную броню на танковских вещах.",
		ArmorTypes = "Типы брони",
		AvoidanceInfo = "Избегание. Уменьшение получаемого урона от заклинаний действующих по области (AOE)",
		BonusArmorInfo = "Бонус к броне. Не включает в себя значение базовой брони.",
		Cloth = "Ткань",
		ClothInfo = "Значения для вещей из ткани",
		Crit = "Критический удар",
		CritInfo = "Критический удар. Увеличивает шанс что ваши атакующие и исцеляющие заклинания ударят с увеличенной силой.",
		DpsInfo = "Урон от оружия в секунду",
		HasteInfo = "Скорость. Увеличивает скорость произнесения заклинаний и регенерации ресурсов.",
		IndestructibleInfo = "Неразрушимость. Защищает ваши предметы от потери прочности.",
		IndestructibleIs = "Будучи |cffffffffнеразрушимым|r стоит:",
		IntellectInfo = "Интеллект. Увеличивает силу заклинаний для некоторых классов.",
		Leather = "Кожа",
		LeatherInfo = "Очки присваиваются только если вещь - кожаные доспехи.",
		LeechInfo = "Самоисцеление. Ваши атакующие и исцеляющие заклинания могут исцелить вас.",
		Mail = "Кольчуга",
		MailInfo = "Очки присваиваются только если вещь - кольчужные доспехи.",
		MasteryInfo = "Искусность.  Улучшает уникальный бонус дерева талантов.",
		MetaSocket = "Особое гнездо",
		MetaSocketInfo = "Мета гнездо, пустое или нет.  Подсчитывается только дополнительный эффект.",
		MinorStats = "Незначительные характеристики",
		MovementSpeedInfo = "Скорость передвижения. Увеличивает скорость передвижения вашего персонажа.",
		MultistrikeInfo = "Многократная атака. Вероятность того, что при использовании той или иной способности персонаж тут же использует ее повторно (до двух раз) с 30%-й эффективностью (это касается как урона, так и количества восстанавливаемого здоровья).",
		Plate = "Латы",
		PlateInfo = "Очки присваиваются только если вещь - латные доспехи.",
		PrimaryStats = "Основные характеристики",
		PvPPower = "PvP сила",
		PvPPowerInfo = "PvP-сила. Усиливает ваши способности для нанесения урона другим игрокам (но не существам).",
		PvPResilience = "PvP устойчивость",
		PvPResilienceInfo = "PvP-устойчивость. Уменьшает урон получаемый от других игроков (но не существ)",
		PvPStats = "PvP характеристики",
		SecondaryStats = "Вторичные характеристики",
		Shield = "Щит",
		ShieldInfo = "Очки присваиваются только если вещь - щит.",
		Sockets = "Гнезда",
		SpecialWeaponStats = "Специальные характеристики оружия",
		SpeedBaseline = "Базовая скорость",
		SpeedBaselineInfo = "Характеристика которая не показывается в явном виде на оружии, число отнимается от Скорости перед умножением на значение веса.",
		SpeedBaselineIs = "|cffffffffБазовая скорость|r:",
		SpeedInfo = "Скорость оружия (в секундах за удар).",
		SpeedIs = "1 секунда |cffffffffскорость удара|r ценится:",
		SpellPower = "Сила заклинаний",
		SpellPowerInfo = "Сила заклинаний.  Присутствует на кастерском оружии. Увеличивает урон и исцеление от ваших заклинаний. Не включает силу заклинаний получаемую от интеллекта.",
		SpiritInfo = "Дух. Увеличивает регенерацию маны для лекарей.",
		StaminaInfo = "Выносливость. Увеличивает количество жизни. ",
		StrengthInfo = "Сила. Увеличивает силу атаки для некоторых классов.",
		VersatilityInfo = "Универсальность. Увеличивает наносимый урон, способность к исцелению и поглощению урона. Уменьшает получаемый урон.",
		WeaponMainHandDps = "Правая рука: УВС",
		WeaponMainHandDpsInfo = "Урон от оружия в секунду. Только для оружия в правой руке.",
		WeaponMainHandMaxDamage = "Правая рука: макс урон",
		WeaponMainHandMaxDamageInfo = "Максимальный урон от оружия в правой руке.",
		WeaponMainHandMinDamage = "Правая рука: мин урон",
		WeaponMainHandMinDamageInfo = "Минимальный урон от оружия в правой руке.",
		WeaponMainHandSpeed = "Правая рука: скорость",
		WeaponMainHandSpeedInfo = "Скорость оружия в правой руке",
		WeaponMaxDamage = "Макс урон",
		WeaponMaxDamageInfo = "Максимальный урон от оружия",
		WeaponMeleeDps = "Ближний бой: УВС",
		WeaponMeleeDpsInfo = "Урон от оружия за секунду, только для оружия ближнего боя.",
		WeaponMeleeMaxDamage = "Ближний бой: макс урон",
		WeaponMeleeMaxDamageInfo = "Максимальный урон от оружия, только для оружия ближнего боя.",
		WeaponMeleeMinDamage = "Ближний бой: мин урон",
		WeaponMeleeMinDamageInfo = "Минимальный урон от оружия, только для оружия ближнего боя.",
		WeaponMeleeSpeed = "Ближний бой: скорость",
		WeaponMeleeSpeedInfo = "Скорость оружия, только для оружия ближнего боя.",
		WeaponMinDamage = "Мин урон",
		WeaponMinDamageInfo = "Минимальный урон от оружия",
		WeaponOffHandDps = "Левая рука: УВС",
		WeaponOffHandDpsInfo = "Урон от оружия за секунду, только для оружия в левой руке.",
		WeaponOffHandMaxDamage = "Левая рука: макс урон",
		WeaponOffHandMaxDamageInfo = "Максимальный урон от оружия, только для орудия в левой руке.",
		WeaponOffHandMinDamage = "Левая рука: мин урон",
		WeaponOffHandMinDamageInfo = "Минимальный укрон от оружия, только для оружия в левой руке.",
		WeaponOffHandSpeed = "Левая рука: скорость",
		WeaponOffHandSpeedInfo = "Скорость оружия, только для оружия в левой руке.",
		WeaponOneHandDps = "Одноручное: УВС",
		WeaponOneHandDpsInfo = "Урон от оружия за секунду, только для одноручного оружия (не включает в себя оружие для левой и правой руки).",
		WeaponOneHandMaxDamage = "Одноручное: макс урон",
		WeaponOneHandMaxDamageInfo = "Максимальный урон от оружия, только для одноручного оружия (не включает в себя оружие для левой и правой руки).",
		WeaponOneHandMinDamage = "Одноручное: мин урон",
		WeaponOneHandMinDamageInfo = "Минимальный урон от оружия, только для одноручного оружия (не включает в себя оружие для левой и правой руки).",
		WeaponOneHandSpeed = "Одноручное: скорость",
		WeaponOneHandSpeedInfo = "Скорость оружия, только для одноручного оружия (не включает в себя оружие для левой и правой руки).",
		WeaponRangedDps = "Дальний бой: УВС",
		WeaponRangedDpsInfo = "Урон от оружия за секунду, только для оружия дальнего боя.",
		WeaponRangedMaxDamage = "Дальний бой: макс урон",
		WeaponRangedMaxDamageInfo = "Максимальный урон от оружия, только для оружия дальнего боя",
		WeaponRangedMinDamage = "Дальний бой: мин урон",
		WeaponRangedMinDamageInfo = "Минимальный урон от оружия, только для оружия дальнего боя",
		WeaponRangedSpeed = "Дальний бой: скорость",
		WeaponRangedSpeedInfo = "Скорость оружия, только для оружия дальнего боя",
		WeaponStats = "Характеристики оружия",
		WeaponTwoHandDps = "Двуручное: УВС",
		WeaponTwoHandDpsInfo = "Урон от оружия за секунду, только для двуручного оружия.",
		WeaponTwoHandMaxDamage = "Двуручное: макс урон",
		WeaponTwoHandMaxDamageInfo = "Максимальный урон от оружия, только для двуручного оружия.",
		WeaponTwoHandMinDamage = "Двуручное: мин урон",
		WeaponTwoHandMinDamageInfo = "Минимальный урон от оружия, только для двуручного оружия.",
		WeaponTwoHandSpeed = "Двуручное: скорость",
		WeaponTwoHandSpeedInfo = "Скорость оружия, только для двуручного оружия.",
		WeaponType1HAxe = "Одноручный топор",
		WeaponType1HAxeInfo = "Очки присваиваются только если вещь - одноручный топор.",
		WeaponType1HMace = "Одноручное дробящее",
		WeaponType1HMaceInfo = "Очки присваиваются только если вещь - одноручное дробящее.",
		WeaponType1HSword = "Одноручный меч",
		WeaponType1HSwordInfo = "Очки присваиваются только если вещь - одноручный меч.",
		WeaponType2HAxe = "Двуручный топор",
		WeaponType2HAxeInfo = "Очки присваиваются только если вещь - двуручный топор.",
		WeaponType2HMace = "Двуручное дробящее",
		WeaponType2HMaceInfo = "Очки присваиваются только если вещь - двуручное дробящее.",
		WeaponType2HSword = "Двуручный меч",
		WeaponType2HSwordInfo = "Очки присваиваются только если вещь - двуручный меч.",
		WeaponTypeBow = "Лук",
		WeaponTypeBowInfo = "Очки присваиваются только если вещь - лук.",
		WeaponTypeCrossbow = "Арбалет",
		WeaponTypeCrossbowInfo = "Очки присваиваются только если вещь - арбалет.",
		WeaponTypeDagger = "Кинжал",
		WeaponTypeDaggerInfo = "Очки присваиваются только если вещь - кинжал.",
		WeaponTypeFistWeapon = "Кистевое",
		WeaponTypeFistWeaponInfo = "Очки присваиваются только если вещь - кистевое оружие.",
		WeaponTypeFrill = "Левая рука",
		WeaponTypeFrillInfo = "Очки присваиваются для вещей в левой руке (дополнительные вещи заклинателя: лампы, веера и т.д.).",
		WeaponTypeGun = "Огнестрельное",
		WeaponTypeGunInfo = "Очки присваиваются только если вещь - огнестрельное оружие.",
		WeaponTypeOffHand = "Левая рука",
		WeaponTypeOffHandInfo = "Очки присваиваются для вещей в левой руке (оружие).",
		WeaponTypePolearm = "Древковое",
		WeaponTypePolearmInfo = "Очки присваиваются только если вещь - древковое оружие.",
		WeaponTypes = "Типы оружия",
		WeaponTypeStaff = "Посох",
		WeaponTypeStaffInfo = "Очки присваиваются только если вещь - посох.",
		WeaponTypeWand = "Жезл",
		WeaponTypeWandInfo = "Очки присваиваются только если вещь - жезл.",
	},
	TooltipParsing = {
		Agility = "^%+?([-%d%.,]+) к ловкости$",
		AllStats = "^%+?([%d%.,]+) ко всем характеристикам$",
		Ap = "^%+?([%d%.,]+) к силе атаки$",
		Armor = "^Броня: %+?([%d%.,]+)$",
		Armor2 = "^%+?([%d%.,]+) к броне$",
		Avoidance = "^%+([%d%.,]+) к избеганию$",
		Axe = "^Топор$",
		BagSlots = "^%d+ [Яя]чеек .+$",
		BladesEdgeMountains = "^Острогорье$",
		BonusArmor = "^%+([%d%.,]+) к бонусу брони$",
		Bow = "^Лук$",
		ChanceOnHit = "Возможно при попадании:",
		Charges = "^.+ зарядов?$",
		Cloth = "^Ткань$",
		CooldownRemaining = "^Времени до восстановления:",
		Crit = "^%+?([%d%.,]+) к критическому удару$",
		Crit2 = "^%+?([%d%.,]+) к показателю критического удара$",
		Crossbow = "^Арбалет$",
		Dagger = "^Кинжал$",
		Design = "Эскиз:",
		DisenchantingRequires = "^Требуется",
		Dodge = "^%+?([%d%.,]+) к уклонению$",
		Dodge2 = "^%+?([%d%.,]+) к показателю уклонения$",
		Dps = "^%(([%d%.,]+) ед%. урона в секунду%)$",
		DpsAdd = "^Добавляет ([%d%.,]+) ед%. урона в секунду$",
		Duration = "^Срок действия:",
		Elite = "^Элитный$",
		EnchantmentArmorKit = "^Доспех усилен %(%+([%d%.,]+) к броне%)$",
		EnchantmentCounterweight = "^Железный противовес %(%+([%d%.,]+) к скорости%)$",
		EnchantmentFieryWeapon = "^Огненное оружие$",
		EnchantmentHealth = "^%+([%d%.,]+) к здоровью$",
		EnchantmentHealth2 = "^%+([%d%.,]+) к здоровью$",
		EnchantmentLivingSteelWeaponChain = "^Цепь для оружия из живой стали$",
		EnchantmentPyriumWeaponChain = "^Колчедановая цепь для оружия$",
		EnchantmentTitaniumWeaponChain = "^Титановая цепь для оружия$",
		Equip = "Если на персонаже:",
		FistWeapon = "^Кистевое$",
		Flexible = "^Гибкий$",
		Formula = "Формула:",
		Gun = "^Огнестрельное$",
		Haste = "^%+?([%d%.,]+) к скорости$",
		Haste2 = "^%+?([%d%.,]+) к показателю скорости$",
		HeirloomLevelRange = "^Требуется уровень %d+ - (%d+)",
		HeirloomXpBoost = "^Если на персонаже: Увеличивает количество получаемого опыта на",
		HeirloomXpBoost2 = "^Если на персонаже: Количество опыта, получаемого за убийства монстров и выполнение заданий, увеличено на",
		Heroic = "^Героический$",
		HeroicElite = "^Героический %(элитный%)$",
		HeroicThunderforged = "^Создано в Кузне Грома %(героич%.%)$",
		HeroicWarforged = "^Предмет закален в бою %(героич%.%)$",
		Hp5 = "^Восстанавливает ([%d%.,]+) здоровья каждые 5 сек%.$",
		Hp52 = "^Восстанавливает ([%d%.,]+) здоровья за 5 сек%.$",
		Hp53 = "^%+?([%d%.,]+) [зЗ]доровья [кК]аждые 5 [сС]ек%.?$",
		Hp54 = "^%+?([%d%.,]+) [зЗ]здоровья [зЗ]а 5 [сС]ек%.?$",
		Intellect = "^%+?([-%d%.,]+) к интеллекту$",
		Leather = "^Кожа$",
		Leech = "^%+([%d%.,]+) к самоисцелению$",
		Mace = "^Дробящее$",
		Mail = "^Кольчуга$",
		Manual = "Учебник:",
		Mastery = "^%+?([%d%.,]+) к искусности$",
		Mastery2 = "^%+?([%d%.,]+) к показателю искусности$",
		MetaGemRequirements = "|cff%x%x%x%x%x%xТребуется",
		MovementSpeed = "^%+([%d%.,]+) к скорости передвижения$",
		MultiStatSeparator1 = "и",
		Multistrike = "^%+([%d%.,]+) к многократной атаке$",
		NormalizationEnchant = "^Чары: (.*)$",
		OnlyFitsInMetaGemSlot = "^\"Подходит только для особого гнезда%.\"$",
		Parry = "^%+?([%d%.,]+) к парированию$",
		Parry2 = "^%+?([%d%.,]+) к показателю парирования$",
		Pattern = "Выкройка:",
		Plans = "Чертеж:",
		Plate = "^Латы$",
		Polearm = "^Древковое$",
		PvPPower = "^%+?([%d%.,]+) к PvP%-силе$",
		RaidFinder = "^Поиск рейда$",
		Recipe = "Рецепт:",
		Requires2 = "^Требуемый уровень",
		Resilience = "^%+?([%d%.,]+) к PvP%-устойчивости$",
		Resilience2 = "^UNUSED$",
		Schematic = "Схема:",
		Scope = "^Scope %(%+([%d%.,]+) Damage%)$",
		ScopeCrit = "^Scope %(%+([%d%.,]+) Critical Strike%)$",
		ScopeRangedCrit = "^%+?([%d%.,]+) Ranged Critical Strike$",
		Season = "^Сезон",
		ShadowmoonValley = "Долина Призрачной Луны",
		Shield = "^Щит$",
		SocketBonusPrefix = "При соответствии цвета:",
		Speed = "^Скорость ([%d%.,]+)$",
		Speed2 = "^UNUSED$",
		SpellPower = "^%+?([%d%.,]+) к силе заклинаний$",
		Spirit = "^%+?([-%d%.,]+) к духу$",
		Staff = "^Посох$",
		Stamina = "^%+?([-%d%.,]+) к выносливости$",
		Strength = "^%+?([-%d%.,]+) к силе$",
		Sword = "^Меч$",
		TempestKeep = "^Крепость Бурь$",
		TemporaryBuffMinutes = "^.+%(%d+ мин%)$",
		TemporaryBuffSeconds = "^.+%(%d+ сек%)$",
		Thunderforged = "^Создано в Кузне Грома$",
		Timeless = "^Вневременной предмет$",
		UpgradeLevel = "^Уровень улучшения:",
		Use = "Используется:",
		Versatility = "^%+([%d%.,]+) к [показателю ]-универсальности$",
		Wand = "^Жезл$",
		Warforged = "^Предмет закален в бою$",
		WeaponDamage = "^Урон: ([%d%.,]+) %- ([%d%.,]+)$",
		WeaponDamageArcane = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от тайной магии$",
		WeaponDamageArcaneExact = "^%+?([%d%.,]+) ед%. урона от тайной магии$",
		WeaponDamageEnchantment = "^%+?([%d%.,]+) к урону оружием$",
		WeaponDamageEquip = "^%+?([%d%.,]+) к урону от оружия%.$",
		WeaponDamageExact = "^Урон: %+?([%d%.,]+)$",
		WeaponDamageFire = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от огня$",
		WeaponDamageFireExact = "^%+?([%d%.,]+) ед%. урона от огня$",
		WeaponDamageFrost = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от магии льда$",
		WeaponDamageFrostExact = "^%+?([%d%.,]+) ед%. урона от магии льда$",
		WeaponDamageHoly = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от магии света$",
		WeaponDamageHolyExact = "^%+?([%d%.,]+) ед%. урона от магии света$",
		WeaponDamageNature = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от сил природы$",
		WeaponDamageNatureExact = "^%+?([%d%.,]+) ед%. урона от сил природы$",
		WeaponDamageShadow = "^%+?([%d%.,]+) %- ([%d%.,]+) ед%. урона от темной магии$",
		WeaponDamageShadowExact = "^%+?([%d%.,]+) ед%. урона от темной магии$",
	},
	UI = {
		AboutHeader = "О Pawn",
		AboutReadme = "Новичёк в Pawn? Для ознакомления загляните на страницу \"Помощь\"",
		AboutTab = "О Аддоне",
		AboutTranslation = "Официальная русская версия от Танковича (Магнанимус)",
		AboutVersion = "Версия %s",
		AboutWebsite = [=[Для других модов Vger, посетите vgermods.com.

Шкалы Wowhead используются с разрешения—свои отзывы по ним отправляйте на Wowhead.]=],
		CompareClearItems = "Очистить",
		CompareClearItemsTooltip = "Убрать обе сравниваемые вещи",
		CompareCogwheelSockets = "Зубчатые колеса",
		CompareColoredSockets = "Цветные гнезда",
		CompareEquipped = "На персонаже",
		CompareGemTotalValue = "Значения камней",
		CompareHeader = "Сравнить вещи используя %s",
		CompareMetaSockets = "Особые гнезда",
		CompareOtherHeader = "Другое",
		CompareShaTouchedSockets = "Пораженное ша",
		CompareSlotEmpty = "(нет вещи)",
		CompareSocketBonus = "Бонусы от камней",
		CompareSocketsHeader = "Гнезда",
		CompareSpecialEffects = "Особые эффекты",
		CompareSwap = "‹ Swap ›",
		CompareSwapTooltip = "Поменять вещи местами",
		CompareTab = "Сравнить",
		CompareVersus = "—vs.—",
		CompareWelcomeLeft = "Для начала выберите шкалу слева.",
		CompareWelcomeRight = [=[Затем перетащите вещь в окошко.

Теперь вы можете сравнить выбранную вешь с вашей использую иконку слева внизу.]=],
		CompareYourBest = "Ваша лучшая",
		GemsColorHeader = "%s камни",
		GemsHeader = "Камни для %s",
		GemsNoneFound = "Не найдено подходящие камней",
		GemsQualityLevel = "Качество камней",
		GemsQualityLevelTooltip = [=[Уровень вещей для которого предлагать камни.

Например: "463", тогда Pawn отобразит камни которые подходят для уровня вещи 463: Вещи из героических подземелий Туманов Пандарии.]=],
		GemsShowBest = "Показать лучшие доступные камни",
		GemsShowBestTooltip = "Отобразить самые лучшие камни для выбранной шкалы.  Некоторые из камней будут слишком сильными для устаревших (либо низкого качества) вещей.",
		GemsShowForItemLevel = "Показать камни рекомендованные для вещи с уровнем:",
		GemsShowForItemLevelTooltip = "Показать камни которые Pawn рекоменудет для текущей шкалы и уровня вещи.",
		GemsTab = "Камни",
		GemsWelcome = "Выберите шкалу слева чтобы увидеть камни которые Pawn рекомендует.",
		HelpHeader = "Добро пожаловать в Pawn",
		HelpTab = "Помощь",
		HelpText = [=[Pawn подсчитывает очки для вещей так что вы можете с легкостью определить какая из вещей лучше для конкретных целей.  Очки вещей отображаются в подсказке вещи


Каждая вещь может иметь множество различных очков вещи, одно значения для каждой шкалы.  Шкала содержит список статов важных для вас, и отображает значение веса для каждого стата. Вы можете иметь несколько шкал для разных целей (танк, дд, хил)


Pawn поставляется со шкалами с сайта Wowhead для каждого класса и спека: такие же веса используются в сравнении вещей.  Вы можете включить и выключить отображение шкал в подсказках, создать новую шкалу и даже поделиться ей с друзьями через интернет.


Единажды изучив основы Pawn вы сможете играть без тягостных решений: - Какая вещь лучше?.  Если хотите знать больше, загляните в readme файл.  Приятной игры!
|cff8ec3e6Используйте эту информацию пока не станете гуру:|r
 • Для сравнения статов вещей импользуйте закладку Сравнить.
 • Правый-клик на линке вещи для сравнения с одетой вещью.
 • Shift-правый-клик на вещи с сокетами для получения советов по камням.
 • Сделайте копия одной из существующих шкал для изменения значений на закладке Значения.
 • Вы можете найти множество шкал для вашего класса в интернете.
 • Взгляните в readme файл для подробного описаний возможностей Pawn.]=],
		InterfaceOptionsBody = "Нажмите на кнопку Pawn чтобы попать сюда.  Вы также можете открыть Pawn со страницы инвентаря, или назначить клавишу.",
		InterfaceOptionsWelcome = "Pawn options are found in the Pawn UI.",
		InventoryButtonTooltip = "Нажмите чтобы открыть Pawn.",
		InventoryButtonTotalsHeader = "Всего для надетых вещей:",
		KeyBindingCompareItemLeft = "Сравнить вещь (слева)",
		KeyBindingCompareItemRight = "Сравнить вещь (справа)",
		KeyBindingShowUI = "Открыть/Закрыть интерфейс Pawn",
		OptionsAdvisorHeader = "Опции советника",
		OptionsAlignRight = "Выравнивать значения по правому краю",
		OptionsAlignRightTooltip = "Включите данную опцию чтобы Pawn выравнял ваши значения и информацию по улучшениям по правому краю всплывающего сообщения.",
		OptionsBlankLine = "Добавить пустую строку перед значениями",
		OptionsBlankLineTooltip = "Позволяет добавить пустую строку перед значениями Pawn. Это позволяет сделать сообщения более читаемыми.",
		OptionsButtonHidden = "не отображать",
		OptionsButtonHiddenTooltip = "Не отображать кнопку Pawn на странице персонажа.",
		OptionsButtonPosition = "Отображать кнопку Pawn:",
		OptionsButtonPositionLeft = "слева",
		OptionsButtonPositionLeftTooltip = "Отображать кнопку Pawn в левом нижнем углу страницы персонажа.",
		OptionsButtonPositionRight = "справа",
		OptionsButtonPositionRightTooltip = "Отображать кнопку Pawn в правом нижнем углу страницы персонажа.",
		OptionsColorBorder = "Цветная рамка вокруг улучшения",
		OptionsColorBorderTooltip = "Включите данную опцию для отображаения цветной рамки (зеленой) для улучшений.  Отключите данную опцию если обнаружены конфликты с другими модами.",
		OptionsCurrentValue = "Отображать текущее и базовое значение",
		OptionsCurrentValueTooltip = [=[Включите опцию чтобы Pawn показывал два значения для вещей: текущее значение, отображает текущее состояние вещи (включая камни, чары, перековку) в дополнение к базовому значению, которое Pawn обычно отображает.  Текущее значение отображается перед базовым значением.

Если вы в процессе прокачки - используйте текущее значение, если вы уже достигли максимального уровня используйте оба значения.]=],
		OptionsDebug = "Отображать отладочную информацию",
		OptionsDebugTooltip = [=[Если вы не уверены как Pawn рассчитывает значение для конкретной вещи, включите данную опцию и Pawn отобразит в чате все параметры при наедении указателя мыши на вещь.  Эта информация включает в себя значения которые по мнению Pawn присутствуют в вещи, а также значения которые Pawn не смог распознать.

Эта опция заполнит ваш чат очень быстро и возмножно замедлит отклик игры. Используйте эту опцию только для исследований.

Команды:
/pawn debug on
/pawn debug off]=],
		OptionsHeader = "Опции Pawn",
		OptionsIgnoreGemsWhileLevelingCheck = "Игнорировать сокеты на низко-уровневых вещах",
		OptionsIgnoreGemsWhileLevelingCheckTooltip = [=[Включите данную опцию чтобы Pawn игнорировал сокеты на низко-уровневых вещах в процессе расчета значений, т.к. большинство игроков не прилагают усилий (либо слишком дорого) для использования ювелирных камней в процессе прокачки. "Низко-уровневая" вещь всегда слабее чем вещь полученная в героическом подземелье на высших уровнях.

Если опция выбрана, Pawn будет по прежнему подбирать камни для низко-уровневых вещей, но сокеты будут игнорироваться при подсчете значений и вещи с сокетами не будут отображаться как улучшения.

Если опция не выбрана, Pawn будет подсчитывать значения для вещей как будто в вещах стоят соответствующие ювелирные камни независимо от уровня персонажа.]=],
		OptionsInventoryIcon = "Отображать иконку вещи",
		OptionsInventoryIconTooltip = "Включите опцию для отображения иконки вещи.",
		OptionsItemIDs = "Отображать ID вещи",
		OptionsItemIDsTooltip = [=[Enable this option to have Pawn display the item ID of every item you come across, as well as the IDs of all enchantments and gems.

Every item in World of Warcraft has an ID number associated with it.  This information is generally only useful to mod authors.]=],
		OptionsLootAdvisor = "Отображать советы по улучшениям (подземелья)",
		OptionsLootAdvisorTooltip = "Когда вещь падает в подземельи и она является улучшением для вас, Pawn отобразит окошко рядом с окном розыгрыша добычи говорящее об улучшении.",
		OptionsOtherHeader = "Другие опции",
		OptionsQuestUpgradeAdvisor = "Отображать советы по улучшениям (квесты)",
		OptionsQuestUpgradeAdvisorTooltip = "In your quest log and when talking to NPCs, if one of the quest reward choices is an upgrade for your current gear, Pawn will show a green arrow icon on that item.  If none of the items is an upgrade, Pawn will show a pile of coins on the item that is worth the most when sold to a vendor.",
		OptionsResetUpgrades = "Обновить вещи",
		OptionsResetUpgradesTooltip = [=[Pawn will forget what it knows about the best items you've ever equipped and re-scan your gear in order to provide more up-to-date upgrade information in the future.

Use this feature if you find that Pawn is making poor upgrade suggestions as a result of items that you've vendored, destroyed, or otherwise do not use anymore.  This will affect all of your characters that use Pawn.]=],
		OptionsSocketingAdvisor = "Отображать советы по камням",
		OptionsSocketingAdvisorTooltip = "When adding gems to an item, Pawn will show a popup suggesting gems that you can add to the item that will maximize its power.  (To see the full list of gem suggestions for each color, see the Gems tab, where you can also customize the quality of gems to use.)",
		OptionsTab = "Настройки",
		OptionsTooltipHeader = "Опции подсказок",
		OptionsTooltipUpgradesOnly = "отображать только улучшения",
		OptionsTooltipUpgradesOnlyTooltip = [=[This is the simplest option.  Only show upgrade percentages for items that are an upgrade to your current gear, and indicate which items are the best items you own for each scale.  Don't show anything at all for lesser items.

|cff8ec3e6Fire:|r  |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% upgrade|r

...or...

|cff8ec3e6Fire:  your best|r]=],
		OptionsTooltipValuesAndUpgrades = "отображать значения и улучшения в %",
		OptionsTooltipValuesAndUpgradesTooltip = [=[Show Pawn values for all of your visible scales on all items, except those that have a value of zero.  In addition, indicate which items are an upgrade to your current gear.

|cff8ec3e6Frost:  123.4
Fire:  156.7 |TInterface\AddOns\Pawn\Textures\UpgradeArrow:0|t |cff00ff00+10% upgrade|r]=],
		OptionsTooltipValuesOnly = "отображать только значения, без улучшений в %",
		OptionsTooltipValuesOnlyTooltip = [=[Show Pawn values for all of your visible scales on all items, except those that have a value of zero.  Don't indicate which items are an upgrade to your current gear.  This option reflects the default behavior of older versions of Pawn.

|cff8ec3e6Frost:  123.4
Fire:  156.7|r]=],
		OptionsUpgradeHeader = "Отображать |TInterface\\AddOns\\Pawn\\Textures\\UpgradeArrow:0|t для улучшений:",
		OptionsUpgradesForBothWeaponTypes = "Отображать улучшения для одноручного и двуручного оружия",
		OptionsUpgradesForBothWeaponTypesTooltip = [=[Pawn's upgrade advisors should track and show upgrades for your two-handed weapons and your dual-wield (or for casters, main hand and off-hand frill) weapon sets separately.

If checked, you could be using a two-handed weapon and still see clearly inferior one-handed weapons as upgrades if they're better than the previous best (or second-best) one-handed weapon you had, because Pawn is tracking upgrades separately for the two weapon sets.

If unchecked, equipping a two-handed weapon will prevent Pawn from showing you upgrades for one-handed items and vice-versa.]=],
		OptionsWelcome = "Настройте Pawn на свой вкус.  Изменения применятся незамедлительно.",
		ScaleChangeColor = "Изменить цвет",
		ScaleChangeColorTooltip = "Измените цвет шкалы в подсказках.",
		ScaleCopy = "Копировать",
		ScaleCopyTooltip = "Создать новую шкалу копированием значений из текущей.",
		ScaleDefaults = "По-умолчанию",
		ScaleDefaultsTooltip = "Создать новую шкалу со значениями по-умолчанию.",
		ScaleDeleteTooltip = [=[Удалить шкалу.

Эту команду нельзя обратить!]=],
		ScaleEmpty = "Пустая",
		ScaleEmptyTooltip = "Создать пустую шкалу с нуля",
		ScaleExport = "Экспорт",
		ScaleExportTooltip = "Поделиться шкалой с другими игроками через интернет.",
		ScaleHeader = "Управление вашими шкалами Pawn",
		ScaleImport = "Импорт",
		ScaleImportTooltip = "Добавить новую шкалу полученную из интернета.",
		ScaleNewHeader = "Создать новую шкалу",
		ScaleRename = "Переименовать",
		ScaleRenameTooltip = "Переименовать шкалу.",
		ScaleSelectorHeader = "Выбрать шкалу:",
		ScaleSelectorShowScale = "Отображать шкалу в подсказках",
		ScaleSelectorShowScaleTooltip = [=[When this option is checked, values for this scale will show up in item tooltips for this character.  Each scale can show up for one of your characters, multiple characters, or no characters at all.

Shortcut: Shift+click a scale]=],
		ScaleShareHeader = "Поделиться вашими шкалами",
		ScaleTab = "Шкалы",
		ScaleTypeNormal = "Вы можете изменить шкалу на закладке Значения.",
		ScaleTypeReadOnly = "Вы должны сделать копию шкалы для ее изменения.",
		ScaleWelcome = "Шкала - это набор параметров и весовых значений.  Вы можете изменять значения шкал на выши или воспользоваться уже существующими.",
		SocketingAdvisorButtonTooltip = "Нажмите для открытия закладки камней в Pawn",
		SocketingAdvisorHeader = "Pawn советник по камням рекомендует:",
		SocketingAdvisorIgnoreThisItem = "Не беспокойтесь о добавлении ювелирных камней на эту низко-уровневую вещь. Но если очень хочется то:",
		ValuesDoNotShowUpgradesFor1H = "Не отображать улучшения для одноручного оружия",
		ValuesDoNotShowUpgradesFor2H = "Не отображать улучшения для двуручного оружия",
		ValuesDoNotShowUpgradesTooltip = "Enable this option to hide upgrades of this type of item.  For example, even though paladin tanks can use two-handed weapons, a two-handed weapon is never an \"upgrade\" for a paladin tanking set, so Pawn should not show upgrade notifications for them.  Similarly, retribution paladins can use one-handed weapons, but they are never upgrades.",
		ValuesFollowSpecialization = "Отображать улучшения для специализации по броне после 50 уровня",
		ValuesFollowSpecializationTooltip = "Enable this option to hide upgrades for armor that your class does not specialize in after level 50.  For example, at level 50 holy paladins learn Plate Specialization, which increases their intellect by 5% when wearing only plate armor.  When this option is chosen Pawn will never consider cloth, leather, or mail to be upgrades for level 50+ holy paladins.",
		ValuesHeader = "Значения шкалы для %s",
		ValuesIgnoreStat = "Не используемое",
		ValuesIgnoreStatTooltip = "Enable this option to cause any item with this stat to not get a value for this scale.  For example, shamans can't wear plate, so a scale designed for a shaman can mark plate as unusable so that plate armor doesn't get a value for that scale.",
		ValuesNormalize = "Нормализовать значения (как Wowhead)",
		ValuesNormalizeTooltip = [=[Enable this option to divide the final calculated value for an item by the sum of all stat values in your scale, like Wowhead and Lootzor do.  This helps to even out situations like where one scale has stat values around 1 and another has values around 5.  It also helps to keep numbers manageably small.

For more information on this setting, see the readme file.]=],
		ValuesRemove = "Удалить",
		ValuesRemoveTooltip = "Remove this stat from the scale.",
		ValuesTab = "Значения",
		ValuesWelcome = "Вы можете изменять веса параметров для шкалы.  Для управления шкалами перейдите на закладку Шкалы.",
		ValuesWelcomeNoScales = "Шкала не выбрана.  Для начала создайте шкалу.",
		ValuesWelcomeReadOnly = "Выбранная шкала не может быть изменена.  Если вы хотите поменять значения, сделайте копию текущей шкалы.",
	},
	Wowhead = {
		DeathKnightBloodTank = "Рыцарь смерти: Кровь",
		DeathKnightFrostDps = "Рыцарь смерти: Лед",
		DeathKnightUnholyDps = "Рыцарь смерти: Нечестивость",
		DruidBalance = "Друид: Баланс",
		DruidFeralDps = "Друид: Сила зверя",
		DruidFeralTank = "Друид: Страж",
		DruidRestoration = "Друид: Исцеление",
		HunterBeastMastery = "Охотник: Повелитель зверей",
		HunterMarksman = "Охотник: Стрельба",
		HunterSurvival = "Охотник: Выживание",
		MageArcane = "Маг: Тайная Магия",
		MageFire = "Маг: Огонь",
		MageFrost = "Маг: Лед",
		MonkBrewmaster = "Монах: Хмелевар",
		MonkMistweaver = "Монах: Ткач туманов",
		MonkWindwalker = "Монах: Танцующий с ветром",
		PaladinHoly = "Паладин: Свет",
		PaladinRetribution = "Паладин: Воздаяние",
		PaladinTank = "Паладин: Защита",
		PriestDiscipline = "Прист: Послушание",
		PriestHoly = "Прист: Свет",
		PriestShadow = "Прист: Тень",
		Provider = "Шкалы Wowhead",
		ProviderStarter = "Начальные шкалы",
		RogueAssassination = "Разбойник: Ликвидация",
		RogueCombat = "Разбойник: Бой",
		RogueSubtlety = "Разбойник: Скрытность",
		ShamanElemental = "Шаман: Стихии",
		ShamanEnhancement = "Шаман: Совершенствованиме",
		ShamanRestoration = "Шаман: Исцеление",
		WarlockAffliction = "Чернокнижник: Колдовство",
		WarlockDemonology = "Чернокнижник: Демонология",
		WarlockDestruction = "Чернокнижник: Разрушение",
		WarriorArms = "Воин: Оружие",
		WarriorFury = "Воин: Неистовство",
		WarriorTank = "Воин: Защита",
	},
}
end

if GetLocale() == "ruRU" then
	PawnUseThisLocalization()
end

-- After using this localization or deciding that we don't need it, remove it from memory.
PawnUseThisLocalization = nil
