TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local cooldown = true
local cooldown2 = true

getPlayerInfo = {
    firstName = nil,
    lastName = nil,
    dateOfBirth = nil,
    height = nil,
    sex = nil
}


function CreatorMenu()
    local main = RageUI.CreateMenu("Identité", "Que voulez-vous faire ?")
    main.Closable = false
    local selectGender = RageUI.CreateSubMenu(main, "Sexe", "Que voulez-faire ?")
    local editSkin = RageUI.CreateSubMenu(main, "Personnage", "Que voulez-vous faire ?")
    editSkin.Closable = false
    editSkin.EnableMouse = true
    local selectClothes = RageUI.CreateSubMenu(main, "Vêtement", "Que voulez-vous faire ?")
    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Wait(0)
        RageUI.IsVisible(main, function()

            RageUI.Button("Prénom :", nil, {RightLabel = getPlayerInfo.firstName}, cooldown, {
                onSelected = function()
                    getPlayerInfo.firstName = Imput("Votre Prénom ? (ex : Jako)", "", 20)
                end
            })

            RageUI.Button("Nom de famille :", nil, {RightLabel = getPlayerInfo.lastName}, cooldown, {
                onSelected = function()
                    getPlayerInfo.lastName = Imput("Votre nom de famille ? (ex : Cooper)", "", 20)
                end
            })

            RageUI.Button("Date de naissance :", nil, {RightLabel = getPlayerInfo.dateOfBirth}, cooldown, {
                onSelected = function()
                    getPlayerInfo.dateOfBirth = Imput("Votre date de naissance ? (ex : 14/09/1993)", "", 10)
                end
            })

            RageUI.Button("Taille :", nil, {RightLabel = getPlayerInfo.height}, cooldown, {
                onSelected = function()
                    getPlayerInfo.height = Imput("Votre taille ? (ex : 193)", "", 3)
                end
            })

            RageUI.Button("Sexe :", nil, {RightLabel = getPlayerInfo.sex}, cooldown, {}, selectGender)

            if getPlayerInfo.firstName == nil or getPlayerInfo.lastName == nil or getPlayerInfo.dateOfBirth == nil or getPlayerInfo.height == nil or getPlayerInfo.sex == nil then
                RageUI.Button("Valider", "~r~Attention~s~ : Vous ne pourrez plus modifier votre identité ni votre sexe !", {RightBadge = RageUI.BadgeStyle.Tick}, false, {})
            else
                RageUI.Button("Valider", "~r~Attention~s~ : Vous ne pourrez plus modifier votre identité ni votre sexe !", {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                    onSelected = function()
                        cooldown = false
                        TriggerServerEvent("nCreator:save", getPlayerInfo)
                        DoScreenFadeOut(1000)
                        Wait(1000)
                        RenderScriptCams(false, false, 0, true, true)
                        TriggerServerEvent("nCreator:setPlayerToBucket", GetPlayerServerId(PlayerId()))
                        SkinCam()
                        DoScreenFadeIn(1000)
                        Wait(200)
                        RageUI.Visible(editSkin, true)
                    end
                })
            end

        end)

        RageUI.IsVisible(selectGender, function()

            RageUI.Button("Homme", nil, {}, true, {
                onSelected = function()
                    getPlayerInfo.sex = "m"
                    RageUI.GoBack()
                    TriggerEvent("skinchanger:change", "sex", 0)
                end
            })

            RageUI.Button("Femme", nil, {}, true, {
                onSelected = function()
                    getPlayerInfo.sex = "f"
                    RageUI.GoBack()
                    TriggerEvent("skinchanger:change", "sex", 1)
                end
            })

        end)

        RageUI.IsVisible(editSkin, function()

            local visage = {} for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 0) - 1, 1 do visage[i] = i end
            RageUI.List("Visage", visage, IndexList.List1, nil, {}, cooldown2, {
                onListChange = function(i, Item)
                    IndexList.List1 = i;
                    TriggerEvent("skinchanger:change", "face", IndexList.List1 - 1)
                end,
            })

            RageUI.List("Couleur de peau", {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42"}, IndexList.List2, nil, {}, cooldown2, {
                onListChange = function(i, Item)
                    IndexList.List2 = i;
                    TriggerEvent("skinchanger:change", "skin", IndexList.List2 - 1)
                end,
            })

            local cheveux = {} for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1, 1 do cheveux[i] = i end
            RageUI.List("Cheveux", cheveux, IndexList.List3, nil, {}, cooldown2, {
                onListChange = function(i, Item)
                    IndexList.List3 = i;
                    TriggerEvent("skinchanger:change", "hair_1", IndexList.List3 - 1)
                end,
            })

            local barbe = {} for b = 0, GetNumHeadOverlayValues(1) -1, 1 do barbe[b] = b end
            RageUI.List("Barbe", barbe, IndexList.List4, nil, {}, cooldown2, {
                onListChange = function(i, Item)
                    IndexList.List4 = i;
                    TriggerEvent("skinchanger:change", "beard_1", IndexList.List4 - 1)
                end,
            })

            local sourcils = {} for c = 0, GetNumHeadOverlayValues(1) -1, 1 do sourcils[c] = c end
            RageUI.List("Sourcils", sourcils, IndexList.List5, nil, {}, cooldown2, {
                onListChange = function(Index, Item)
                    IndexList.List5 = Index
                    TriggerEvent("skinchanger:change", "eyebrows_1", IndexList.List5)
                end,
            })

            RageUI.List("Couleur des yeux", sourcils, IndexList.List6, nil, {}, cooldown2, {
                onListChange = function(Index, Item)
                    IndexList.List6 = Index
                    TriggerEvent("skinchanger:change", "eye_color", IndexList.List6)
                end,
            })

            RageUI.Button("Valider", "~r~Attention~s~ : Vous ne pourrez plus modifier votre personnage !", {RightBadge = RageUI.BadgeStyle.Tick}, true, {}, selectClothes)


            RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, IndexPanel.ChevColor.primary[1], IndexPanel.ChevColor.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    IndexPanel.ChevColor.primary[1] = MinimumIndex
                    IndexPanel.ChevColor.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_1",
                    IndexPanel.ChevColor.primary[2])
                end
            },3)

            RageUI.ColourPanel("Couleur Secondaire", RageUI.PanelColour.HairCut, IndexPanel.ChevColor.secondary[1], IndexPanel.ChevColor.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    IndexPanel.ChevColor.secondary[1] = MinimumIndex
                    IndexPanel.ChevColor.secondary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_2",
                    IndexPanel.ChevColor.secondary[2])
                end
            },3)

            RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, IndexPanel.BarColor.primary[1], IndexPanel.BarColor.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    IndexPanel.BarColor.primary[1] = MinimumIndex
                    IndexPanel.BarColor.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "beard_3",
                    IndexPanel.BarColor.primary[2])
                end
            },4)

            RageUI.PercentagePanel(IndexPanel.percent1, "Opacité", "0%", "100%", {
                onProgressChange = function(Percentage)
                    IndexPanel.percent1 = Percentage
                    TriggerEvent("skinchanger:change", "beard_2", Percentage * 10)
                end
            },4)

            RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, IndexPanel.SourColor.primary[1], IndexPanel.SourColor.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    IndexPanel.SourColor.primary[1] = MinimumIndex
                    IndexPanel.SourColor.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "eyebrows_3",
                    IndexPanel.SourColor.primary[2])
                end
            },5)

            RageUI.PercentagePanel(IndexPanel.percent2, "Opacité", "0%", "100%", {
                onProgressChange = function(Percentage)
                    IndexPanel.percent2 = Percentage
                    TriggerEvent("skinchanger:change", "eyebrows_2", Percentage * 10)
                end
            },5)

        end)

        RageUI.IsVisible(selectClothes, function()

            RageUI.Button("Chic", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local outfit
                        if skin.sex == 0 then
                            outfit = Creator.outfit.Chic.male
                        else
                            outfit = Creator.outfit.Chic.female
                        end
                        if outfit then
                            TriggerEvent('skinchanger:loadClothes', skin, outfit)
                        end
                    end)
                end
            })

            RageUI.Button("Décontraté", nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, {
                onSelected = function()
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        local outfit
                        if skin.sex == 0 then
                            outfit = Creator.outfit.Decontract.male
                        else
                            outfit = Creator.outfit.Decontract.female
                        end
                        if outfit then
                            TriggerEvent('skinchanger:loadClothes', skin, outfit)
                        end
                    end)
                end
            })

            RageUI.Button("Valider", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    RenderScriptCams(false, false, 0, true, true)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerServerEvent('esx_skin:save', skin)
                    end)
                    EndCreator()
                    cooldown2 = false
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            })

        end)

        if (not (RageUI.Visible(main))) and not RageUI.Visible(selectGender) and not RageUI.Visible(editSkin) and not RageUI.Visible(selectClothes) then
            main = RMenu:DeleteType(main, true)
            selectGender = RMenu:DeleteType(selectGender, true)
            editSkin = RMenu:DeleteType(editSkin, true)
            selectClothes = RMenu:DeleteType(selectClothes, true)
        end
    end
end
