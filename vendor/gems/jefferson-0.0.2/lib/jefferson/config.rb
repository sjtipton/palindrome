class Jefferson::Config
  class << self
    attr_accessor :host, :hydra, :timeout, :protocol

    def configure
      yield self
    end

    def base_url
      "#{self.protocol}://#{self.host}"
    end

    def headers
      { headers: { "Accept" => "application/json",
             "Content-Type" => "application/json" } }
    end
  end
end