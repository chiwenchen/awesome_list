class RepositoryFormBuilder
  include ActiveModel::Model

  ATTRS = [:owner, :repo, :technology_name, :category_name].freeze

  attr_accessor *ATTRS

  def initialize(**args)
    args.each do |attr, value|
      setter = "#{attr}=".to_sym
      send(setter, value) if respond_to?(setter)
    end
  end

  validates *ATTRS, presence: true

  def attributes
    Hash[ATTRS.map {|attr| [attr, self.send(attr)]}]
  end
end
