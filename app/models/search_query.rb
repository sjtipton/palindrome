class SearchQuery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks

  ATTRIBUTES = [:keywords]
  attr_accessor *ATTRIBUTES

  define_model_callbacks :initializer, only: :after

  validates_presence_of :keywords
  validates_format_of :keywords, with: /\A[a-z\d \.\-\,]+\z/i,
                                message: "can only contain letters, numbers, commas, periods and hyphens",
                                allow_blank: true
  validates_length_of :keywords, maximum: 80, allow_blank: true

  after_initializer :sanitize_keywords

  def initialize(attributes = {})
    self.attributes = attributes
    self.sanitize_keywords
  end

  def attributes
    ATTRIBUTES.inject(ActiveSupport::HashWithIndifferentAccess.new) do |result, key|
      result[key] = read_attribute_for_validation(key)
      result
    end
  end

  def attributes=(attrs)
    attrs.each_pair {|k, v| send("#{k}=", v)}
  end

  def persisted?
    false
  end

  def search_results_header_text
    if self.keywords.present? && self.valid?
      header_text = "Learning Resources matching #{self.keywords.titleize}"
    end
    header_text.to_s
  end

  def sanitize_keywords
    self.keywords = Sanitize.clean(self.keywords)
  end

end