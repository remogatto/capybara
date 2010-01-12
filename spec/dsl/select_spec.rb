module SelectSpec
  shared_examples_for "select" do
    describe "#select" do
      before do
        @session.visit('/form')
      end

      it "should select an option from a select box by id" do
        @session.select("Finish", :from => 'form_locale')
        @session.click_button('awesome')
        extract_results(@session)['locale'].should == 'fi'
      end

      it "should select an option from a select box by label" do
        @session.select("Finish", :from => 'Locale')
        @session.click_button('awesome')
        extract_results(@session)['locale'].should == 'fi'
      end

      context "with a locator that doesn't exist" do
        it "should raise an error" do
          running { @session.select('foo', :from => 'does not exist') }.should raise_error(Capybara::ElementNotFound)
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
            @session.select("Finish", :from => 'Locale')
          end.should raise_error(Capybara::InteractingWithHiddenElementError)
        end
      end
    end
  end
end  
