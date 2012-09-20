class Jefferson::LearningResource
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON

  self.include_root_in_json = false

  ATTRIBUTES = [ :id ]

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes
    ATTRIBUTES.inject(
      ActiveSupport::HashWithIndifferentAccess.new
      ) do |result, key|

      result[key] = read_attribute_for_validation(key)
      result
      end
  end

  def attributes=(attrs)
    attrs.each_pair do |k, v|
      send("#{k}=", v)
    end
  end

  def read_attribute_for_validation(key)
    send(key)
  end

  def self.api_query(opts={})
    opts[:q] = opts[:any_tags] if opts[:any_tags].present?
    opts[:from] = opts[:from] if opts[:from].present?
    opts[:until] = opts[:until] if opts[:until].present?
    opts[:identity] = opts[:identity] if opts[:identity].present?
    opts[:ids_only] = opts[:ids_only] if opts[:ids_only].present?
    opts[:resumption_token] = opts[:resumption_token] if opts[:resumption_token].present?
    options = opts.select { |k,v| %w(q from until identity ids_only resumption_token).include?(k.to_s) && v.present? }
    options.symbolize_keys!
    query_params = options.to_param
    request = Typhoeus::Request.new("https://http://node01.public.learningregistry.net/slice?#{query_params}",
                                    { method: :get,
                                     timeout: 10 }.merge(Jefferson::Config.headers))

    request.on_complete do |response|
      if response.success?
        learning_resources = []
        parsed = Yajl::Parser.parse(response.body, symbolize_keys: true)
        parsed[:learning_resources].each do |result|
          learning_resources << new(id: result[:doc_ID])
        end
        yield learning_resources
      elsif response.code == 400
        raise ActiveResource::BadRequest.new(response)
      elsif response.code == 401
        raise ActiveResource::UnauthorizedAccess.new(response)
      elsif (500..599).cover? response.code
        raise ActiveResource::ServerError.new(response)
      elsif response.timed_out? && response.request.retries <= 0
        raise ActiveResource::TimeoutError.new(response.curl_error_message)
      else
        raise ActiveResource::ConnectionError.new(response)
      end
    end

    Jefferson::Config.hydra.queue(request)
  end
end