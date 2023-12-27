local dbVersion = 2
local defaultDB = {
    global = {
        weeklyReset = 0,
        characters = {},
        minimap = {
            minimapPos = 195,
            hide = false,
            lock = false
        },
        sorting = "lastUpdate",
        showTiers = true,
        showAffixColors = true,
        showAffixHeader = true,
        showZeroRatedCharacters = true,
        announceKeystones = {
            autoParty = true,
            autoGuild = false,
            multiline = true
        },
        raids = {
            enabled = true,
            colors = true,
            currentTierOnly = true,
            lfr = true,
            normal = true,
            heroic = true,
            mythic = true,
            boxes = false
        }
    }
}
local defaultCharacter = {
    GUID = "",
    lastUpdate = 0,
    currentSeason = 0,
    enabled = true,
    info = {
        name = "",
        realm = "",
        level = 0,
        race = {
            name = "",
            file = "",
            id = 0
        },
        class = {
            name = "",
            file = "",
            id = 0
        },
        factionGroup = {
            english = "",
            localized = ""
        },
        ilvl = {
            level = 0,
            equipped = 0,
            pvp = 0,
            color = "ffffffff"
        },
    },
    raids = {
        savedInstances = {
            -- [1] = {
            --     ["id"] = 0,
            --     ["name"] = "",
            --     ["lockoutId"] = 0,
            --     ["reset"] = 0,
            --     ["difficultyID"] = 0,
            --     ["locked"] = false,
            --     ["extended"] = false,
            --     ["instanceIDMostSig"] = 0,
            --     ["isRaid"] = true,
            --     ["maxPlayers"] = 0,
            --     ["difficultyName"] = "",
            --     ["numEncounters"] = 0,
            --     ["encounterProgress"] = 0,
            --     ["extendDisabled"] = false,
            --     ["instanceID"] = 0,
            --     ["link"] = "",
            --     ["expires"] = 0,
            --     ["encounters"] = {
            --         [1] = {
            --             ["instanceEncounterID"] = 0,
            --             ["bossName"] = "",
            --             ["fileDataID"] = 0,
            --             ["killed"] = false
            --         }
            --     }
            -- }
        },
    },
    mythicplus = { -- Mythic Plus
        numCompletedDungeonRuns = {
            -- heroic = 0,
            -- mythic = 0,
            -- mythicPlus = 0
        },
        rating = 0,
        keystone = {
            challengeModeID = 0,
            mapId = 0,
            level = 0,
            color = "",
            itemId = 0,
            itemLink = "",
        },
        weeklyRewardAvailable = false,
        bestSeasonScore = 0,
        bestSeasonNumber = 0,
        runHistory = {},
        dungeons = {
            -- [1] = {
            --     rating = 0,
            --     level = 0,
            --     finishedSuccess = false,
            --     bestTimedRun = {
            --         ["durationSec"] = 0,
            --         ["completionDate"] = {
            --             ["year"] = 0,
            --             ["month"] = 0,
            --             ["minute"] = 0,
            --             ["hour"] = 0,
            --             ["day"] = 0,
            --         },
            --         ["affixIDs"] = {
            --             0, 0, 0
            --         },
            --         ["level"] = 0,
            --         ["members"] = {
            --             {
            --                 ["specID"] = 0,
            --                 ["name"] = "",
            --                 ["classID"] = 0,
            --             }
            --         }
            --     },
            --     bestNotTimedRun = {},
            --     affixScores = {
            --         [1] = {
            --             ["name"] = "Tyrannical",
            --             ["overTime"] = false,
            --             ["level"] = 0,
            --             ["durationSec"] = 0,
            --             ["score"] = 0,
            --         },
            --         [2] = {
            --             ["name"] = "Fortified",
            --             ["overTime"] = false,
            --             ["level"] = 0,
            --             ["durationSec"] = 0,
            --             ["score"] = 0,
            --         },
            --     }
            -- }
        },
    },
    pvp = {},
    vault = {
        hasAvailableRewards = false,
        slots = {
            -- [1] = {
            --     ["threshold"] = 0,
            --     ["type"] = 0,
            --     ["index"] = 0,
            --     ["rewards"] = {},
            --     ["progress"] = 0,
            --     ["level"] = 0,
            --     ["raidString"] = "",
            --     ["id"] = 0,
            --     ["exampleRewardLink"] = ""
            --     ["exampleRewardUpgradeLink"] = ""
            -- },
        }
    },
}

local dataAffixes = {
    [9]  = {affixID = 9, name = "Tyrannical", icon = "Interface/Icons/achievement_boss_archaedas"},
    [10] = {affixID = 10, name = "Fortified", icon = "Interface/Icons/ability_toughness"},
}

local dataDungeons = {
    -- [206] = { seasonID = 2, challengeModeID = 206, mapId = 1458, time = 0, abbr = "NL", name = "Neltharion's Lair" },
    -- [245] = { seasonID = 2, challengeModeID = 245, mapId = 1754, time = 0, abbr = "FH", name = "Freehold" },
    -- [251] = { seasonID = 2, challengeModeID = 251, mapId = 1841, time = 0, abbr = "UNDR", name = "The Underrot" },
    -- [403] = { seasonID = 2, challengeModeID = 403, mapId = 2451, time = 0, abbr = "ULD", name = "Uldaman: Legacy of Tyr" },
    -- [404] = { seasonID = 2, challengeModeID = 404, mapId = 2519, time = 0, abbr = "NELT", name = "Neltharus" },
    -- [405] = { seasonID = 2, challengeModeID = 405, mapId = 2520, time = 0, abbr = "BH", name = "Brackenhide Hollow" },
    -- [406] = { seasonID = 2, challengeModeID = 406, mapId = 2527, time = 0, abbr = "HOI", name = "Halls of Infusion" },
    -- [438] = { seasonID = 2, challengeModeID = 438, mapId = 657, time = 0, abbr = "VP", name = "The Vortex Pinnacle" },
    [168] = {seasonID = 3, challengeModeID = 168, mapId = 1279, time = 0, abbr = "EB", name = "The Everbloom"},
    [198] = {seasonID = 3, challengeModeID = 198, mapId = 1466, time = 0, abbr = "DHT", name = "Darkheart Thicket"},
    [199] = {seasonID = 3, challengeModeID = 199, mapId = 1501, time = 0, abbr = "BRH", name = "Black Rook Hold"},
    [244] = {seasonID = 3, challengeModeID = 244, mapId = 1763, time = 0, abbr = "AD", name = "Atal'Dazar"},
    [248] = {seasonID = 3, challengeModeID = 248, mapId = 1862, time = 0, abbr = "WM", name = "Waycrest Manor"},
    [456] = {seasonID = 3, challengeModeID = 456, mapId = 643, time = 0, abbr = "TOTT", name = "Throne of the Tides"},
    [463] = {seasonID = 3, challengeModeID = 463, mapId = 2579, time = 0, abbr = "FALL", name = "Dawn of the Infinite: Galakrond's Fall", short = "DOTI: Galakrond's Fall"},
    [464] = {seasonID = 3, challengeModeID = 464, mapId = 2579, time = 0, abbr = "RISE", name = "Dawn of the Infinite: Murozond's Rise", short = "DOTI: Murozond's Rise"},
}

local dataRaids = {
    -- [1200] = { seasonID = 1, journalInstanceID = 1200, instanceID = 2522, order = 1, numEncounters = 8, encounters = {}, abbr = "VOTI", name = "Vault of the Incarnates" },
    -- [1208] = { seasonID = 2, journalInstanceID = 1208, instanceID = 2569, order = 2, numEncounters = 9, encounters = {}, abbr = "ATSC", name = "Aberrus, the Shadowed Crucible" },
    [1207] = {seasonID = 3, journalInstanceID = 1207, instanceID = 2549, order = 3, numEncounters = 9, encounters = {}, abbr = "ATDH", name = "Amirdrassil, the Dream's Hope"},
}

local dataRaidDifficulties = {
    [14] = {id = 14, color = RARE_BLUE_COLOR, order = 2, abbr = "N", name = "Normal"},
    [15] = {id = 15, color = EPIC_PURPLE_COLOR, order = 3, abbr = "HC", name = "Heroic"},
    [16] = {id = 16, color = LEGENDARY_ORANGE_COLOR, order = 4, abbr = "M", name = "Mythic"},
    [17] = {id = 17, color = UNCOMMON_GREEN_COLOR, order = 1, abbr = "LFR", name = "Looking For Raid", short = "LFR"},
}

function AlterEgo:InitDB()
    self.db = self.Libs.AceDB:New("AlterEgoDB", defaultDB, true)
end

-- Temp fix until a better solution, since C_MythicPlus.GetCurrentUIDisplaySeason() isn't ready on init
function AlterEgo:GetSeason()
    return 3
end

function AlterEgo:GetCharacter(playerGUID)
    if playerGUID == nil then
        playerGUID = UnitGUID("player")
    end

    if self.db.global.characters[playerGUID] == nil then
        self.db.global.characters[playerGUID] = AE_table_copy(defaultCharacter)
    end

    self.db.global.characters[playerGUID].GUID = playerGUID

    return self.db.global.characters[playerGUID]
end

function AlterEgo:GetRaidDifficulties()
    local result = {}
    for _, difficulty in pairs(dataRaidDifficulties) do
        table.insert(result, difficulty)
    end

    table.sort(result, function(a, b)
        return a.order < b.order
    end)

    return result
end

function AlterEgo:GetAffixes()
    local result = {}
    for _, affix in pairs(dataAffixes) do
        table.insert(result, affix)
    end

    table.sort(result, function(a, b)
        return a.affixID < b.affixID
    end)

    return result
end

function AlterEgo:GetDungeons()
    local result = {}
    for _, dungeon in pairs(dataDungeons) do
        if dungeon.seasonID == self:GetSeason() then
            table.insert(result, dungeon)
        end
    end

    table.sort(result, function(a, b)
        return a.name < b.name
    end)

    return result
end

function AlterEgo:GetRaids()
    local result = {}
    for _, raid in pairs(dataRaids) do
        if raid.seasonID == self:GetSeason() then
            table.insert(result, raid)
        end
    end

    table.sort(result, function(a, b)
        return a.order < b.order
    end)

    return result
end

function AlterEgo:GetCharacters(unfiltered)
    local characters = {}
    for _, character in pairs(self.db.global.characters) do
        if character.info.level ~= nil and character.info.level == 70 then
            table.insert(characters, character)
        end
    end

    -- Sorting
    table.sort(characters, function(a, b)
        if self.db.global.sorting == "name.asc" then
            return a.info.name < b.info.name
        elseif self.db.global.sorting == "name.desc" then
            return a.info.name > b.info.name
        elseif self.db.global.sorting == "realm.asc" then
            return a.info.realm < b.info.realm
        elseif self.db.global.sorting == "realm.desc" then
            return a.info.realm > b.info.realm
        elseif self.db.global.sorting == "rating.asc" then
            return a.mythicplus.rating < b.mythicplus.rating
        elseif self.db.global.sorting == "rating.desc" then
            return a.mythicplus.rating > b.mythicplus.rating
        elseif self.db.global.sorting == "ilvl.asc" then
            return a.info.ilvl.level < b.info.ilvl.level
        elseif self.db.global.sorting == "ilvl.desc" then
            return a.info.ilvl.level > b.info.ilvl.level
        end
        return a.lastUpdate > b.lastUpdate
    end)

    -- Filters
    if unfiltered then
        return characters
    end

    local charactersFiltered = {}
    for _, character in ipairs(characters) do
        local keep = true
        if not character.enabled then
            keep = false
        end
        if self.db.global.showZeroRatedCharacters == false and (character.mythicplus.rating and character.mythicplus.rating <= 0) then
            keep = false
        end
        if keep then
            table.insert(charactersFiltered, character)
        end
    end

    return charactersFiltered
end

function AlterEgo:UpdateDB()
    self:TaskWeeklyReset()
    self:UpdateRaidInstances()
    self:UpdateCharacterInfo()
    self:UpdateKeystoneItem()
    self:UpdateVault()
    self:UpdateMythicPlus()
end

function AlterEgo:MigrateDB()
    if type(self.db.global.dbVersion) ~= "number" then
        self.db.global.dbVersion = 1
    end
    if self.db.global.dbVersion < dbVersion then
        if self.db.global.dbVersion == 1 then
            for characterIndex in pairs(self.db.global.characters) do
                self.db.global.characters[characterIndex].raids.killed = nil
                if self.db.global.characters[characterIndex].raids.savedInstances then
                    for savedInstanceIndex, savedInstance in ipairs(self.db.global.characters[characterIndex].raids.savedInstances) do
                        if savedInstance.instanceID == 2549 and savedInstance.encounters then
                            self.db.global.characters[characterIndex].raids.savedInstances[savedInstanceIndex].encounters[4].instanceEncounterID = 2731
                            self.db.global.characters[characterIndex].raids.savedInstances[savedInstanceIndex].encounters[5].instanceEncounterID = 2728
                        end
                    end
                end
            end
            self.db.global.dbVersion = 2
        end
        self:MigrateDB()
    end
end

function AlterEgo:TaskWeeklyReset()
    if type(self.db.global.weeklyReset) == "number" and self.db.global.weeklyReset <= time() then
        AE_table_foreach(self.db.global.characters, function(character)
            AE_table_foreach(character.vault.slots, function(slot)
                if slot.progress >= slot.threshold then
                    character.vault.hasAvailableRewards = true
                end
            end)
            AE_table_foreach(character.mythicplus.runHistory, function(run)
                run.thisWeek = false
            end)
            wipe(character.vault.slots or {})
            wipe(character.mythicplus.keystone or {})
            wipe(character.mythicplus.numCompletedDungeonRuns or {})
        end)
    end
    self.db.global.weeklyReset = time() + C_DateAndTime.GetSecondsUntilWeeklyReset()
end

function AlterEgo:loadGameData()
    for _, raid in pairs(dataRaids) do
        -- EncounterJournal Quirk: This has to be called first before we can get encounter journal info.
        EJ_SelectInstance(raid.journalInstanceID)
        wipe(raid.encounters or {})
        for encounterIndex = 1, raid.numEncounters do
            local name, description, journalEncounterID, journalEncounterSectionID, journalLink, journalInstanceID, instanceEncounterID, instanceID = EJ_GetEncounterInfoByIndex(encounterIndex, raid.journalInstanceID)
            local encounter = {
                index = encounterIndex,
                name = name,
                description = description,
                journalEncounterID = journalEncounterID,
                journalEncounterSectionID = journalEncounterSectionID,
                journalLink = journalLink,
                journalInstanceID = journalInstanceID,
                instanceEncounterID = instanceEncounterID,
                instanceID = instanceID,
            }
            raid.encounters[encounterIndex] = encounter
        end
    end

    for _, dungeon in pairs(dataDungeons) do
        local dungeonName, _, dungeonTimeLimit, dungeonTexture = C_ChallengeMode.GetMapUIInfo(dungeon.challengeModeID)
        dungeon.name = dungeonName
        dungeon.time = dungeonTimeLimit
        dungeon.texture = dungeon.texture ~= 0 and dungeonTexture or "Interface/Icons/achievement_bg_wineos_underxminutes"
    end

    for _, affix in pairs(dataAffixes) do
        local name, description = C_ChallengeMode.GetAffixInfo(affix.affixID);
        affix.name = name
        affix.description = description
    end
end

function AlterEgo:UpdateRaidInstances()
    local character = self:GetCharacter()
    local raids = self:GetRaids();
    local numSavedInstances = GetNumSavedInstances()
    character.raids.savedInstances = {}
    if numSavedInstances > 0 then
        for savedInstanceIndex = 1, numSavedInstances do
            local name, lockoutId, reset, difficultyID, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress, extendDisabled, instanceID = GetSavedInstanceInfo(savedInstanceIndex)
            local raid = AE_table_get(raids, "instanceID", instanceID)
            local savedInstance = {
                index = savedInstanceIndex,
                id = lockoutId,
                name = name,
                lockoutId = lockoutId,
                reset = reset,
                difficultyID = difficultyID,
                locked = locked,
                extended = extended,
                instanceIDMostSig = instanceIDMostSig,
                isRaid = isRaid,
                maxPlayers = maxPlayers,
                difficultyName = difficultyName,
                numEncounters = numEncounters,
                encounterProgress = encounterProgress,
                extendDisabled = extendDisabled,
                instanceID = instanceID,
                link = GetSavedInstanceChatLink(savedInstanceIndex),
                expires = 0,
                encounters = {}
            }
            if reset and reset > 0 then
                savedInstance.expires = reset + time()
            end
            for encounterIndex = 1, numEncounters do
                local bossName, fileDataID, killed = GetSavedInstanceEncounterInfo(savedInstanceIndex, encounterIndex)
                local instanceEncounterID = 0
                if raid then
                    local raidEncounter = AE_table_get(raid.encounters, "name", bossName)
                    if raidEncounter then
                        instanceEncounterID = raidEncounter.instanceEncounterID
                    end
                end
                local encounter = {
                    index = encounterIndex,
                    instanceEncounterID = instanceEncounterID,
                    bossName = bossName,
                    fileDataID = fileDataID or 0,
                    killed = killed
                }
                savedInstance.encounters[encounterIndex] = encounter
            end
            character.raids.savedInstances[savedInstanceIndex] = savedInstance
        end
    end
    self:UpdateUI()
end

function AlterEgo:UpdateCharacterInfo()
    local character = self:GetCharacter()
    local playerName = UnitName("player")
    local playerRealm = GetRealmName()
    local playerLevel = UnitLevel("player")
    local playerRaceName, playerRaceFile, playerRaceID = UnitRace("player")
    local playerClassName, playerClassFile, playerClassID = UnitClass("player")
    local playerFactionGroupEnglish, playerFactionGroupLocalized = UnitFactionGroup("player")
    local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvp = GetAverageItemLevel()
    local itemLevelColorR, itemLevelColorG, itemLevelColorB = GetItemLevelColor()
    if playerName then character.info.name = playerName end
    if playerRealm then character.info.realm = playerRealm end
    if playerLevel then character.info.level = playerLevel end
    if type(character.info.race) ~= "table" then character.info.race = defaultCharacter.info.race end
    if playerRaceName then character.info.race.name = playerRaceName end
    if playerRaceFile then character.info.race.file = playerRaceFile end
    if playerRaceID then character.info.race.id = playerRaceID end
    if type(character.info.class) ~= "table" then character.info.class = defaultCharacter.info.class end
    if playerClassName then character.info.class.name = playerClassName end
    if playerClassFile then character.info.class.file = playerClassFile end
    if playerClassID then character.info.class.id = playerClassID end
    if type(character.info.factionGroup) ~= "table" then character.info.factionGroup = defaultCharacter.info.factionGroup end
    if playerFactionGroupEnglish then character.info.factionGroup.english = playerFactionGroupEnglish end
    if playerFactionGroupLocalized then character.info.factionGroup.localized = playerFactionGroupLocalized end
    if avgItemLevel then character.info.ilvl.level = avgItemLevel end
    if avgItemLevelEquipped then character.info.ilvl.equipped = avgItemLevelEquipped end
    if avgItemLevelPvp then character.info.ilvl.pvp = avgItemLevelPvp end
    if itemLevelColorR and itemLevelColorG and itemLevelColorB then character.info.ilvl.color = CreateColor(itemLevelColorR, itemLevelColorG, itemLevelColorB):GenerateHexColor() end
    character.lastUpdate = GetServerTime()
    self:UpdateUI()
end

function AlterEgo:UpdateKeystoneItem()
    local character = self:GetCharacter()
    local dungeons = self:GetDungeons()
    -- character.mythicplus.keystone = AE_table_copy(defaultCharacter.mythicplus.keystone)
    for bagId = 0, NUM_BAG_SLOTS do
        for slotId = 1, C_Container.GetContainerNumSlots(bagId) do
            local itemId = C_Container.GetContainerItemID(bagId, slotId)
            if itemId and itemId == 180653 then
                local itemLink = C_Container.GetContainerItemLink(bagId, slotId)
                local _, _, challengeModeID, level = strsplit(":", itemLink)
                local dungeon = AE_table_get(dungeons, "challengeModeID", tonumber(challengeModeID))
                if dungeon then
                    character.mythicplus.keystone = {
                        challengeModeID = tonumber(dungeon.challengeModeID),
                        mapId = tonumber(dungeon.mapId),
                        level = tonumber(level),
                        color = C_ChallengeMode.GetKeystoneLevelRarityColor(level):GenerateHexColor(),
                        itemId = tonumber(itemId),
                        itemLink = itemLink,
                    }
                    if self.newKeystone then
                        if IsInGroup() and self.db.global.announceKeystones.autoParty then
                            SendChatMessage("New Keystone: " .. itemLink, "PARTY")
                        end
                        if IsInGuild() and self.db.global.announceKeystones.autoGuild then
                            SendChatMessage("New Keystone: " .. itemLink, "GUILD")
                        end
                        self.newKeystone = false
                    end
                end
                break
            end
        end
    end
    local keyStoneMapID = C_MythicPlus.GetOwnedKeystoneMapID()
    local keyStoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
    if keyStoneMapID ~= nil then character.mythicplus.keystone.mapId = tonumber(keyStoneMapID) end
    if keyStoneLevel ~= nil then character.mythicplus.keystone.level = tonumber(keyStoneLevel) end
    self:UpdateUI()
end

function AlterEgo:UpdateVault()
    local character = self:GetCharacter()
    wipe(character.vault.slots or {})
    for i = 1, 3 do
        local slots = C_WeeklyRewards.GetActivities(i)
        for _, slot in ipairs(slots) do
            slot.exampleRewardLink = ""
            slot.exampleRewardUpgradeLink = ""
            if slot.progress >= slot.threshold then
                local itemLink, upgradeItemLink = C_WeeklyRewards.GetExampleRewardItemHyperlinks(slot.id)
                slot.exampleRewardLink = itemLink
                slot.exampleRewardUpgradeLink = upgradeItemLink
            end
            table.insert(character.vault.slots, slot)
        end
    end
    local HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
    if HasAvailableRewards ~= nil then character.vault.hasAvailableRewards = HasAvailableRewards end
    self:UpdateUI()
end

function AlterEgo:UpdateMythicPlus()
    local character = self:GetCharacter()
    local dungeons = self:GetDungeons()
    local ratingSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
    if not ratingSummary then
        C_MythicPlus.RequestMapInfo()
        ---@diagnostic disable-next-line: undefined-field
        return self:ScheduleTimer("UpdateMythicPlus", 2)
    end
    local runHistory = C_MythicPlus.GetRunHistory(true, true)
    local bestSeasonScore, bestSeasonNumber = C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion()
    local weeklyRewardAvailable = C_MythicPlus.IsWeeklyRewardAvailable() -- Unused
    local HasAvailableRewards = C_WeeklyRewards.HasAvailableRewards()
    local currentSeason = C_MythicPlus.GetCurrentUIDisplaySeason()
    local numHeroic, numMythic, numMythicPlus = C_WeeklyRewards.GetNumCompletedDungeonRuns();

    if currentSeason then
        for _, char in pairs(self.db.global.characters) do
            if char.currentSeason == nil or char.currentSeason < currentSeason then
                wipe(char.mythicplus.runHistory or {})
                wipe(char.mythicplus.dungeons or {})
                char.mythicplus.rating = 0
                char.currentSeason = currentSeason
            end
        end
    end

    if ratingSummary ~= nil and ratingSummary.currentSeasonScore ~= nil then character.mythicplus.rating = ratingSummary.currentSeasonScore end
    if runHistory ~= nil then character.mythicplus.runHistory = runHistory end
    if bestSeasonScore ~= nil then character.mythicplus.bestSeasonScore = bestSeasonScore end
    if bestSeasonNumber ~= nil then character.mythicplus.bestSeasonNumber = bestSeasonNumber end
    if weeklyRewardAvailable ~= nil then character.mythicplus.weeklyRewardAvailable = weeklyRewardAvailable end
    if HasAvailableRewards ~= nil then character.vault.hasAvailableRewards = HasAvailableRewards end

    character.mythicplus.numCompletedDungeonRuns = {
        heroic = numHeroic or 0,
        mythic = numMythic or 0,
        mythicPlus = numMythicPlus or 0,
    }

    wipe(character.mythicplus.dungeons or {})
    for _, dataDungeon in pairs(dungeons) do
        local bestTimedRun, bestNotTimedRun = C_MythicPlus.GetSeasonBestForMap(dataDungeon.challengeModeID);
        local affixScores, bestOverAllScore = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(dataDungeon.challengeModeID)
        local dungeon = {
            challengeModeID = dataDungeon.challengeModeID,
            bestTimedRun = {},
            bestNotTimedRun = {},
            affixScores = {},
            rating = 0,
            level = 0,
            finishedSuccess = false,
            bestOverAllScore = 0
        }
        if bestTimedRun ~= nil then dungeon.bestTimedRun = bestTimedRun end
        if bestNotTimedRun ~= nil then dungeon.bestNotTimedRun = bestNotTimedRun end
        if affixScores ~= nil then dungeon.affixScores = affixScores end
        if bestOverAllScore ~= nil then dungeon.bestOverAllScore = bestOverAllScore end
        if ratingSummary ~= nil and ratingSummary.runs ~= nil then
            for _, run in ipairs(ratingSummary.runs) do
                if run.challengeModeID == dataDungeon.challengeModeID then
                    dungeon.rating = run.mapScore
                    dungeon.level = run.bestRunLevel
                    dungeon.finishedSuccess = run.finishedSuccess
                end
            end
        end
        table.insert(character.mythicplus.dungeons, dungeon)
    end
    self:UpdateUI()
end

function AlterEgo:OnEncounterEnd(instanceEncounterID, encounterName, difficultyID, groupSize, success)
    if success then
        RequestRaidInfo()
    end
    self:UpdateUI()
end