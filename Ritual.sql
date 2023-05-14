-- Lua activation for new beliefs
UPDATE CustomModOptions	SET Value = 1 WHERE Name = 'RELIGION_EXTENSIONS';
UPDATE CustomModOptions SET	Value = 1 WHERE	Name = 'YIELD_MODIFIER_FROM_UNITS';
UPDATE CustomModOptions	SET Value = 1 WHERE Name = 'EVENTS_FOUND_RELIGION';

--HEART OF THE RITUAL--
INSERT INTO BuildingClasses
		(Type, 						Description, 				DefaultBuilding, 	MaxPlayerInstances)
VALUES	('BUILDINGCLASS_RITUAL_HEART', 	'TXT_KEY_BUILDING_RITUAL_HEART', 'BUILDING_RITUAL_HEART', 1);

INSERT INTO Buildings
			(Type,              BuildingClass,           Description,                Civilopedia,                      Help,							Strategy,                            ArtDefineTag,   Cost, 	FaithCost, NukeImmune, HurryCostModifier, MinAreaSize, NeverCapture, IconAtlas,				PortraitIndex, HolyCity, ConversionModifier, ReligiousPressureModifier, IsReformation, NumCityCostMod, GlobalFollowerPopRequired, ReligiousUnrestFlatReduction, UnlockedByBelief, FaithToVotes, CityWorkingChange)
SELECT		'BUILDING_RITUAL_HEART', 'BUILDINGCLASS_RITUAL_HEART', 'TXT_KEY_BUILDING_RITUAL_HEART', 'TXT_KEY_BUILDING_RITUAL_HEART_PEDIA', 'TXT_KEY_BUILDING_RITUAL_HEART_HELP', 'TXT_KEY_BUILDING_RITUAL_HEART_STRATEGY', 'TEMPLE',       -1,  	300,       1,          -1,                -1,          1,            'BW_ATLAS_2',	2,			   1,		 -20,				 100,						0,			   0,			   0,						  1, 							1,               	10, 3;

INSERT INTO BuildingClasses 	
			(Type,									DefaultBuilding,					NoLimit)
VALUES		('BUILDINGCLASS_D_FOR_CASCADING_STACKS',	'BUILDING_D_FOR_CASCADING_RITUAL',	1);

INSERT INTO Buildings 	
			(Type,								BuildingClass,							Description,								IsReformation, CapitalOnly, 	GoldMaintenance,	Cost,	FaithCost,	GreatWorkCount, NeverCapture,	NukeImmune, ConquestProb,	HurryCostModifier,	IconAtlas,			PortraitIndex, 	IsDummy)
VALUES		
			('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_D_FOR_CASCADING_STACKS',	'TXT_KEY_BUILDING_D_FOR_CASCADING_RITUAL',	0, 				0, 				0,					-1,		-1,			-1,				1,				1,			0,				-1,					'BW_ATLAS_2',	2, 				1);


INSERT INTO Building_ImprovementYieldChangesGlobal
		(BuildingType, 			ImprovementType, 		YieldType, 		Yield)
VALUES	('BUILDING_RITUAL_HEART', 	'IMPROVEMENT_HOLY_SITE', 'YIELD_FAITH', 5);

INSERT INTO Building_BuildingClassLocalYieldChanges
		(BuildingType,						BuildingClassType,			YieldType,					YieldChange)
VALUES	('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_RITUAL_HEART',	'YIELD_FOOD',				1),
		('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_RITUAL_HEART',	'YIELD_FAITH',				1),
		('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_RITUAL_HEART',	'YIELD_GOLDEN_AGE_POINTS',	1),
		('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_RITUAL_HEART',	'YIELD_GREAT_GENERAL_POINTS',				1),
		('BUILDING_D_FOR_CASCADING_RITUAL',	'BUILDINGCLASS_RITUAL_HEART',	'YIELD_GREAT_ADMIRAL_POINTS',				1);
INSERT INTO Building_GlobalYieldModifiers (BuildingType, YieldType, Yield)
VALUES ('BUILDING_D_FOR_CASCADING_RITUAL', 'YIELD_FOOD', 1),
	   ('BUILDING_D_FOR_CASCADING_RITUAL', 'YIELD_FAITH',1);

INSERT INTO UnitClasses
			(Type,								Description,							DefaultUnit)
VALUES		('UNITCLASS_CASCADING_RITUAL',	'TXT_KEY_UNIT_CASCADING_RITUAL',	'UNIT_CASCADING_RITUAL');

INSERT INTO Units 	
			(Type,							Class, 								PrereqTech, 			Description, 							Civilopedia, 								Strategy, 										Help, 										ReligionSpreads, ReligiousStrength,	Range, BaseSightRange, RangedCombat, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, CombatClass, Domain, DefaultUnitAI, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AirUnitCap, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas,	PortraitIndex, 	IconAtlas,				MoveRate, PurchaseCooldown)
SELECT		'UNIT_CASCADING_RITUAL',	'UNITCLASS_CASCADING_RITUAL',	'TECH_AGRICULTURE', 'TXT_KEY_UNIT_CASCADING_RITUAL',	'TXT_KEY_UNIT_CASCADING_RITUAL_TEXT',	'TXT_KEY_UNIT_CASCADING_RITUAL_STRATEGY',	'TXT_KEY_UNIT_CASCADING_RITUAL_HELP',	ReligionSpreads, ReligiousStrength+1000,	Range, BaseSightRange, RangedCombat, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, CombatClass, Domain, DefaultUnitAI, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AirUnitCap, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas,	2, 				'BW_ATLAS_2',	MoveRate, PurchaseCooldown
FROM Units WHERE Type = 'UNIT_MISSIONARY';

INSERT INTO Unit_BuildingClassRequireds 
		(UnitType, 						BuildingClassType)
VALUES	('UNIT_CASCADING_RITUAL', 	'BUILDINGCLASS_RITUAL_HEART');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		'UNIT_CASCADING_RITUAL', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_MISSIONARY';	
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		'UNIT_CASCADING_RITUAL',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_MISSIONARY';

INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType,					Flavor)
VALUES		('UNIT_CASCADING_RITUAL',	'FLAVOR_CULTURE',			10),
			('UNIT_CASCADING_RITUAL',	'FLAVOR_GOLD',				10),
			('UNIT_CASCADING_RITUAL',	'FLAVOR_PRODUCTION',		10),
			('UNIT_CASCADING_RITUAL',	'FLAVOR_SCIENCE',			10),
			('UNIT_CASCADING_RITUAL',	'FLAVOR_WONDER',			10),
			('UNIT_CASCADING_RITUAL',	'FLAVOR_INFRASTRUCTURE',	10);