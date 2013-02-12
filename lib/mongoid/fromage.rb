# encoding: utf-8

require 'active_support/concern'
require 'mongoid'

module Mongoid
  module Fromage
    extend ::ActiveSupport::Concern

    included do
      class_attribute :fromage_defaults
      field :roles, type: Set, default: lambda { Array(self.fromage_defaults) }
      validate :roles, :valid_roles?

      scope :any_role, lambda {|*role| any_in(:roles => role)}
      scope :all_role, lambda {|*role| all_in(:roles => role)}
    end

    def add_role(*roles)
      self.roles += roles
    end

    def add_role!(*args)
      self.add_role(*args)
      self.save
    end

    def remove_role(role)
      self.roles = self.roles.delete(role)
    end

    def remove_role!(role)
      self.remove_role(role)
      self.save
    end

    def has_role?(role)
      self.roles.include? role
    end

    def has_roles?(*args)
      args.all? {|role| self.has_role?(role) }
    end

    protected

    def valid_roles?
      if (self.roles - self.class.roles).any?
        errors.add(:roles, :not_included)
      end
    end

    module ClassMethods
      attr_accessor :roles

      def fromages(*argv)
        if argv.last.is_a?(Hash)
          options = argv.pop
        end
        self.roles = argv

        # define helper methods for roles
        self.roles.each do |role|
          define_method "#{role}?" do
            self.has_role? role
          end

          define_method "#{role}!" do
            self.add_role!(role)
          end

          define_method "un_#{role}!" do
            self.remove_role!(role)
          end
        end

        if options && options.has_key?(:defaults)
          self.fromage_defaults = options[:defaults]
        end
      end
    end
  end
end
