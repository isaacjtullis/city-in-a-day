require 'rails_helper'

describe Trail do
  it { should have_valid(:description).when('This place is great!', 'This place has so much potential.') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:location).when('Denver', 'Colorado') }
  it { should_not have_valid(:location).when(nil, '') }

  it { should have_valid(:name).when('Urban Steam', 'Land of the living') }
  it { should_not have_valid(:name).when('', nil) }
end
