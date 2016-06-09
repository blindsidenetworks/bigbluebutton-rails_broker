module Broker
  module BbbHelper

    def bbb_get_recordings(meeting_id='')
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

    def bbb_get_recording(recording_id='')
      response_data = nil

      if !recording_id.empty?
        recordings = bbb_get_recordings()
        if recordings[:returncode]
          located_recording = recordings[:recordings].select { |recording| recording[:recordID] == recording_id }
          if !located_recording.nil? && !located_recording.empty?
            response_data = { :returncode => true, :recording => located_recording[0] }
          else
            response_data = { :returncode => false, :messageKey => "BBBNotFound", :message => "Recording was not found." }
          end
        else
          response_data = { :returncode => false, :messageKey => "BBBNotFound", :message => "Recording was not found." }
        end
      else
        response_data = { :returncode => false, :messageKey => "BBBInvalidRequest", :message => "Recording ID must be included." }
      end
      
      response_data
    end

    def bbb_update_recording(recording_id, state)
      response_data = nil

      if !recording_id.empty?
          if state == 'published'
            begin
              response_data = @bbb.publish_recordings(recording_id, true)
            rescue BigBlueButton::BigBlueButtonException => exc
              logger.info "Message for the log file #{exc.key}: #{exc.message}"
              response_data = { :returncode => false, :messageKey => 'BBB'+(exc.key.nil? || exc.key.empty? ? "Error" : exc.key.slice(0,1).capitalize + exc.key.slice(1..-1)), :message => exc.message }
            end
          elsif state == 'unpublished'
            begin
              response_data = @bbb.publish_recordings(recording_id, false)
            rescue BigBlueButton::BigBlueButtonException => exc
              logger.info "Message for the log file #{exc.key}: #{exc.message}"
              response_data = { :returncode => false, :messageKey => 'BBB'+(exc.key.nil? || exc.key.empty? ? "Error" : exc.key.slice(0,1).capitalize + exc.key.slice(1..-1)), :message => exc.message }
            end
          elsif state == 'deleted'
            begin
              response_data = @bbb.delete_recordings(recording_id)
            rescue BigBlueButton::BigBlueButtonException => exc
              logger.info "Message for the log file #{exc.key}: #{exc.message}"
              response_data = { :returncode => false, :messageKey => 'BBB'+(exc.key.nil? || exc.key.empty? ? "Error" : exc.key.slice(0,1).capitalize + exc.key.slice(1..-1)), :message => exc.message }
            end
          else
            response_data = { :returncode => false, :messageKey => "BBBInvalidRequest", :message => "State was not included." }
          end  
      else
        response_data = { :returncode => false, :messageKey => "BBBInvalidRequest", :message => "Recording ID must be included." }
      end

      response_data
    end

  end
end
