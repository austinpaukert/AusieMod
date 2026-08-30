SMODS.Joker {
    key = "Wheel_Of_Construction",
    atlas = 'placeholders',
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 1,
    cost = 6,
    pos = { x = 3, y = 0 },
    draw = function(self, card, layer)
        card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end,
    config = { extra = {current_rounds = 0, total_rounds = 2, odds = 4} },
    loc_vars = function(self, info_queue, card)
        local main_end = {}
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bves_Wheel_Of_Construction')
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.current_rounds}, main_end = main_end[1],numerator, denominator }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.current_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'bves_Wheel_Of_Construction', 1, card.ability.extra.odds) then
                local curr_card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_blueprint', nil)
                curr_card:add_to_deck()
                G.jokers:emplace(curr_card)
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
            if card.ability.extra.current_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.current_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.current_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}