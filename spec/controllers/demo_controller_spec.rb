require 'spec_helper'

describe DemoController do

  describe "GET 'run'" do
    it "returns http success" do
      get 'run'
      response.should be_success
    end
  end

end
