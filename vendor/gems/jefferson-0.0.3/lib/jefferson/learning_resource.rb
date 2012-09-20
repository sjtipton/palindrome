class Jefferson::LearningResource
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON

  self.include_root_in_json = false

  ATTRIBUTES = [ :id,
                 :keys,
                 :terms,
                 :locator,
                 :identity,
                 :metadata,
                 :active ]

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
    opts[:any_tags] = opts[:any_tags] if opts[:any_tags].present?
    opts[:from] = opts[:from] if opts[:from].present?
    opts[:until] = opts[:until] if opts[:until].present?
    opts[:identity] = opts[:identity] if opts[:identity].present?
    opts[:resumption_token] = opts[:resumption_token] if opts[:resumption_token].present?
    options = opts.select { |k,v| %w(any_tags from until identity resumption_token).include?(k.to_s) && v.present? }
    options.symbolize_keys!
    query_params = options.to_param
    request = Typhoeus::Request.new(Jefferson::Config.base_url +
                                    "/slice?#{query_params}",
                                    { method: :get,
                                     timeout: Jefferson::Config.timeout }.merge(Jefferson::Config.headers))

    request.on_complete do |response|
      if response.success?
        learning_resources = []
        parsed = Yajl::Parser.parse(response.body, symbolize_keys: true)
        parsed[:documents].each do |result|
          learning_resources << new(id: result[:resource_data_description][:doc_ID],
                                  keys: result[:resource_data_description][:keys],
                                 terms: result[:resource_data_description][:TOS],
                               locator: result[:resource_data_description][:resource_locator],
                              identity: result[:resource_data_description][:identity],
                              metadata: result[:resource_data_description][:resource_data],
                                active: result[:resource_data_description][:active])
        end
        yield learning_resources
      elsif response.code == 400
        raise ActiveResource::BadRequest.new(response)
      elsif response.code == 401
        raise ActiveResource::UnauthorizedAccess.new(response)
      elsif (500..599).cover? response.code
        raise ActiveResource::ServerError.new(response)
      elsif response.timed_out?
        raise ActiveResource::TimeoutError.new(response.curl_error_message)
      else
        raise ActiveResource::ConnectionError.new(response)
      end
    end

    Jefferson::Config.hydra.queue(request)
  end

  def self.find(id)
    request = Typhoeus::Request.new(Jefferson::Config.base_url +
                                    "/harvest/getrecord?request_ID=#{id}"+
                                    "&by_doc_ID=true",
                                    { method: :get,
                                     timeout: Jefferson::Config.timeout }.merge(Jefferson::Config.headers))

    request.on_complete do |response|
      if response.code == 200
        parsed = Yajl::Parser.parse(response.body, symbolize_keys: true)
        record = parsed[:getrecord][:record].first
        resource_data = record[:resource_data]
        yield new(     id: resource_data[:doc_ID],
                     keys: resource_data[:keys],
                    terms: resource_data[:TOS],
                  locator: resource_data[:resource_locator],
                 identity: resource_data[:identity],
                 metadata: resource_data[:resource_data],
                   active: resource_data[:active])
      elsif response.code == 400
        raise ActiveResource::BadRequest.new(response)
      elsif response.code == 401
        raise ActiveResource::UnauthorizedAccess.new(response)
      elsif (500..599).cover? response.code
        raise ActiveResource::ServerError.new(response)
      elsif response.timed_out?
        raise ActiveResource::TimeoutError.new(response.curl_error_message)
      else
        raise ActiveResource::ConnectionError.new(response)
      end
    end

    Jefferson::Config.hydra.queue(request)
  end
end