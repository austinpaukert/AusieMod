SMODS.Joker {
    key = 'Magic_Wand',
    atlas = 'placeholders',
    rarity = 3,
    cost = 8,
    pos = { x = 1, y = 0 },
    config = { extra = { repetitions = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
}
