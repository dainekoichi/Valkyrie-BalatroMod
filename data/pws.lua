SMODS.UndiscoveredSprite{
    key = "PWS",
    atlas = "PWS",
    pos = {
        x = 0,
        y = 0
    }
}

SMODS.ConsumableType {
    key = "PWS",
    primary_colour = G.C.DARK_EDITION,
    secondary_colour = G.C.DARK_EDITION,
    collection_rows = {4,1}, 
    loc_txt = {
        collection = "Purify Weird Soul Cards",
        name = "PWS",
        label = "PWS",
        undiscovered = {
            name = "Undiscovered PWS",
            text = {"Obtain this card", "to discover its effects!"}
        },
    },
    shop_rate = 0,
    default = 'c_valkyrie_freya_pws',
    can_stack = false,
    can_divide = false
}

function calculate_arngrim_bonus_chips()
    local currentChips = G.GAME and G.GAME.chips or 0
    local money = G.GAME and G.GAME.dollars or 0
    return math.floor(currentChips * (math.floor(money/15) * 0.05))
end

local function pws_can_use(self, card)
    return G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled
end

local function pws_use(self, card, area, copier)
    G.GAME.blind:disable()
    play_sound('timpani')
    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
    if (self.key == 'c_valkyrie_freya_pws') then
        G.FUNCS.draw_from_hand_to_discard()
        G.FUNCS.draw_from_discard_to_deck()
        G.FUNCS.draw_from_deck_to_hand()
    elseif (self.key == 'c_valkyrie_lezard_pws') then
        for i in 1, math.floor(#G.hand.cards / 4) do
            local cards_in_hand = {}
            for _,card in pairs(G.hand.cards) do
                if not card.edition then cards_in_hand[#cards_in_hands+1] = card end
            end
            local chosen_card = pseudorandom_element(cards_in_hand, pseudoseed('lezard_pws_card'))
            if chosen_card then
                local edition = poll_edition('lezard_pws_edition', nil, true, true)
                card_eval_status_text(chosen_card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                chosen_card:set_edition(edition, false)
            end
        end
    elseif (self.key == 'c_valkyrie_lenneth_pws') then
        local jokers = {}
        for _,j in pairs(G.jokers.cards) do
            if (not j.edition) then jokers[#jokers+1] = j end
        end
        local chosenJoker = pseudorandom_element(jokers, pseudoseed('lenneth_pws_joker'))
        if chosenJoker then
            local edition = poll_edition('lenneth_pws_edition', nil, true, true)
            card_eval_status_text(chosenJoker, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            chosenJoker:set_edition(edition, false)
        end
    elseif (self.key == 'c_valkyrie_arngrim_pws') then
        local chances = math.floor(G.GAME.dollars/50)
        local hands = 0
        for i = 1,chances do
            if (pseudorandom('arngrim_pws_chance') < G.GAME.probabilities.normal/4) then hands = hands + 1 end
        end
        ease_hands_played(hands)
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = '+'..hands..' Hands', colour = G.C.BLUE})
        
    end
end

SMODS.PWS = SMODS.Consumable:extend {
    set = "PWS",
    can_use = pws_can_use,
    use = pws_use
}

Valkyrie.PWSes = {
    {
        key = "freya_pws",
        pos = {x=1,y=0},
        soul_pos={x=5,y=0}
    },
    {
        key = "lezard_pws",
        pos = {x=2,y=0},
        soul_pos={x=6,y=0}
    },
    {
        key = "lenneth_pws",
        pos = {x=3,y=0},
        soul_pos={x=7,y=0}
    },
    {
        key = "arngrim_pws",
        loc_vars = function (self,info_queue,center)
            return {
                vars = {
                    G.GAME.probabilities.normal
                }
            }
        end, 
        pos = {x=4,y=0},
        soul_pos={x=8,y=0}
    },
}

for _,v in pairs(Valkyrie.PWSes) do
    v.atlas = 'PWS'
    SMODS.PWS(v)
end