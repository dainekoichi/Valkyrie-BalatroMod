pws_full = 8

local function calculate_einherjar(self, card, context)
    if not context.blueprint then
        if G.GAME.blind.boss and context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.suit) then
            if (not card.ability.pws or true) and (card.ability.charge or 0) < pws_full then
                card.ability.charge = card.ability.charge + 1
                if (card.ability.charge == pws_full) then
                    card.ability.pws = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local pws_text = localize("k_valkyrie_divine_assault")
                            if (self.key == "j_valkyrie_arngrim") then
                                pws_text = localize("k_valkyrie_finishing_strike")
                            elseif (self.key == "j_valkyrie_lezard") then
                                pws_text = localize("k_valkyrie_great_magic")
                            end
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = pws_text,
                                card = card
                            })
                            local pws = SMODS.create_card{ key = card.ability.reward }
                            G.consumeables:emplace(pws)
                            pws:add_to_deck()
                            return true
                        end
                    }))
                else
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize('k_valkyrie_charge'),
                        card = card
                    })
                end
            end
        elseif context.joker_main then
            if card.ability.bonus_type == 'c' and card.ability.current_bonus > 0 then
                return {
                    card = card,
                    chip_mod = card.ability.current_bonus,
                    message = '+' .. (card.ability.current_bonus),
                    colour = G.C.CHIPS
                }
            elseif card.ability.bonus_type == 'm' and card.ability.current_bonus > 0 then
                return {
                    card = card,
                    mult_mod = card.ability.current_bonus,
                    message = '+' .. (card.ability.current_bonus),
                    colour = G.C.MULT
                }
            elseif card.ability.bonus_type == 'x' and card.ability.current_bonus > 1.0 then
                return {
                    card = card,
                    Xmult_mod = card.ability.current_bonus,
                    message = 'X' .. (card.ability.current_bonus),
                    colour = G.C.MULT
                }
            end
        elseif context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss then
            card.ability.current_bonus = card.ability.current_bonus + card.ability.added_bonus
            local colour = G.C.MULT
            if card.ability.bonus_type == 'c' then 
                colour = G.C.CHIPS
            elseif card.ability.bonus_type == 'g' then
                colour = G.C.MONEY
            end
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize("k_upgrade_ex"),
                colour = colour,
                card = card
            })
            card.ability.pws = false
            card.ability.charge = 0
        end
    end
end

local function loc_vars_einherjar(self,info_queue,center)
    info_queue[#info_queue + 1] = G.P_CENTERS[center.ability.reward]
    return { 
        vars = {
            center.ability.current_bonus, 
            center.ability.added_bonus,
            center.ability.charge or 0,
            pws_full,
            center.ability.suit,
            G.P_CENTERS[center.ability.reward].name
        }
    }
end

local function calculate_earnings(center)
    if G.GAME.blind and G.GAME.blind.boss then
        return center.ability.current_bonus * 2
    else
        return center.ability.current_bonus
    end
end

Valkyrie.einherjars = {
    {
        key = 'freya',
        loc_vars = loc_vars_einherjar,
        config = {
            bonus_type = 'c',
            current_bonus = 35,
            added_bonus = 35,
            charge = 0,
            suit = 'Diamonds',
            reward = 'c_valkyrie_freya_pws'
        },
        pos = {x = 0,y = 0},
        soul_pos = {x = 4, y = 0}
    },
    {
        key = 'lezard',
        config = {
            bonus_type = 'm',
            current_bonus = 5,
            added_bonus = 5,
            charge = 0,
            suit = 'Clubs',
            reward = 'c_valkyrie_lezard_pws'
        },
        pos = {x = 1,y = 0},
        soul_pos = {x = 5, y = 0}
    },
    {
        key = 'lenneth',
        config = {
            bonus_type = 'x',
            current_bonus = 1.25,
            added_bonus = 0.25,
            charge = 0,
            suit = 'Hearts',
            reward = 'c_valkyrie_lenneth_pws'
        },
        pos = {x = 2,y = 0},
        soul_pos = {x = 6, y = 0}
    },
    {
        key = 'arngrim',
        config = {
            bonus_type = 'g',
            current_bonus = 2,
            added_bonus = 1,
            charge = 0,
            suit = 'Spades',
            reward = 'c_valkyrie_arngrim_pws'
        },
        pos = {x = 3,y = 0},
        soul_pos = {x = 7, y = 0},
        calc_dollar_bonus = function(self,card)
            return calculate_earnings(card)
        end
    }
}

for _, v in ipairs(Valkyrie.einherjars) do
    v.atlas = 'einherjars'
    v.rarity = 'valkyrie_einherjar'
    v.cost = 5
    v.loc_vars = loc_vars_einherjar
    v.calculate = calculate_einherjar
    SMODS.Joker(v)
end