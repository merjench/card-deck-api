class Api::V1::CardsController < ApplicationController

    SUITS = ["hearts", "spades", "clubs", "diamonds"]
    VALUES = [*2..10, "jack", "queen", "king", "ace"]

    #show all cards
    def index 
        @cards = Card.all 

        render json: @cards
    end 
    
    #displace one card
    def show
        card_id = params[:id]
        @card = Card.where(:id => card_id)
        render json: @card  
    end

    def new
        byebug
    end

    # add card to a deck 
    def create
        value = params[:value]
        suit = params[:suit] 
        deck = Deck.find(params[:deck])
        @error_message = "card: #{params[:value]} of #{params[:suit]} already exists for deck:#{deck.id}"
        @error = "invalid input"
        return render json: @error unless SUITS.include?(suit) && VALUES.include?(value.to_i)
             
        card = deck.cards.where(:suit => suit, :value => value)
        if card.present?
            render json: @error_message
        else 
            @new_card = Card.create(:suit => suit, :value => value, :deck_id => deck.id)
            render json: @new_card
        end
    end

    # IN-PROGRESS sort deck of cards   
    def sort
        byebug
        deck = Deck.find(params[:deck])
        cards = deck.cards
        @result = []
        # face_values = {
        #     :ace => 1,
        #     :jack => 11,
        #     :queen => 12,
        #     :king => 13
        # }

        # steps: 
        # Step 1: takes the key and runs it through the face values hash 
        # Step 2: if it exist return the value of that key, if doesn't then return the value of the card

        # cards.each_key do |card| 
        #     each_card = card[:value]
        #     if each_card
        #         #if card 
        #     else
        #         #normal number card
        # end
                
        if params[:sort_suit] && params[:sort_value]
            sort_all = cards.sort_by{|key, value| [value, key]}
            @result << sort_all

        elsif params[:sort_suit]
            sort_suit = cards.sort_by{|key, value| value}
            @result << sort_suit

        elsif params[:sort_value]
            sort_value = cards.sort_by{|key, value| key}
            @result << sort_value
        end
            render json: @result
    end 

    #delete a card 
    def destroy 
        card = Card.find(params[:id])
         
        card.destroy
        render json: {message: "card has been deleted"}
    end 

end
