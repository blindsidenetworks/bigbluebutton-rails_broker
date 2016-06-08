module Broker
  module BbbHelper

    def bbb_get_recordings(meeting_id)
      response_data = nil

      if !@bbb
        response_data = { :returncode => false, :messageKey => "BBBAPICallInvalid", :message => "BBB API call invalid." }
      else
        begin
          response_data = @bbb.get_recordings({:meetingID => meeting_id })
        rescue BigBlueButton::BigBlueButtonException => exc
          logger.info "Message for the log file #{exc.key}: #{exc.message}"
          response_data = { :returncode => false, :messageKey => 'BBB'+(exc.key.nil? || exc.key.empty? ? "Error" : exc.key.slice(0,1).capitalize + exc.key.slice(1..-1)), :message => exc.message }
        end
      end

      response_data
    end

  end
end
