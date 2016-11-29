require 'rails_helper'

describe Trail do
  it { should have_valid(:name).when('Urban Steam', 'Land of the living') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_valid(:user_id).when(1, 2) }
  
  it { should have_valid(:mood).when('Romance', 'Adventure') }
  it { should_not have_valid(:mood).when('Terrifying', 'What?') }
end
