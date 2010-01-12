module ChooseSpec
  shared_examples_for "choose" do

    describe "#choose" do
      before do
        @session.visit('/form')
      end

      it "should choose a radio button by id" do
        @session.choose("gender_male")
        @session.click_button('awesome')
        extract_results(@session)['gender'].should == 'male'
      end

      it "should choose a radio button by label" do
        @session.choose("Both")
        @session.click_button('awesome')
        extract_results(@session)['gender'].should == 'both'
      end

      context "with a locator that doesn't exist" do
        it "should raise an error" do
          running { @session.choose('does not exist') }.should raise_error(Capybara::ElementNotFound)
        end
      end

      context "with a locator that selects a hidden node" do
        before do
          Capybara.locate_hidden_elements = true
        end

        after do
          Capybara.locate_hidden_elements = false
        end

        it "should raise an error" do
          running do
            @session.choose("hidden_gender_male")
          end.should raise_error(Capybara::InteractingWithHiddenElementError)
        end
      end
    end
  end
end  
