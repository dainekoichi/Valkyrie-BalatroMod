Valkyrie = SMODS.current_mod
Valkyrie.prefix = "valkyrie"
Valkyrie.badge_colour = HEX("c9c9a5")
Valkyrie.from_boss = false -- Strangely when accessing the shop, G.GAME.last_blind and G.GAME.blind don't provide info, so this is a workaround for now
Valkyrie.inserted_pack = false
Valkyrie.first_pack_inserted = false

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

local end_round_ref = end_round
function end_round()
    if G.GAME.blind.boss then -- Allow Spiritual Concentration Pack to appear after a Boss Blind
        Valkyrie.from_boss = true
        Valkyrie.inserted_pack = false
    else -- Disable every end of round otherwise
        Valkyrie.from_boss = false
        Valkyrie.inserted_pack = true
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
    if not Valkyrie.inserted_pack or false then -- Check if Einherjar pack has already been inserted
        if not Valkyrie.from_boss then -- Check if just defeated a Boss Blind
            should_insert = false
        elseif not Valkyrie.first_pack_inserted then -- Force Einherjar pack to show up if it has not appeared yet for the first time
            should_insert = true
            Valkyrie.first_pack_inserted = true
        else
            should_insert = pseudorandom('einherjar_pack') < G.GAME.probabilities.normal / 10 -- [game probability] in 10 chance
        end
    end
    Valkyrie.from_boss = false -- this should disable the check for the rest of the packs
    if G.STATE == G.STATES.SHOP and should_insert then
        Valkyrie.inserted_pack = true
        return G.P_CENTERS['p_valkyrie_einherjars']
    else
        return get_pack_ref(_key, _type)
    end
end