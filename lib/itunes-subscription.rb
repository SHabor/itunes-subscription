require "itunes-subscription/version"
require "rest-client"

module ItunesSubscription
  def self.verify_receipt base64_string, sandbox = true, password

    payload = {
        'receipt-data': base64_string,
    }
    payload[:password] = password if password

    begin
      Receipt.new(JSON.parse(RestClient::Request.execute(
          method: :post,
          url: "https://#{ sandbox ? 'sandbox' : 'buy' }.itunes.apple.com/verifyReceipt",
          payload: payload.to_json,
          headers: {
              'Content-Type': 'application/json',
          }
      )), true)
    rescue
      Receipt.new({}, false)
    end
  end

  def self.doc
    'https://developer.apple.com/library/content/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html'
  end

  class Receipt
    def initialize(receipt, success)
      @receipt = receipt || {}
      @success = success
    end

    def status
      @receipt['status']
    end

    def status_info
      case @receipt['status']
        when 0
          'Ok'
        when 21000
          'The App Store could not read the JSON object you provided.'
        when 21002
          'The data in the receipt-data property was malformed or missing.'
        when 21003
          'The receipt could not be authenticated.'
        when 21004
          'The shared secret you provided does not match the shared secret on file for your account.'
        when 21005
          'The receipt server is not currently available.'
        when 21006
          'This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response.
Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions.'
        when 21007
          'This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead.'
        when 21008
          'This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead.'
        when 21010
          'This receipt could not be authorized. Treat this the same as if a purchase was never made.'
        else
          'Internal data access error.'
      end
    end

    def success?
      @success
    end

    def error?
      !@success
    end

    def [](key)
      @receipt[key.to_s]
    end

    def active_subscription
      begin
        return if @receipt['status'] == 21002

        active = @receipt['latest_receipt_info'].first if @receipt['latest_receipt_info']
        @receipt['latest_receipt_info'].each do |item|
          active = item if active['expires_date'].to_datetime < item['expires_date'].to_datetime && !item['cancellation_date']
        end
        active if active['expires_date'].to_datetime > DateTime.now
      rescue

      end
    end

  end
end
