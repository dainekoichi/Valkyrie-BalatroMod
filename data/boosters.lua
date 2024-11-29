Valkyrie.boosters = {
    {
        key = 'einherjars',
        group_key = 'k_valkyrie_einherjars_pack',
        name = "Spiritual Concentration Pack",
        config = {extra = 2,choose = 1},
        weight = 0,
        cost = 8,
        pos = {x = 0,y = 0},
        create_card = function(self, card)
            return create_card('Joker', G.pack_cards, nil, 'valkyrie_einherjar', nil, nil, nil, nil)
        end,
        loc_vars = function(self, info_queue, card)
            return { vars = {card.config.center.config.choose, card.ability.extra} }
        end,
        draw_hand = false
    }
}

for _, v in pairs(Valkyrie.boosters) do
    v.atlas = 'boosters'
    SMODS.Booster(v)
end