local reminder_text_pws = {
    { ref_table = "card.joker_display_values", ref_value = "pws_label" },
    { ref_table = "card.joker_display_values", ref_value = "pws_suit" },
    { text = " - "},
    { ref_table = "card.joker_display_values", ref_value = "init_charge" },
    { text = "/" },
    { ref_table = "card.joker_display_values", ref_value = "full_charge" },
}

local function joker_def_calc(card)
    card.joker_display_values.bonus_gold = Valkyrie.calculate_earnings(card)
    card.joker_display_values.pws_label = localize('k_valkyrie_joker_def_pws')
    card.joker_display_values.pws_suit = localize(card.ability.suit, 'suits_plural')
    card.joker_display_values.init_charge = card.ability.charge or 0
    card.joker_display_values.full_charge = Valkyrie.pws_full_charge
end 

Valkyrie.joker_display_defs = {
    j_valkyrie_freya = {
        text = {
            { text = "+" },
            { ref_table = "card.ability", ref_value = "current_bonus", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.CHIPS },
        reminder_text = reminder_text_pws,
        calc_function = joker_def_calc
    },
    j_valkyrie_lezard = {
        text = {
            { text = "+" },
            { ref_table = "card.ability", ref_value = "current_bonus", retrigger_type = "mult" },
        },
        text_config = { colour = G.C.MULT },
        reminder_text = reminder_text_pws,
        calc_function = joker_def_calc
    },
    j_valkyrie_lenneth = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability", ref_value = "current_bonus", retrigger_type = "exp" }
                },
            },
        },
        reminder_text = reminder_text_pws,
        calc_function = joker_def_calc
    },
    j_valkyrie_arngrim = {
        text = {
            { text = "+$" },
            { ref_table = "card.joker_display_values", ref_value = "bonus_gold" }
        },
        text_config = { colour = G.C.GOLD },
        reminder_text = reminder_text_pws,
        calc_function = joker_def_calc
    }
}

for k, v in pairs(Valkyrie.joker_display_defs) do
    JokerDisplay.Definitions[k] = v
end