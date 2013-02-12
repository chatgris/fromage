# encoding: utf-8
require "spec_helper"

class Person
  include Mongoid::Document
  include Mongoid::Fromage

  fromages :time_lord, :companion
end

class User
  include Mongoid::Document
  include Mongoid::Fromage

  fromages :admin, :customer, defaults: [:customer]
end

class UserWithInvalidDefaults
  include Mongoid::Document
  include Mongoid::Fromage

  fromages :admin, :customer, defaults: [:merchant]
end

describe Mongoid::Fromage do

  let(:person) { Person.new }

  describe 'roles validation' do
    it 'should not be valid with vilain role' do
      person.add_role(:vilain)
      person.should_not be_valid
    end
  end

  describe 'adding roles' do
    context 'without save' do
      it 'should add a role to person' do
        person.add_role(:time_lord)
        person.roles.should include :time_lord
      end

      it 'should add several roles to person' do
        person.add_role(:time_lord, :companion)
        person.roles.should include :time_lord
        person.roles.should include :companion
      end
    end

    context 'with save' do
      it 'should add a role to person' do
        person.add_role!(:time_lord)
        person.reload.roles.should include :time_lord
      end

      it 'should add a role to person' do
        person.time_lord!
        person.reload.roles.should include :time_lord
      end

      it 'should add several roles to person' do
        person.add_role!(:time_lord, :companion)
        person.reload.roles.should include :time_lord
        person.reload.roles.should include :companion
      end

    end

    context 'with validation' do
      it 'several add_role should have uniq roles' do
        person.add_role(:time_lord)
        person.add_role(:time_lord)

        person.should be_valid

        person.roles.size.should eq(1)
      end
    end
  end

  describe 'removing roles' do
    context 'without save' do
      before do
        person.add_role(:time_lord, :companion)
      end

      it 'should remove role' do
        person.roles.should include :time_lord
        person.remove_role(:time_lord)
        person.roles.should_not include :time_lord
      end
    end

    context 'with save' do
      before do
        person.add_role!(:time_lord, :companion)
      end

      it 'should remove role' do
        person.reload.roles.should include :time_lord
        person.remove_role!(:time_lord)
        person.reload.roles.should_not include :time_lord
      end
    end
  end

  describe 'checking roles' do
    it 'should have time_lord role' do
      person.add_role(:time_lord)
      person.has_role?(:time_lord).should be_true
      person.time_lord?.should be_true
    end

    it 'should not have companion role' do
      person.has_role?(:companion).should_not be_true
      person.companion?.should_not be_true
    end

    describe 'checking all roles' do
      before do
        person.add_role!(:time_lord, :companion)
      end

      it 'should check all roles, and return true' do
        person.has_roles?(:time_lord, :companion).should be_true
      end

      it 'should check all roles, and return false' do
        person.has_roles?(:companion, :vilain).should_not be_true
      end
    end
  end

  describe 'scopes' do
    describe 'any_role' do
      let(:companion) {Person.create(roles: [:companion])}
      let(:river_song) {Person.create(roles: [:time_lord, :companion])}

      before do
        companion
        river_song
      end

      it 'should find person with time_lord role' do
        Person.any_role(:time_lord).count.should eq 1
        Person.all_role(:time_lord).all.first.should eq river_song
      end

      it 'should find person with time_lord role or companion role' do
        Person.any_role(:time_lord, :companion).count.should eq 2
      end
    end

    describe 'all_role' do
      let(:companion) {Person.create(roles: [:companion])}
      let(:river_song) {Person.create(roles: [:time_lord, :companion])}

      before do
        companion
        river_song
      end

      it 'should find person with time_lord role' do
        Person.all_role(:time_lord).count.should eq 1
        Person.all_role(:time_lord).all.first.should eq river_song
      end

      it 'should find person with companion role' do
        Person.all_role(:companion).count.should eq 2
      end

      it 'should find person with time_lord role and companion role' do
        Person.all_role(:time_lord, :companion).count.should eq 1
        Person.all_role(:time_lord).all.first.should eq river_song
      end
    end
  end

  describe 'default role' do
    let(:user) { User.new }
    let(:user_invalid) { UserWithInvalidDefaults.new }

    it 'can have a default role' do
      user.tap {|u| u.save }.roles.to_a.should eq [:customer]
    end

    it 'add to default role' do
      user.admin!
      user.reload.roles.should eq Set.new([:customer, :admin])
    end

    it 'should fail on invalid default role' do
      user_invalid.should_not be_valid
    end
  end
end
