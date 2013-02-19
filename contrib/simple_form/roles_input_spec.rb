# encoding: UTF-8
require 'spec_helper'

describe 'roles input' do
  let!(:user) { Fabricate(:user, roles: %w{admin}) }
  let!(:inputs) {
    concat(input_for(user, :roles, as: :roles))
  }

  it 'includes two position field' do
    inputs.should have_tag('input.roles', count: 2)
    inputs.should have_tag('input#user_roles_admin', with: {checked: 'checked'})
  end
end
