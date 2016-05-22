
require 'test_helper'

class TunesTakeoutWrapperTest < ActiveSupport::TestCase

  describe "TunesTakeoutWrapper" do
    it "Accesses the correct API URL and version" do
      assert_equal "https://tunes-takeout-api.herokuapp.com/v1/", TunesTakeoutWrapper::BASE_URL
    end

    describe "API" , :vcr do
      before do
        @avocado               = TunesTakeoutWrapper.search("avocado")
        @top_favorites         = TunesTakeoutWrapper.top_favorites
        @single_favorite       = TunesTakeoutWrapper.each_favorite("Vz0KO4-RRwADbn9f")
        @favorite_id_array     = TunesTakeoutWrapper.get_favorites("jadieladie")

      end


      it "returns twenty pairing suggestions", :vcr do
        choices = @avocado.suggestions.count
        assert_equal choices, 20
      end

      it "will return a list of top favorites", :vcr do
        assert_equal @top_favorites.class, TunesTakeoutWrapper
        refute_nil @top_favorites
      end

      it "will return favorites for a given user id", :vcr do 
        assert_equal @favorite_id_array.class, Array 
        assert_equal @favorite_id_array.length, 10 
        refute_nil @favorite_id_array
      end

      it "can access a single favorite by url", :vcr do 
        assert_equal @single_favorite["id"], "Vz0KO4-RRwADbn9f"
        refute_nil @single_favorite 
      end 

      it "can favorite a suggestion" , :vcr do
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.favorite('jadieladie', "Vz92VPLW7wADpNDB")
        @new_count = TunesTakeoutWrapper.get_favorites("jadieladie").count

        assert_equal (@original_count), @new_count
      end

      it "can unfavorite a suggestion", :vcr do
        TunesTakeoutWrapper.favorite('jadieladie', "Vz0KNY-RRwADbn3d")
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.unfavorite('jadieladie', "Vz0KNY-RRwADbn3d")
        @new_count = TunesTakeoutWrapper.get_favorites("jadieladie").count
        assert_equal (@original_count), @new_count
      end

    end
  end
end


# I really wanted to do a test on response codes but it was pissy about string vs json
# putting a note here to ask about it on Monday

# it "can't favorite a pairing already favorited", :vcr do 
#   test = @favorite_suggestion
#   assert_equal test.response, #<Net::HTTPConflict 409 Created readbody=true>
# end 
