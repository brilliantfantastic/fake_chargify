module FakeChargify
  class CreditCard
    attr_accessor :expiration_month, :expiration_year
    
    def full_number=(value)
      @full_number = value
    end
    
    def masked_card_number
      "XXXX-XXXX-XXXX-#{@full_number.to_s.last(4)}"
    end
  end
end