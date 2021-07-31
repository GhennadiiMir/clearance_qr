module ClearanceQr
  class Configuration

    def initialize
      @ws_server  = ENV[:QR_WEBSOCKET_SERVER] || "ws://ws1.mconto:8112/door"
      @api_server = ENV[:QR_API_DOMAIN] || "https://mconto.com"
      @api_token  = ENV[:QR_API_TOKEN]
    end


    # @return [ClearanceQr::Configuration] ClearanceQr's current configuration
    def self.configuration
      @configuration ||= Configuration.new
    end

    # Set ClearanceQr's configuration
    # @param config [ClearanceQr::Configuration]
    def self.configuration=(config)
      @configuration = config
    end

    # Modify ClearanceQr's current configuration
    # @yieldparam [ClearanceQr::Configuration] config current ClearanceQr config
    # ```
    # ClearanceQr.configure do |config|
    #   config.routes = false
    # end
    # ```
    def self.configure
      yield configuration
    end

  end
end
