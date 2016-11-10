require 'rails_helper'

describe Relationship do
  it { should have_valid(:follower_id).when('John', 'Smith') }
  it { should_not have_valid(:followed_id).when(nil, '') }
end
