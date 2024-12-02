--- STEAMODDED HEADER
--- MOD_NAME: Valkyrie
--- MOD_ID: Valkyrie
--- VERSION: 0.2.0
--- MOD_AUTHOR: [DaiNekoIchi,PADS]
--- MOD_DESCRIPTION: Valkyrie is a Balatro mod heavily inspired by, you guessed it, Valkyrie Profile: Lenneth. This mod adds a few Jokers and consumables that are centered around Boss Blinds.
--- PREFIX: valkyrie
----------------------------------------------
-- Most of the sprites were taken from https://www.spriters-resource.com/psp/valkyrieprofilelenneth/
-- We have edited and modified them ourselves using GIMP to help fit these into the game
----------------------------------------------
------------MOD CODE -------------------------

SMODS.load_file("data/main.lua")()
SMODS.load_file("data/jokers.lua")()
SMODS.load_file("data/pws.lua")()
SMODS.load_file("data/boosters.lua")()
SMODS.load_file("data/atlases.lua")()

if Valkyrie.find_mod("JokerDisplay") and _G["JokerDisplay"] then
    SMODS.load_file("data/joker_display.lua")()
end


----------------------------------------------
------------MOD CODE END----------------------