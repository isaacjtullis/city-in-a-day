require 'rails_helper'

describe Location do
  it { should have_valid(:description).when('This place is great!', 'This place has so much potential.') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:location).when('Denver', 'Colorado') }
  it { should_not have_valid(:location).when(nil, '') }

  it { should have_valid(:name).when('Chipotle', 'Starbucks') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should have_valid(:price).when(10, 'FREE') }
  it { should_not have_valid(:price).when(300, 'WHAT') }
end
