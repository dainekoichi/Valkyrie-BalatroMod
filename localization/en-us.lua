return {
    descriptions = {
        PWS = {
            c_valkyrie_freya_pws = {
                name = 'Ether Strike',
                text = {
                    'Disables effect of',
                    'current {C:attention}Boss Blind{}',
                    'Shuffles all cards back into the',
                    'deck then draws a new hand'
                }
            },
            c_valkyrie_lezard_pws = {
                name = 'Petro Disruption',
                text = {
                    'Disables effect of',
                    'current {C:attention}Boss Blind{}',
                    'Adds {C:dark_edition}random edition{} to',
                    '1/4 of the cards in hand',
                }
            },
            c_valkyrie_lenneth_pws = {
                name = 'Nibelung Valesti',
                text = {
                    'Disables effect of',
                    'current {C:attention}Boss Blind{}',
                    'Adds {C:dark_edition}random edition{} to',
                    'a random Joker',
                }
            },
            c_valkyrie_arngrim_pws = {
                name = 'Final Blast',
                text = {
                    'Disables effect of',
                    'current {C:attention}Boss Blind{}',
                    '{C:green}1 in 4{} chance to gain {C:blue}+1{} Hand',
                    'for every {C:money}$50{} you have',
                }
            },
        },
        Joker = {
            j_valkyrie_freya = {
                name = 'Freya',
                text = {
                    'This Einherjar gains {C:chips}+#2#{} Chips',
                    'per {C:attention}Boss Blind{} defeated',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)',
                    'PWS Charge: {C:attention}#5#{} (#3#/#4#)',
                    'PWS: {C:dark_edition}Ether Strike'
                }
            },
            j_valkyrie_lezard = {
                name = 'Lezard Valeth',
                text = {
                    'This Einherjar gains {C:mult}+#2#{} Mult',
                    'per {C:attention}Boss Blind{} defeated',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
                    'PWS Charge: {C:attention}#5#{} (#3#/#4#)',
                    'PWS: {C:dark_edition}Petro Disruption'
                }
            },
            j_valkyrie_lenneth = {
                name = 'Lenneth Valkyrie',
                text = {
                    'This Einherjar gains {X:mult,C:white}X#2#{} Mult',
                    'per {C:attention}Boss Blind{} defeated',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                    'PWS Charge: {C:attention}#5#{} (#3#/#4#)',
                    'PWS: {C:dark_edition}Nibelung Valesti'
                }
            },
            j_valkyrie_arngrim = {
                name = 'Arngrim',
                text = {
                    'Earn {C:money}$#1#{} at end of round',
                    '(doubled during {C:attention}Boss Blind{})',
                    'This Einherjar gains {C:money}$#2#{}',
                    'per {C:attention}Boss Blind{} defeated',
                    'PWS Charge: {C:attention}#5#{} (#3#/#4#)',
                    'PWS: {C:dark_edition}Final Blast'
                }
            }
        },
        Other = {
            p_valkyrie_einherjars = {
                name = "Spiritual Concentration Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# Einjerhar{} cards"
                }
            },
        },
    },
    misc = {
        dictionary = {
            k_valkyrie_einherjars_pack = "Spiritual Concentration Pack",
            k_valkyrie_divine_assault = "Divine Assault!",
            k_valkyrie_finishing_strike = "Finishing Strike!",
            k_valkyrie_great_magic = "Great Magic!",
            k_valkyrie_charge = "Charge",
        },
    },
}