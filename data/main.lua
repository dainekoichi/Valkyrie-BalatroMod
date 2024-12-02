Valkyrie = SMODS.current_mod
Valkyrie.prefix = "valkyrie"
Valkyrie.badge_colour = HEX("c9c9a5")
Valkyrie.pws_full_charge = 8

SMODS.Rarity{
    key = "einherjar",
    loc_txt = {name = "Einherjar"},
    default_weight = 0,
    badge_colour = HEX("c9c9a5"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end
}

-- For debug purposes
-- function valkyrie_print_info(...)
--     return sendInfoMessage(table.concat({ ... }, "\t"), "Valkyrie")
-- end

-- Overrides --
local end_round_ref = end_round
function end_round()
    if G.GAME.blind.boss then -- Allow Spiritual Concentration Pack to appear after a Boss Blind
        G.GAME.valkyrie_from_boss = true
        G.GAME.valkyrie_inserted_pack = false
    else -- Disable every end of round otherwise
        G.GAME.valkyrie_from_boss = false
        G.GAME.valkyrie_inserted_pack = true
    end
    end_round_ref()
    if G.STATE ~= G.STATES.GAME_OVER then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Destroy any PWS cards
                for _, card in ipairs(G.consumeables.cards) do
                    if card.ability.set == "PWS" then card:start_dissolve(nil, true) end
                end
                return true
            end
        }))
    end
end

local get_pack_ref = get_pack
function get_pack(_key, _type) 
    local should_insert = false
    local inserted_pack = G.GAME.valkyrie_inserted_pack or false
    local first_pack = G.GAME.valkyrie_first_pack or false
    if not inserted_pack then -- Check if Einherjar pack has not yet been inserted
        if not G.GAME.valkyrie_from_boss then -- Check if just defeated a Boss Blind
            should_insert = false
        elseif not first_pack then -- Force Einherjar pack to show up if it has not appeared yet for the first time
            should_insert = true
            G.GAME.valkyrie_first_pack = true
        else
            should_insert = pseudorandom('einherjar_pack') < G.GAME.probabilities.normal / 10 -- [game probability] in 10 chance
        end
    end
    Valkyrie.from_boss = false -- this should disable the check for the rest of the packs
    if G.STATE == G.STATES.SHOP and should_insert then
        G.GAME.valkyrie_inserted_pack = true
        return G.P_CENTERS['p_valkyrie_einherjars']
    else
        return get_pack_ref(_key, _type)
    end
end
-- Overrides --

-- New functions --
function Valkyrie.find_mod(id) -- Copied from Reverie
    return (SMODS.Mods[id] or {}).can_load
end


function Valkyrie.calculate_earnings(card)
    local bonus_gold = card.ability.current_bonus
    if G.GAME.blind and G.GAME.blind.boss then
        bonus_gold = bonus_gold * 2
    end
    return bonus_gold
end