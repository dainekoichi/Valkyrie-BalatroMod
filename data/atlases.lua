Valkyrie.atlases = {
    {
        key = "modicon",
        path = "icon.png",
        px = 34,
        py = 34
    },
    {
        key = 'einherjars',
        path = 'Einherjars.png',
        px = 71,
        py = 95
    },
    {
        key = 'boosters',
        path = 'Boosters.png',
        px = 71,
        py = 95
    },
    {
        key = 'PWS',
        path = 'PWS.png',
        px = 71,
        py = 95
    }
}

for _, v in pairs(Valkyrie.atlases) do
    SMODS.Atlas(v)
end